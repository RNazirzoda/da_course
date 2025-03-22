import pandas as pd
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
def get_tracks(start_date, end_date):
    query = f"""
    select 
        i.invoice_date
        , g.name as genre
        , sum(il.unit_price * il.quantity) as total_sales
    from invoice i
    join invoice_line il 
        on i.invoice_id = il.invoice_id
    join track t 
        on il.track_id = t.track_id
    join genre g 
        on t.genre_id = g.genre_id
    where 
        i.invoice_date between '{start_date}' and '{end_date}'
    group by 
        i.invoice_date, g.name
    order by 
        i.invoice_date
    """ 
    df = pd.read_sql(query, engine)
    return df


st.title('Sales based on invoices')

start_date = st.date_input('Start date', pd.to_datetime('2023-01-01'))
end_date = st.date_input('End date', pd.to_datetime('2023-12-31'))

df = get_tracks(start_date, end_date)


line_fig = px.line(
    df,
    x='invoice_date', 
    y='total_sales', 
    title='Sales by day'
)
st.plotly_chart(line_fig)

bar_fig = px.bar(
    df, 
    x='genre', 
    y='total_sales', 
    title='Sales by genre'
)
st.plotly_chart(bar_fig)