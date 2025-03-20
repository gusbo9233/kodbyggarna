# Environment Setup Guide

## Firebase Configuration

To set up the Firebase configuration for this application, follow these steps:

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)

2. Register your application (Web, iOS, Android) with the Firebase project

3. Create a `.env` file in the project root directory using the `.env.example` as a template:

```
# Firebase Configuration
FIREBASE_API_KEY=your_api_key_here
FIREBASE_AUTH_DOMAIN=your_auth_domain_here
FIREBASE_PROJECT_ID=your_project_id_here
FIREBASE_STORAGE_BUCKET=your_storage_bucket_here
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id_here
FIREBASE_APP_ID=your_app_id_here
FIREBASE_MEASUREMENT_ID=your_measurement_id_here
```

4. Use the FlutterFire CLI to generate the necessary configuration files:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

5. Update the relevant platform-specific files:
   - iOS: Add the GoogleService-Info.plist file to your project
   - Android: Add the google-services.json file to your project
   - Web: Update the Firebase configuration in web/index.html

## Security Best Practices

- Never commit API keys or sensitive credentials to version control
- Use environment variables for local development
- Implement proper Firebase security rules
- Use Firebase Authentication for user management
- Enable app check for additional security

## Flutter Setup

```bash
flutter pub get
flutter run -d chrome  # For web development
``` 