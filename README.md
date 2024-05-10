# Welcome to Team 16's Project: OnlyFoods

Welcome to OnlyFood, an app designed to help you manage your kitchen more efficiently. OnlyFood ensures you make the most out of every ingredient in your fridge. Our app offers a variety of tools to keep track of your ingredients, prevent food waste, and connect with a community of foodies.

## Setup Instructions

### What to Download

#### 1. Visual Studio Code
Download and install Visual Studio Code (VSCode) from [here](https://code.visualstudio.com/). VSCode is a lightweight but powerful source code editor that runs on your desktop.

#### 2. Flutter and Dart Extensions for VSCode
After installing VSCode, launch the application and install the following extensions:
- **Flutter**: This extension adds support for effectively editing, refactoring, running, and reloading Flutter mobile apps.
- **Dart**: The Dart language support is also necessary for developing Flutter applications.

Install these extensions from the VSCode Marketplace by searching for "Flutter" and "Dart" in the Extensions view (`Ctrl+Shift+X`).

#### 3. Dart SDK
Follow the instructions to download and install the Dart SDK from the official Dart site: [Get Dart](https://dart.dev/get-dart).

#### 4. Flutter SDK
Download and integrate the Flutter SDK with your editor. Detailed instructions for VSCode can be found here: [Flutter Editor Setup](https://docs.flutter.dev/get-started/editor?tab=vscode).

#### 5. Java SDK
Java is required for certain development environments and applications. Download the latest version of Java from the Oracle website: [Download Java](https://www.oracle.com/java/technologies/downloads/).

### How to Run the App

### Frontend

#### Open the Flutter App Folder with VSCode or Android Studio

##### Prepare Your Project Environment
Before building your Flutter application, run the following commands in your terminal or command prompt at the root of your frontend project:

1. **Clean your Flutter build files:**
   Ensures a fresh start by removing all files in the build directory.
   ```bash
   flutter clean
2. **Fetch and install dependencies:**
   Retrieves all the necessary dependencies:
   ```base
   flutter pub get
   
**Flutter App should be ready to be build**

### Backend

#### Open the foodApp Folder with VSCode or any desired IDE that could run JAVA

Direct to:

    ``` src ```
    
   and
    
    ``` main ```
   then
   
    ```com.example.foodApp```
   finally
   
    ```FoodAppApplication.java```
**make sure to simultaneously run ```FoodAppApplication.java``` for backend and API to work.**
    
### Features of the app
### 1. **Ingredient Tracking**

   OnlyFood allows you to easily log and monitor all the ingredients in your storage. Simply enter what you have and let     our app keep a detailed inventory, so you always know what you have at home.

### 3. **Expiration Date Monitoring**

   Our app allows you to track the expiration dates of all your stored ingredients. By assuming each item is kept in its     ideal environment, the app helps you easily monitor which items are nearing their expiration date, allowing you to prioritize their use and prevent waste.

### 4. **Recipe Suggestions**

 Here at OnlyFood, you can simply select ingredients from your storage and receive related recipe suggestions. Our smart algorithm prioritizes dishes that use ingredients closest to expiration, ensuring you utilize your groceries efficiently and deliciously.

### 5. **Social Interaction**

   OnlyFood isn't just a management tool for your ingredients, it's also a social platform. Post about your meals, share recipes and interact with other users through likes, dislikes, and comments. Connect with other foodies, exchange cooking tips, and get inspired.
