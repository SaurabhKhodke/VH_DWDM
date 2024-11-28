import numpy as np
import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules  
import warnings
warnings.filterwarnings("ignore")

# Import the CSV file (make sure to provide the correct file path)
data = pd.read_csv('ass6.csv')  # Change 'my.csv' to your actual file name if needed

# Dataset Overview
print("\n--- Dataset Overview ---")
print("First 5 rows of data:")
print(data.head())
print("\nColumns in the dataset:")
print(data.columns)
print("\nShape of the dataset (rows, columns):")
print(data.shape)
print("\nAre there any missing values? ", data.isnull().values.any())
print("Count of missing values in each column:")
print(data.isnull().sum())
print("\nUnique values in 'name' column:") 
print(data['name'].unique())

# One-hot encoding categorical columns
df_encoded = pd.get_dummies(data[['fuel', 'seller_type', 'transmission', 'owner']], drop_first=True)

# Ensure all columns are in binary format (1s and 0s)
df_encoded = df_encoded.astype(int)

# Display encoded dataframe summary
print("\n--- One-Hot Encoded Data (First 5 Rows) ---")
print(df_encoded.head())

# Apply Apriori algorithm
frequent_itemsets = apriori(df_encoded, min_support=0.7, use_colnames=True)

# Display frequent itemsets
print("\n--- Frequent Itemsets ---")
print(frequent_itemsets)  # Display all frequent itemsets
print(f"\nTotal number of frequent itemsets found: {len(frequent_itemsets)}")

# Generate association rules
rules = association_rules(frequent_itemsets, metric="confidence", min_threshold=0.7)

# Display association rules
print("\n--- Association Rules (First 2 Rules) ---")
print(rules[['antecedents', 'consequents', 'support', 'confidence', 'lift']].head())  # Only relevant columns
print(f"\nTotal number of rules generated: {len(rules)}")
