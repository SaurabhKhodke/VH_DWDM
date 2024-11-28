# Importing required libraries
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import AgglomerativeClustering
from scipy.cluster.hierarchy import dendrogram, linkage
import matplotlib.pyplot as plt
import seaborn as sns

# Loading the dataset from your local path
df = pd.read_csv(r'C:\VS Codes\Python\csv\data.csv')  # Update with your actual file name

# Data exploration (optional)
print(df.head())
print(df.info())
print(df.describe())

# Selecting features for clustering
X = df[['danceability', 'energy', 'loudness', 'tempo', 'duration_ms']]  # Example features

# Scaling the data
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Hierarchical Clustering - Dendrogram
plt.figure(figsize=(10, 7))  # Create a new figure for the dendrogram
linked = linkage(X_scaled, method='ward')
dendrogram(linked, orientation='top', distance_sort='descending', show_leaf_counts=True)
plt.title('Dendrogram')
plt.xlabel('Data Points')
plt.ylabel('Euclidean Distance')
plt.show()  # Show the dendrogram figure

# Performing Agglomerative Clustering without the 'affinity' parameter
cluster = AgglomerativeClustering(n_clusters=5, linkage='ward')  # Removed 'affinity'
labels = cluster.fit_predict(X_scaled)

# Adding the cluster labels to the original data
df['Cluster'] = labels

# Visualizing the clusters - Scatter Plot
plt.figure(figsize=(10, 7))  # Create a new figure for the scatter plot
sns.scatterplot(data=df, x='danceability', y='energy', hue='Cluster', palette='viridis', s=100)
plt.title('Song Clusters')
plt.xlabel('Danceability')
plt.ylabel('Energy')
plt.legend(title='Cluster')
plt.show()  # Show the scatter plot figure
