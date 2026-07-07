import os
import sys
import random
import pandas as pd
from datetime import datetime, timedelta

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from config import NUM_CUSTOMERS

FIRST_NAMES = ["Budi", "Andi", "Siti", "Dewi", "Rian", "Eko", "Putri", "Rizky", "Mega", "Dedi", "Agus", "Lani", "Bambang", "Rina"]
LAST_NAMES = ["Santoso", "Wijaya", "Pratama", "Hidayat", "Lestari", "Kusuma", "Siregar", "Purnomo", "Sari", "Gunawan"]

LOCATIONS = ["Jakarta", "Surabaya", "Bandung", "Medan", "Makassar"]
LOCATION_WEIGHTS = [40, 20, 15, 15, 10]

GENDERS = ["Male", "Female"]

def generate_customer_data(num_records):
    customers = []
    print(f">> Starting the generation of {num_records} corporate standard customer data...")
    
    start_date = datetime(2023, 1, 1)
    
    for i in range(1, num_records + 1):
        customer_id = f"CUST{i:04d}"
        
        first = random.choice(FIRST_NAMES)
        last = random.choice(LAST_NAMES)
        customer_name = f"{first} {last}"
        
        gender = random.choice(GENDERS)
        age = random.randint(18, 65)
        
        location = random.choices(LOCATIONS, weights=LOCATION_WEIGHTS, k=1)[0]
        
        random_days = random.randint(0, 1000)
        join_date = (start_date + timedelta(days=random_days)).strftime("%Y-%m-%d")
        
        customers.append({
            "CustomerID": customer_id,
            "CustomerName": customer_name,
            "Gender": gender,
            "Age": age,
            "Location": location,
            "JoinDate": join_date
        })
        
    return customers

if __name__ == "__main__":
    raw_data = generate_customer_data(NUM_CUSTOMERS)
    df_customers = pd.DataFrame(raw_data)
    
    output_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "output")
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        
    output_path = os.path.join(output_dir, "Customers.csv")
    df_customers.to_csv(output_path, index=False)
    
    print(f"\n[SUCCESS] Successfully created customer data at: {output_path}")
    print("\nHere are the top 5 customer data samples:")
    print(df_customers.head())