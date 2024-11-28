
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import matplotlib.pyplot as plt


df = pd.read_csv('C:\\VS Codes\\Python\\csv\\Dataset.csv')  


print(df.dtypes)


df['call_month'] = df['call_month'].map({
    'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6, 
    'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12
})


df_encoded = pd.get_dummies(df, columns=['occupation', 'education_level', 'marital_status', 
                                         'communication_channel', 'previous_campaign_outcome', 'conversion_status'])


print("Remaining non-numeric columns after encoding:")
print(df_encoded.select_dtypes(include=['object']).columns)


scaler = StandardScaler()
df_encoded[['age', 'call_duration', 'call_frequency']] = scaler.fit_transform(df_encoded[['age', 'call_duration', 'call_frequency']])


inertia = []
for k in range(1, 11):
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(df_encoded)
    inertia.append(kmeans.inertia_)


plt.plot(range(1, 11), inertia, marker='o')
plt.title('Elbow Method for Optimal Clusters')
plt.xlabel('Number of clusters')
plt.ylabel('Inertia')
plt.show()


optimal_clusters = 3 


kmeans = KMeans(n_clusters=optimal_clusters, random_state=42)
df_encoded['Cluster'] = kmeans.fit_predict(df_encoded)


plt.scatter(df_encoded['age'], df_encoded['call_duration'], c=df_encoded['Cluster'], cmap='viridis')
plt.title('Clusters Visualization')
plt.xlabel('Age')
plt.ylabel('Call Duration')
plt.show()


cluster_analysis = df_encoded.groupby('Cluster').mean()
print(cluster_analysis)


df_encoded.to_csv('clustered_data.csv', index=False)
