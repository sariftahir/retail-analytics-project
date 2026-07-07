import os
import sys
import random
import pandas as pd

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def generate_return_data():
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    orders_path = os.path.join(base_dir, "output", "Orders.csv")
    products_path = os.path.join(base_dir, "output", "Products.csv")
    
    if not os.path.exists(orders_path):
        print("[ERROR] Orders.csv file not found! Run order_generator.py first.")
        return
    if not os.path.exists(products_path):
        print("[ERROR] Products.csv file not found! Run product_generator.py first.")
        return
        
    df_orders = pd.read_csv(orders_path)
    df_products = pd.read_csv(products_path)
    
    print(">> Starting item return probability analysis from transaction data...")
    
    # ------------------------------------------------------------------
    # LOOKUP DICTIONARY CREATION (Your very crucial suggestion)
    # ------------------------------------------------------------------
    product_category = df_products.set_index("ProductID")["Category"].to_dict()
    
    # Consistently identify VIP/Top Customers based on shopping frequency in Orders
    cust_order_counts = df_orders["CustomerID"].value_counts().to_dict()
    
    returns = []
    return_id_counter = 1
    
    for index, row in df_orders.iterrows():
        pid = row["ProductID"]
        cid = row["CustomerID"]
        
        # If ProductID is not found in the catalog (safety guard)
        if pid not in product_category:
            continue
            
        cat = product_category[pid]
        
        # ------------------------------------------------------------------
        # 🥇 PRIORITY 1 — Base Return Rate by Category
        # ------------------------------------------------------------------
        if cat == "Electronics":
            return_rate = 0.06
        elif cat == "Furniture":
            return_rate = 0.025
        else:  # Office Supplies
            return_rate = 0.015
            
        # ------------------------------------------------------------------
        # 4️⃣ PRIORITY 4 (Promo Effect) & 5️⃣ PRIORITY 5 (Customer Effect) & 6️⃣ PRIORITY 6 (High Value Product)
        # ------------------------------------------------------------------
        # Promo Effect: If using a large discount (not NOPRMO), return probability increases (Mega Sale impulse buying)
        if row["PromotionID"] != "NOPRMO":
            return_rate += 0.02
            
        # Customer Effect: Top/VIP customers (shopping > 30x) return items less frequently because they are loyal/understand the product
        if cust_order_counts.get(cid, 0) > 30:
            return_rate -= 0.01
            
        # High Value Product: Expensive products (e.g., price > 2 million) are returned less frequently due to stricter QC
        if row["SellingPrice"] > 2000000:
            return_rate -= 0.015
            
        # Keep the rate reasonable at the lower bound
        return_rate = max(return_rate, 0.005)

        # Execute check to see if this row will result in a return
        if random.random() < return_rate:
            return_id = f"RT{return_id_counter:05d}"
            
            # ------------------------------------------------------------------
            # 🥉 PRIORITY 3 — Quantity Returned (Realistic Distribution)
            # ------------------------------------------------------------------
            order_qty = row["Quantity"]
            if order_qty == 1:
                qty_returned = 1
            else:
                # 70% return 1 item, 20% return 2 items, 10% return FULL (all purchased items)
                qty_returned = random.choices(
                    [1, 2, order_qty],
                    weights=[70, 20, 10],
                    k=1
                )[0]
                # Anticipate if the weight '2' is greater than the total order_qty purchased
                if qty_returned > order_qty:
                    qty_returned = order_qty

            # ------------------------------------------------------------------
            # 🥈 PRIORITY 2 — Reason Weight Based on Category Character
            # ------------------------------------------------------------------
            if cat == "Electronics":
                reasons = ["Defective Item", "Damaged during Delivery", "Wrong Item Shipped", "Unsatisfied with Quality"]
                reason_weights = [45, 30, 15, 10]
            elif cat == "Furniture":
                reasons = ["Damaged during Delivery", "Unsatisfied with Quality", "Wrong Item Shipped"]
                reason_weights = [50, 35, 15]
            else:  # Office Supplies
                reasons = ["Wrong Item Shipped", "Changed My Mind", "Damaged during Delivery"]
                reason_weights = [45, 35, 20]
                
            chosen_reason = random.choices(reasons, weights=reason_weights, k=1)[0]
            
            returns.append({
                "ReturnID": return_id,
                "OrderID": row["OrderID"],
                "DateKey": row["DateKey"],
                "ProductID": pid,
                "QuantityReturned": qty_returned,
                "ReturnReason": chosen_reason
            })
            return_id_counter += 1
            
    return returns

if __name__ == "__main__":
    raw_data = generate_return_data()
    
    if raw_data:
        df_returns = pd.DataFrame(raw_data)
        output_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "output")
        output_path = os.path.join(output_dir, "Returns.csv")
        df_returns.to_csv(output_path, index=False)
        
        print(f"\n[SUCCESS] Successfully created return data at: {output_path}")
        print(f"Total items returned: {len(df_returns)} items out of total transactions.")
        print("\nTop return data sample (Multi-Criteria Modification Result):")
        print("---------------------------------------------------------------------------------------------")
        print(df_returns.head())