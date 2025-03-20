# Course Web Application Structure

## Overview
This project is a Flutter-based web application designed for students to access course materials and communicate with teachers.

## Directory Structure

```
lib/
├── main.dart           # Application entry point
├── login.dart          # User authentication 
├── register.dart       # User registration
├── adminscreen.dart    # Admin dashboard
├── lista.dart          # Course listing
├── guidelistview.dart  # Guide listing view
├── guidegetter.dart    # Service for fetching guides
├── guideviewer.dart    # Guide content viewer
├── guide.dart          # Guide model
├── guidemake.dart      # Guide creation interface
├── uploadimage.dart    # Image upload functionality
├── gptquiz.dart        # AI-powered quiz generation
├── quizscreen.dart     # Quiz interface
├── quizMaker.dart      # Quiz creation interface
├── question.dart       # Question model
└── imagetext.dart      # Image text extraction

webapp/
├── mcloudfuncs/        # Cloud functions
└── webbapp1/           # Main Flutter web application
```

## Features
- User authentication and registration
- Course material viewing
- Interactive quizzes
- Admin controls for content management
- Chat with teachers

## Technical Details
- Built with Flutter for cross-platform compatibility
- Uses Firebase for backend services (Auth, Firestore, Storage)
- Implements responsive design for mobile and desktop use 