# ems

A new Flutter project.

## Getting Started

ACES Application - Setup Guide
## Overview
This repository contains the code for the ACES app with the package name com.mekongnet.aces
The app is designed to use Firebase for push notifications. 
This guide will help you configure Firebase with a new account and prepare the app for deployment on both Google Play Store and Apple App Store.

## Prerequisites
Android Studio (latest version)
Xcode (latest version for iOS)
Firebase account
Java Development Kit (JDK) 8+
Flutter SDK 
Google Play Console and Apple App Store credentials for app submission
(Flutter 3.22.2 • https://github.com/flutter/flutter.git
Dart 3.4.3 
)
## API URL setup: Configuring .env for API URL
This Flutter application uses a .env file to manage environment variables, including the API URL. To change the API_URL to your desired API endpoint, follow these steps:
1. Create the .env file
If it doesn’t already exist, create a .env file in the root directory of your Flutter project.
2. .env file structure
The .env file should look like this:
   ```env
   API_URL=https://example.com/api
   ```
   Replace https://example.com/api with your API URL.
3. Install the dotenv package
Make sure you’ve added the flutter_dotenv package to your pubspec.yaml file:
   ```yaml
   dependencies:
   flutter_dotenv: ^5.0.2
   ```
Install the package by running the following command:
   ```bash
   flutter pub get
   ```
## Firebase setup guide:

1. Create a Project with Firebase Console 
    - Log in to Firebase: If you have a Google account, visit the Firebase Console https://firebase.google.com/, log in with your Google account, and then click Go to Console.
    - Create a Project: In the Firebase Console, click Add Project. Follow the instructions to create a project (example: aces). 
      Note: Do not enable Google Analytics for this project since it won’t be used in this project.

2. Project Settings:
After the project is created, navigate to Project Settings by clicking the gear icon next to Project Overview.
Note: Every Firebase project has a Project ID that uniquely identifies the project. This ID might be different from the Project Name and will be used later to set up FlutterFire.
 
3. Set Up Firebase CLI
Install Firebase CLI:
If you already have Firebase CLI set up, you can skip this step.
   - Download and Install Firebase CLI:
   Visit the Firebase CLI Reference https://firebase.google.com/docs/cli to download and install the Firebase CLI.

   - Log in to Firebase:
   Once installed, log in to Firebase using your Google account by running the following command in the terminal:
   `firebase login`

4. Set Up FlutterFire
   - Install Firebase Core: Add Firebase Core to your Flutter project by running the following command:
   `flutter pub add firebase_core`

   - Install Firebase Messaging: To integrate Firebase Cloud Messaging (FCM), add the Firebase Messaging plugin to your project:
   `flutter pub add firebase_messaging`

   - Install FlutterFire CLI: Install FlutterFire CLI by running the following command:
   `dart pub global activate flutterfire_cli`

   - Configure Firebase Project in Flutter: Use the following command to configure the Firebase project in Flutter, replacing project_id with your Firebase Project ID:
   `flutterfire configure --project=project_id` (Project id is project ID in FireBase Console)
   Use the arrow keys and space bar to select platforms (Android, iOS), or press Enter to use the default platforms.

5. Set up Android app:
   - Download the google-services.json file. 
   - Place the google-services.json file in the app/ directory of the Android project.
6. Set up IOS app:
   - Download the GoogleService-Info.plist file.
   - Open Xcode and drag the GoogleService-Info.plist file into the project navigator in Xcode (usually under the Runner folder for Flutter projects).
   - Ensure that Firebase dependencies are added to your Podfile:
   `pod 'Firebase/Messaging'`
   Run the following command to install the dependencies:
       ```bash
       cd ios/
       pod install
       ```
   - Integrating the Cloud Messaging plugin on iOS & macOS following the document: https://firebase.flutter.dev/docs/messaging/apple-integration/
   - 
## Troubleshooting
Ensure the google-services.json (Android) or GoogleService-Info.plist (iOS) file is correctly placed in the project directory.
Verify that the Firebase SDK versions are correctly updated in the build.gradle or Podfile.
For Android, ensure that the app has internet permissions in the AndroidManifest.xml.


