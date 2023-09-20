# Team JAR

This is our submission for the 2023 Uber Global Hackathon

## File Structure
All of the code files is stored in the `lib` directory. The flutter framework uses the dart programming language 
which lets it compile to target many different architectures, i.e. windows, linux, mac, ios, & android 
Each folder is a page. In each folder, there should be a .dart file that has the same name as the folder. This   file contains the presentation layer, which is the ui that the end user sees. In some folders there is also a  `bloc.dart` file. This file contains all the business logic for the page, in the form of the state. 
Each page of the application can be seen as a function that when passed a certain state displays a certain page 
We also have classes for a model, which is a POJO (plain old java object), and lets us have easy data transfer 
with our backend, firebase. The application runs from Main.dart. What each page does should be self-explanatory  from the name of the folder (ex. login-page is the login page).
