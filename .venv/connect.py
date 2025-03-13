 

from sqlalchemy import engine, URL
import json

with open('credentials.json') as f:
    credentials = json.load(f)

connection_url = URL.create(
    drivername='postgresql+psycopg2',
    username = 'postgres',
    password = 123, 
    host = 'localhost',
    port = 5432
)

def set_connection(): 
    from sqlalchemy import engine
    engine =  engine.create_engine(connection_url)
    pg = engine.connect()

    return pg