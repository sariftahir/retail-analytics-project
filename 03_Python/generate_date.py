import os
import sys
import pandas as pd

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

def generate_date_dimension(start_date_str, end_date_str):
    print(f">> Starting the generation of the date dimension from {start_date_str} to {end_date_str}...")
    
    date_range = pd.date_range(start=start_date_str, end=end_date_str)
    date_records = []
    
    for dt in date_range:
        date_records.append({
            "DateKey": dt.strftime("%Y%m%d"),
            "FullDate": dt.strftime("%Y-%m-%d"),
            "DayOfWeek": dt.strftime("%A"),
            "DayNumberOfMonth": dt.day,
            "MonthName": dt.strftime("%B"),
            "MonthNumberOfYear": dt.month,
            "CalendarQuarter": f"Q{(dt.month - 1) // 3 + 1}",
            "CalendarYear": dt.year,
            "IsWeekend": 1 if dt.weekday() >= 5 else 0
        })
        
    return date_records

if __name__ == "__main__":
    raw_data = generate_date_dimension("2023-01-01", "2025-12-31")
    df_dates = pd.DataFrame(raw_data)
    
    output_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "output")
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        
    output_path = os.path.join(output_dir, "Dates.csv")
    df_dates.to_csv(output_path, index=False)
    
    print(f"\n[SUCCESS] Successfully created master date data at: {output_path}")
    print(df_dates.head())