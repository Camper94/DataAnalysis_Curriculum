import pandas as pd
import csv
# Read the CSV file into a DataFrame
path = '/home/sofiane/Documents/6~-THE KEY-~9/ETUDE~~~STUDY/Portfolio_Projects/DataAnalysis_With_SQL/Intermediate SQL/films.csv'
new_path = '/home/sofiane/Documents/6~-THE KEY-~9/ETUDE~~~STUDY/Portfolio_Projects/DataAnalysis_With_SQL/Intermediate SQL/cleaned_file.csv'
df = pd.read_csv(path)

# Define the expected data types for each column
column_types = {
    'id': int,
    'title': str,
    'release_year': str,
    'country': str,
    'duration': float,
    'language': str,
    'certification': str,
    'gross': str,
    'budget': str
}

# Initialize an empty list to store data
data = []

#Open the CSV file and read data into the list dictionaries
with open(path, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        typed_row = {}
        for col, dtype in column_types.items():
            try:
                typed_row[col] = dtype(row[col])
            except ValueError:
                print(f"ValueError: Invalid value '{row[col]}' for column '{col}'")
                typed_row[col] = None  # Assign a default value or handle the error as needed
        data.append(typed_row)

cleaned_df = pd.DataFrame(data)

cleaned_df.to_csv(new_path, index=False)
