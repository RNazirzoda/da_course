import pandas as pd
import plotly
import plotly.express as px
import streamlit as st
from sqlalchemy import create_engine
from sqlalchemy.engine.url import URL

connection_url = URL.create(
    drivername="postgresql+psycopg2",
    username="postgres",
    password="123",  
    host="localhost",
    port=5432,
)

engine = create_engine(connection_url)

@st.cache_data
def load_data():
    query = "select * from invoice;" 
    df = pd.read_sql(query, engine)
    df['invoice_date'] = pd.to_datetime(df['invoice_date'])
    return df

st.title('Chinook Sale Report')

df = load_data()

st.sidebar.header("Фильтры")

start_date = st.sidebar.date_input("Начальная дава", df['invoice_date'].min())
end_date = st.sidebar.date_input("Конечная дата", df['invoice_date'].max())

selected_country = st.sidebar.multiselect("Выберите страну", df['billing_country'].unique())

country_list = df['billing_country'].unique()
selected_country = st.sidebar.multiselect("Выберите страну", country_list, default=country_list)

min_amount, max_amount = st.sidebar.slider("Диапазон суммы счета", 
                                           float(df['total'].min()), 
                                           float(df['total'].max()), 
                                           (float(df['total'].min()), float(df['total'].max())))

filtered_df = df[
    (df['invoice_date'] >= pd.to_datetime(start_date)) &
    (df['invoice_date'] <= pd.to_datetime(end_date)) &
    (df['billing_country'].isin(selected_country)) &
    (df['total'].between(min_amount, max_amount))
]

fig1 = px.bar(
    filtered_df.groupby("billing_country", as_index=False)["total"].sum(), 
    x="billing_country", 
    y="total", 
    title="Общий доход по странам",
    labels={"total": "Доход ($)", "billing_country": "Страна"},
    color="total",
    color_continuous_scale="Viridis"
)

filtered_df["Month"] = filtered_df["invoice_date"].dt.to_period("M").astype(str)
monthly_data = filtered_df.groupby("Month", as_index=False).count()

fig2 = px.line(
    monthly_data, 
    x="Month", 
    y="invoice_id", 
    title="Количество счетов по времени", 
    labels={"invoice_id": "Число счетов", "Month": "Месяц"},
    markers=True
)

st.plotly_chart(fig1)
st.plotly_chart(fig2)

st.write("### Данные по счетам")
st.dataframe(filtered_df)




