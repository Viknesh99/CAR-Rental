
 Rent a Car

 This project consists of a frontend built with Angular 16 and a backend developed in Java 17 with Spring Boot. Follow these steps to set up and run both parts of the application.

 
 Prerequisites

 Node.js: Ensure you have [Node.js](https://nodejs.org/) (v12 or higher).
 Angular CLI: Install Angular CLI globally:

 Java Development Kit (JDK): Install [JDK](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) (version 17).
 Maven: Ensure [Maven](https://maven.apache.org/) is installed.
 Database: Set up a database if required, and update database credentials in the backend configuration.

--------------------------------------------------------------------------------------------------------------------

 In the backend project, open the src/main/resources/application.properties file and update the database username and password fields:

 spring.datasource.username=your_db_username
 spring.datasource.password=your_db_password

 included the database query in the file

--------------------------------------------------------------------------------------------------------------------

 Running the Angular Frontend

1. Navigate to the Angular project directory:

2. Install dependencies:
 
   npm install

3. Run the application:

   ng serve
   
   This will serve the app at [http://localhost:4200]

4. Build for Production:

   ng build --prod

--------------------------------------------------------------------------------------------------------------------

 Running the java Backend 

 Navigate to the java project directory and run main method

--------------------------------------------------------------------------------------------------------------------

 Password 

 Admin:  email    - admin@test.com
         password - admin

 user:   email    - yuwantha@gmail.com
         password - 12345
 

