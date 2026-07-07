import os
import random
import sys  # Tambahan baru
import pandas as pd

# Taruh kode modifikasi path ini tepat di bawah import library biasa:
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Baru panggil config setelah path-nya diatur
from config import NUM_PRODUCTS 

CATEGORY_STRUCTURE = {
    "Electronics": ["Laptop", "Monitor", "Keyboard", "Mouse", "Speaker"],
    "Furniture": ["Office Chair", "Office Desk", "Bookshelf", "Cabinet", "Meeting Table"],
    "Office Supplies": ["Notebook", "Pen", "Marker", "Stapler", "Folder"]
}

BRAND_BY_CATEGORY = {
    "Electronics": ["Samsung", "Apple", "Mi", "Logitech"],
    "Furniture": ["IKEA", "Informa", "Olympic", "Ace"],
    "Office Supplies": ["Joyko", "Paperline", "Kenko"] 
}

PRODUCT_MODIFIERS = {
    "Laptop": ["Pro", "Ultra Slim", "Gaming"],
    "Monitor": ["4K UHD", "Curved", "Gaming"],
    "Keyboard": ["Mechanical", "Wireless", "Ergonomic"],
    "Mouse": ["Silent", "Wireless", "RGB Ergonomic"],
    "Speaker": ["Bluetooth Waterproof", "Soundbar", "Bass Booster"],
    
    "Office Chair": ["Ergonomic", "Executive", "Mesh"],
    "Office Desk": ["Standing", "Wooden", "Minimalist"],
    "Bookshelf": ["5-Tier", "Compact", "Modern"],
    "Cabinet": ["Metal", "Wood", "Sliding"],
    "Meeting Table": ["Large", "Round", "Conference"],
    
    "Notebook": ["A5 Hardcover", "Spiral Linier", "Grid Bulanan"],
    "Pen": ["Gel 0.5mm", "Ballpoint Hitam", "Stylus 2-in-1"],
    "Marker": ["Permanent", "Whiteboard", "Highlighter Pastel"],
    "Stapler": ["Heavy Duty", "Mini", "Paperless"],
    "Folder": ["Plastic L-Shape", "Ring Binder", "Document Bag"]
}

COST_RANGE = {
    "Electronics": (500000, 15000000),
    "Furniture": (800000, 7000000),
    "Office Supplies": (5000, 100000)
}

MARGIN_RANGE = {
    "Electronics": (0.10, 0.25),
    "Furniture": (0.18, 0.35),
    "Office Supplies": (0.15, 0.35)
}

INVENTORY_RULES = {
    "Electronics": {
        "reorder_range": (5, 20),
        "lead_time_range": (7, 21)
    },
    "Furniture": {
        "reorder_range": (3, 12),
        "lead_time_range": (14, 35)
    },
    "Office Supplies": {
        "reorder_range": (50, 200),
        "lead_time_range": (2, 7)
    }
}

def generate_product_data(num_records):
    products = []
    print(f">> Memulai pembuatan {num_records} data produk standar korporat...")
    
    for i in range(1, num_records + 1):
        product_id = f"PRD{i:06d}"
        
        category = random.choice(list(CATEGORY_STRUCTURE.keys()))
        subcategory = random.choice(CATEGORY_STRUCTURE[category])
        brand = random.choice(BRAND_BY_CATEGORY[category])
        
        modifier = random.choice(PRODUCT_MODIFIERS[subcategory])
        product_name = f"{brand} {modifier} {subcategory}"
        
        min_cost, max_cost = COST_RANGE[category]
        unit_cost = random.randint(min_cost, max_cost)
        
        min_margin, max_margin = MARGIN_RANGE[category]
        margin = random.uniform(min_margin, max_margin)
        selling_price = int(unit_cost * (1 + margin))
        
        rules = INVENTORY_RULES[category]
        reorder_point = random.randint(*rules["reorder_range"])
        lead_time_days = random.randint(*rules["lead_time_range"])
        
        status = random.choices(["Active", "Discontinued"], weights=[98, 2], k=1)[0]
        
        products.append({
            "ProductID": product_id,
            "ProductName": product_name,
            "Category": category,
            "SubCategory": subcategory,
            "Brand": brand,
            "UnitCost": unit_cost,
            "SellingPrice": selling_price,
            "ReorderPoint": reorder_point,
            "LeadTimeDays": lead_time_days,
            "Status": status
        })
        
    return products

if __name__ == "__main__":
    raw_data = generate_product_data(NUM_PRODUCTS)
    df_products = pd.DataFrame(raw_data)
    
    output_dir = "output"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        
    output_path = os.path.join(output_dir, "Products.csv")
    df_products.to_csv(output_path, index=False)
    
    print("\n 5 sampel data teratas setelah Refactoring:")
    print("---------------------------------------------------------------------------------------------")
    print(df_products[["ProductID", "ProductName", "Category", "ReorderPoint", "LeadTimeDays", "Status"]].head())