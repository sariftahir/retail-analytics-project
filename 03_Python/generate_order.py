import os
import sys
import random
import pandas as pd

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from config import NUM_ORDERS

def generate_order_data(num_records):
    print(f">> Starting the generation of {num_records} retail transaction data...")
    
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    df_cust = pd.read_csv(os.path.join(base_dir, "output", "Customers.csv"))
    df_prod = pd.read_csv(os.path.join(base_dir, "output", "Products.csv"))
    df_prom = pd.read_csv(os.path.join(base_dir, "output", "Promotions.csv"))
    df_date = pd.read_csv(os.path.join(base_dir, "output", "Dates.csv"))
    
    cust_ids = df_cust["CustomerID"].tolist()
    prod_ids = df_prod["ProductID"].tolist()
    promo_ids = df_prom[df_prom["PromoType"] != "Free Shipping"]["PromotionID"].tolist() 
    date_keys = df_date["DateKey"].tolist()
    
    # Fetch Category data to determine shopping behavior rules
    prod_dict = df_prod.set_index("ProductID")[["UnitCost", "SellingPrice", "Category", "SubCategory"]].to_dict("index")
    promo_dict = df_prom.set_index("PromotionID")[["DiscountValue", "MinimumSpend"]].to_dict("index") 

    # ------------------------------------------------------------------
    # PRIORITY 1 — Customer Weight (Pareto Rule: Top Customers contribute significantly)
    # ------------------------------------------------------------------
    customer_weights = []
    for i, cid in enumerate(cust_ids):
        if i < 10:
            customer_weights.append(15)   # Top 10 Customers (Very active)
        elif i < 50:
            customer_weights.append(7)    # Next 40 Customers (Active)
        else:
            customer_weights.append(2)    # Remaining (Regular)

    # ------------------------------------------------------------------
    # DATE WEIGHTS: seasonal (month) + yearly growth + weekend boost
    # ------------------------------------------------------------------
    month_weight = {1: 0.80, 2: 0.85, 3: 0.95, 4: 1.00, 5: 1.05, 6: 1.10, 
                    7: 1.08, 8: 1.02, 9: 0.95, 10: 1.10, 11: 1.30, 12: 1.50}
    year_weight = {2022: 1.0, 2023: 1.2, 2024: 1.5, 2025: 1.8}

    date_weights = []
    for _, row in df_date.iterrows():
        w = month_weight[row["MonthNumberOfYear"]]
        w *= year_weight[row["CalendarYear"]]
        if row["IsWeekend"] == 1:
            w *= 1.20
        date_weights.append(w)

    date_month_lookup = df_date.set_index("DateKey")["MonthNumberOfYear"].to_dict()

    # ------------------------------------------------------------------
    # PRIORITY 2 & 3 — Product Popularity & Category Weight
    # ------------------------------------------------------------------
    # Macro sales portion weight between categories
    category_macro_weight = {
        "Electronics": 0.45,
        "Office Supplies": 0.35,
        "Furniture": 0.20
    }
    
    product_weights = []
    for pid in prod_ids:
        cat = prod_dict[pid]["Category"]
        subcat = prod_dict[pid]["SubCategory"]
        
        # Popularity Score Logic Based on Subcategory / Product Character (not raw price)
        # High-tier products/Core needs are set as Best Sellers
        if subcat in ["Laptop", "Office Chair", "Pen", "Notebook"]:
            popularity_score = 10  # Best Seller
        elif subcat in ["Monitor", "Office Desk", "Marker", "Mouse"]:
            popularity_score = 6   # Normal
        else:
            popularity_score = 2   # Slow Moving
            
        # Combined Macro Category Weight * Micro Product Popularity Score
        final_w = category_macro_weight[cat] * popularity_score
        product_weights.append(final_w)

    orders = []
    
    for i in range(1, num_records + 1):
        order_id = f"ORD{i:06d}"
        
        # Fetch Customer based on Pareto distribution weights
        customer_id = random.choices(cust_ids, weights=customer_weights, k=1)[0]
        
        # Fetch Product based on Category Weight + Popularity Score combination
        product_id = random.choices(prod_ids, weights=product_weights, k=1)[0]
        
        date_key = random.choices(date_keys, weights=date_weights, k=1)[0]
        
        # Extract base data of the selected product
        cat = prod_dict[product_id]["Category"]
        unit_cost = prod_dict[product_id]["UnitCost"]
        selling_price = prod_dict[product_id]["SellingPrice"]
        
        # ------------------------------------------------------------------
        # PRIORITY 6 — High Value Order (3% Chance of Corporate Order)
        # ------------------------------------------------------------------
        is_corporate_order = random.random() < 0.03
        
        # ------------------------------------------------------------------
        # PRIORITY 4 — Quantity Based on Category
        # ------------------------------------------------------------------
        if is_corporate_order:
            # If corporate order, quantity spikes high regardless of category
            quantity = random.randint(20, 100)
        else:
            # Normal rules per product category
            if cat == "Office Supplies":
                quantity = random.choices(
                    [1, 2, 3, 4, 5, 10, 15, 20],
                    weights=[30, 25, 15, 10, 10, 5, 3, 2],
                    k=1
                )[0]
            elif cat == "Electronics":
                quantity = random.choices([1, 2, 3], weights=[80, 15, 5], k=1)[0]
            elif cat == "Furniture":
                quantity = random.choices([1, 2], weights=[90, 10], k=1)[0]
                
        gross_revenue = selling_price * quantity
        
        promotion_id = "NOPRMO"
        discount_applied = 0

        # ------------------------------------------------------------------
        # PRIORITY 5 — Promo Based on Category & Discount Variability
        # ------------------------------------------------------------------
        # Base probability based on product category
        if cat == "Electronics":
            promo_probability = 0.50
        elif cat == "Office Supplies":
            promo_probability = 0.30
        elif cat == "Furniture":
            promo_probability = 0.15
            
        # Modify probability based on seasonal month (Nov-Dec / Mid-year)
        month_num = date_month_lookup[date_key]
        if month_num in [11, 12]:
            promo_probability += 0.20
        elif month_num in [6, 7]:
            promo_probability += 0.10
        
        if random.random() < promo_probability:
            potential_promo = random.choice(promo_ids)
            min_spend = promo_dict[potential_promo]["MinimumSpend"]
            
            if gross_revenue >= min_spend:
                promotion_id = potential_promo
                disc_val = promo_dict[potential_promo]["DiscountValue"]
                
                if pd.isna(disc_val) or disc_val == 0:
                    discount_applied = 0
                else:
                    # Add random variability of ±5% from the default discount value
                    variability_factor = random.uniform(0.95, 1.05)
                    
                    if disc_val <= 1.0: # Discount as Percentage (e.g., 0.10 for 10%)
                        final_disc_pct = disc_val * variability_factor
                        # Keep the discount percentage from jumping too drastically beyond logic
                        final_disc_pct = min(max(final_disc_pct, 0.01), 0.90)
                        discount_applied = int(gross_revenue * final_disc_pct)
                    else: # Discount as Flat/Nominal Cash Value (e.g., 50000)
                        final_disc_nominal = disc_val * variability_factor
                        discount_applied = int(final_disc_nominal)
                        
                    # Safeguard to prevent the discount amount from exceeding Gross Revenue
                    discount_applied = min(discount_applied, gross_revenue)
                    
        net_revenue = gross_revenue - discount_applied
        total_cost = unit_cost * quantity
        
        orders.append({
            "OrderID": order_id,
            "CustomerID": customer_id,
            "ProductID": product_id,
            "PromotionID": promotion_id,
            "DateKey": date_key,
            "Quantity": quantity,
            "UnitCost": unit_cost,
            "SellingPrice": selling_price,
            "GrossRevenue": gross_revenue,
            "DiscountApplied": discount_applied,
            "NetRevenue": net_revenue,
            "TotalCost": total_cost
        })
        
    return orders

if __name__ == "__main__":
    raw_data = generate_order_data(NUM_ORDERS)
    df_orders = pd.DataFrame(raw_data)
    
    output_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "output")
    output_path = os.path.join(output_dir, "Orders.csv")
    df_orders.to_csv(output_path, index=False)
    
    print(f"\n[SUCCESS] Successfully created transaction data at: {output_path}")
    print("\nTop transaction data sample (High-Performance Refactoring Result):")
    print("---------------------------------------------------------------------------------------------")
    print(df_orders.head())