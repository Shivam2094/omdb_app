# clean_arch

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Steps for running application in Android Studio on Mac OS/Windows

- Install latest version of Android Studio. Please refer to https://developer.android.com/studio for installation procedure.
- Install Flutter version 3.0.4 in Android Studion on Mac OS/Windows. Guide for installing fliutter: https://docs.flutter.dev/get-started/install/macos
- Clone this repo locally on your system and then start a new flutter project in Android Studio. Please see for steps: https://docs.flutter.dev/development/tools/android-studio#creating-a-new-project-from-existing-source-code
- Swith to flutter stable channel by typing 'flutter channel stable' in terminal
- Run 'flutter doctor' in the terminal to make sure flutter and dart are installed correctly.
- Run 'flutter pub get' in the terminal to install rerquired dependencies.
- Run the 'main.dart' file in the emulator or android device to start the application.

# More about the application

- The application is developed using the Clean Architecture and the MVVM (Model View-Model Model) design pattern.
- Clean Architecture (adapted from https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

![Clean architecture by uncle Bob](https://github.com/Shivam2094/omdb_app/blob/master/clean_arch.png)

- MVVM design pattern (adapted from https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm)
- ![MVVM](https://github.com/Shivam2094/omdb_app/blob/master/mvvm.png)
- The application has one fetaure that displays the list of movies and their details and the fetaure is divided into three layers - Data, Domain, Presentation. 
- The presentation layer is responsible for displaying app screens and managing UI of the application through various widgets. The presentation layer also holds View-Models. View-Models receive data request from Views(Activities and Widgets) and then update the state of widgets through events coneveyed to the views by ChangeNotifier and Provider package.
- The domain layer is not susceptible to changes in the data sources and is independent of the front-end framework used for managing the UI. It is reponsible of managing the business logic through use cases and business objects (entities). 
- The abstract repository class in domain layer makes use cases independent of data layer (data sources -> local database or remote servers). This abstract class is a contract of what repository must do and its implemented using the repository class in data layer.
- The data layer is responsible for fetching data from remote database or local databases inside the device. The data layer holds the data model which is then passed as entity to the presentation layer. The use of models makes it flexible to have data from the source in any format (XML, Json, etc.) and therefore makes the architecture loosely coupled.
