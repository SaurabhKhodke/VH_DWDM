import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules


df = pd.read_csv('C:\\VS Codes\\Python\\csv\\food.csv')
 


df_transformed = df.apply(lambda row: [f"{col}_{row[col]}" for col in df.columns], axis=1)


transactions = df_transformed.tolist()


basket = pd.DataFrame(transactions)
basket = basket.stack().groupby(level=0).apply(lambda x: ','.join(x)).str.get_dummies(sep=',')


frequent_itemsets = apriori(basket, min_support=0.4, use_colnames=True)


rules = association_rules(frequent_itemsets, metric="lift", min_threshold=1)

print("Frequent Itemsets:")
print(frequent_itemsets)

print("\nAssociation Rules:")
print(rules)
