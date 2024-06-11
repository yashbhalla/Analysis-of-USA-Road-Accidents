# Analysis of USA Road Accidents

This repository contains a web application developed to analyze road accident data from 2016-2023 using JavaScript and Java. The application processes 7 million datasets to identify high accident rate regions.

<img width="468" alt="image" src="https://github.com/yashbhalla/Analysis-of-USA-Road-Accidents/assets/53651804/f0d350cd-4021-4c4e-917d-fbc98c6d1e8b">

Below shown are the transformation of strong entity sets from the ER diagram displayed above:

- Accident
(
Accident_ID : string,
Start_Time : timestamp,
End_Time : timestamp,
Severity : number,
Distance_Affected : number
)

- AccidentLocation
(
Location_ID : string,
Street_Name : string,
City : string,
Zipcode : string,
Timezone : string
)

- Weather
(
Weather_ID : string,
Temperature : number,
Humidity : number,
Pressure : number,
Precipitation : number,
Visibility : number,
Wind_Speed : number,
Wind_Chill : number,
Time_Of_Day : string
)

- StateArea
(
State_Name : string,
State_Area : number
)

- CountyArea
(
County_ID : string,
County : string,
County_Area : number,
State_Name : string
)


## Features
- Data Analysis: Utilizes Python and MySQL for detailed analysis.
- Visualizations: State-wise trend analysis for accident density, traffic severity, weather safety index, average roadblock duration, and accident-prone factors.
- Real-Time Insights: Provides insights to improve road safety and reduce accident rates.

## Technologies Used
- JavaScript
- Java
- Python
- MySQL

## How to Run
- Clone the repository.
- Set up the environment according to the instructions.
- Run the application.

## Contributing
Feel free to fork this repository and submit pull requests. For major changes, please open an issue first to discuss your ideas.
Thank you for checking out the Road Accident Analysis Web Application!
