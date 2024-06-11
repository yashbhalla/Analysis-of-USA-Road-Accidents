import oracledb
import pandas as pd

passw = "MvbW2qcKgsjxmGqahWo5L8Y4"

connection = oracledb.connect(
    user="yash.bhalla",
    password=passw,
    dsn="oracle.cise.ufl.edu:1521/orcl")
print("CONNECTION SUCCESS")

county = pd.read_csv("county.csv")

mycursor = connection.cursor()
insert_query = "INSERT INTO weather (Weather_ID, Temperature, Humidity, Pressure, Wind_Speed, Wind_Chill, Visibility, Precipitation, Time_Of_Day) VALUES ('%s', %f, %f, %f,%f,%f,%f,%f,'%s')"


for i, row in weather.iterrows():
    #   print(row['ID'], row['Temperature(F)'],row['Humidity(%)'], row['Pressure(in)'], row['Wind_Speed(mph)'],row['Wind_Chill(F)'], row['Visibility(mi)'],row['Precipitation(in)'], row['Sunrise_Sunset'])
    val = (row['ID'], row['Temperature(F)'], row['Humidity(%)'], row['Pressure(in)'], row['Wind_Speed(mph)'],
           row['Wind_Chill(F)'], row['Visibility(mi)'], row['Precipitation(in)'], row['Sunrise_Sunset'])
    st = insert_query % val
    print(st)

#   break
#   mycursor.execute(insert_query, val)
    print("INSERTED ROW")

mycursor.execute("SELECT * FROM weather")

myresult = mycursor.fetchall()

for x in myresult:
    print(x)
