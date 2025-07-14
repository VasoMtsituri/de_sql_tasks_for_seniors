import pandas as pd

df_sales = pd.read_csv('sales.csv', header=0)
df_customers = pd.read_csv('customers.csv', header=0)
df_products = pd.read_csv('products.csv', header=0)

df = (df_sales
      .merge(df_customers, how='left', on='customer_id')
      .merge(df_products, how='left', on='product_id'))

df['revenue'] = df['quantity_sold'] * df['unit_price']

# Group by customer and product, then sum the revenue
grouped_revenue = df.groupby(['customer_name', 'product_name'])['revenue'].sum().reset_index()

print("\nGrouped Revenue:")
print(grouped_revenue)

