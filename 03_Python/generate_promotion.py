import os
import sys
import random
import pandas as pd
from datetime import datetime, timedelta

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from config import NUM_PROMOTIONS

today = datetime.today()


def random_date():
    start = today - timedelta(days=180)
    end = today + timedelta(days=90)

    start_date = start + timedelta(
        days=random.randint(0, (end - start).days)
    )

    duration = random.randint(5, 30)
    end_date = start_date + timedelta(days=duration)

    return start_date, end_date


def generate_promotion_data(num_records):

    promotions = []

    for i in range(1, num_records + 1):

        promo_id = f"PRM{i:04d}"

        promo_type = random.choices(
            [
                "Percentage Discount",
                "Fixed Cashback",
                "Free Shipping",
                "Buy 1 Get 1"
            ],
            weights=[45, 25, 20, 10],
            k=1
        )[0]

        # ==========================================
        # Percentage Discount
        # ==========================================

        if promo_type == "Percentage Discount":

            discount = random.choice([0.05, 0.10, 0.15, 0.20, 0.25])

            minimum = random.choice([
                100000,
                200000,
                300000,
                500000
            ])

            max_discount = {
                0.05: 25000,
                0.10: 50000,
                0.15: 75000,
                0.20: 100000,
                0.25: 125000
            }[discount]

            campaign = random.choice([
                "Flash Sale",
                "Weekend Sale",
                "Mega Sale",
                "Holiday Sale",
                "Midnight Deals",
                "Payday Sale",
                "Super Saving",
                "Hot Deals"
            ])

            name = f"{campaign} {int(discount * 100)}%"

        # ==========================================
        # Fixed Cashback
        # ==========================================

        elif promo_type == "Fixed Cashback":

            discount = random.choice([
                10000,
                25000,
                50000,
                75000,
                100000
            ])

            minimum = discount * random.choice([5, 6, 7])

            max_discount = discount

            campaign = random.choice([
                "Payday Cashback",
                "Weekend Cashback",
                "Mega Cashback",
                "Member Cashback",
                "Special Cashback"
            ])

            cashback_label = f"Rp{int(discount/1000)}K"

            name = f"{campaign} {cashback_label}"

        # ==========================================
        # Free Shipping
        # ==========================================

        elif promo_type == "Free Shipping":

            discount = None

            minimum = random.choice([
                0,
                50000,
                100000
            ])

            max_discount = None

            name = random.choice([
                "Free Shipping",
                "Weekend Free Shipping",
                "Free Delivery",
                "National Free Shipping",
                "Express Shipping Promo"
            ])

        # ==========================================
        # Buy 1 Get 1
        # ==========================================

        else:

            discount = None

            minimum = random.choice([
                100000,
                150000,
                200000
            ])

            max_discount = None

            name = random.choice([
                "Buy 1 Get 1",
                "BOGO Special",
                "Double Deal"
            ])

        # ==========================================
        # Promotion Period
        # ==========================================

        start_date, end_date = random_date()

        if end_date < today:
            status = "Expired"
        elif start_date > today:
            status = "Upcoming"
        else:
            status = "Active"

        # ==========================================
        # Channel Distribution
        # ==========================================

        channel = random.choices(
            [
                "All Channels",
                "Mobile App",
                "Website"
            ],
            weights=[60, 25, 15],
            k=1
        )[0]

        # ==========================================
        # Customer Segment Distribution
        # ==========================================

        segment = random.choices(
            [
                "All Customers",
                "New Customers",
                "Returning Customers",
                "VIP Members"
            ],
            weights=[50, 20, 20, 10],
            k=1
        )[0]

        promotions.append({

            "PromotionID": promo_id,
            "PromotionName": name,
            "PromoType": promo_type,
            "DiscountValue": discount,
            "MinimumSpend": minimum,
            "MaximumDiscount": max_discount,
            "StartDate": start_date.date(),
            "EndDate": end_date.date(),
            "Status": status,
            "Channel": channel,
            "CustomerSegment": segment
        })

    promotions.append({

    "PromotionID": "NOPRMO",
    "PromotionName": "No Promotion",
    "PromoType": "None",    
    "DiscountValue": None,
    "MinimumSpend": None,
    "MaximumDiscount": None,
    "StartDate": None,
    "EndDate": None,
    "Status": "Active",
    "Channel": "All Channels",
    "CustomerSegment": "All Customers"
    })

    return promotions


if __name__ == "__main__":

    raw_data = generate_promotion_data(NUM_PROMOTIONS)

    df_promotions = pd.DataFrame(raw_data)

    output_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
        "output"
    )

    os.makedirs(output_dir, exist_ok=True)

    output_path = os.path.join(output_dir, "Promotions.csv")

    df_promotions.to_csv(output_path, index=False)

    print("\nSample Corporate Promotion Data")
    print("-" * 120)
    print(df_promotions.head())