# Calories App 🍎

A comprehensive Flutter application for tracking your daily calorie intake and nutritional goals. Built with Firebase integration and AI-powered features to make nutrition tracking effortless and intelligent.

## 🌟 Features

### Core Functionality

- **Calorie Tracking**: Log your daily food intake with detailed nutritional information
- **Goal Setting**: Set and track personalized nutrition goals for calories, protein, carbs, and fats
- **Progress Visualization**: Interactive progress indicators and visual feedback for your daily goals
- **Meal History**: View and manage your meal history with detailed breakdowns

### Smart Food Entry

- **AI Nutrition Analysis**: Upload food photos and get instant nutritional analysis using Firebase AI
- **Barcode Scanner**: Scan product barcodes for quick food entry
- **Food Search**: Search through a comprehensive food database
- **Manual Entry**: Add custom foods with detailed nutritional information

### Additional Features

- **Cross-Platform**: Runs on web and soon IOS
- **Modern UI**: Clean, intuitive interface with Material Design
- **Offline Support**: Continue tracking even without internet connection
- **Settings Management**: Customizable app settings and preferences

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.8.1)
- Dart SDK
- Firebase project setup
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/jdszekeres/calories_app.git
   cd calories_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Authentication, Realtime Database, and Firebase AI
   - Download configuration files and place them in the appropriate directories
   - Update `firebase_options.dart` with your project configuration

4. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Architecture

### Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── auth.dart                 # Authentication logic
├── firebase_options.dart     # Firebase configuration
├── pages/                    # App screens
│   ├── home_page.dart       # Dashboard with daily overview
│   ├── add_page.dart        # Food entry options
│   ├── ai_page.dart         # AI nutrition analysis
│   ├── goals_page.dart      # Goal setting and tracking
│   ├── list_page.dart       # Meal history
│   ├── settings_page.dart   # App settings
│   ├── mobile_scanner.dart  # Barcode scanning
│   └── search_food.dart     # Food search functionality
├── tools/                   # Utility classes
│   ├── ai.dart              # AI integration
│   ├── food_facts.dart      # Nutrition data models
│   ├── meal_database.dart   # Meal data management
│   ├── user_database.dart   # User data management
│   └── calculate_goals.dart # Goal calculation logic
└── widgets/                 # Reusable UI components
    ├── bottom_navbar.dart   # Navigation bar
    ├── calorie_circle.dart  # Circular progress indicator
    └── nutri_facts.dart     # Nutrition facts display
```

### Key Technologies

- **Frontend**: Flutter framework with Material Design
- **Backend**: Firebase (Auth, Realtime Database, AI)
- **Navigation**: GoRouter for declarative routing
- **State Management**: StatefulWidget and setState
- **Image Processing**: AI-powered food recognition
- **Barcode Scanning**: Mobile Scanner plugin

## 📱 Screenshots

### Home Dashboard

The main dashboard shows your daily calorie progress with visual indicators for macronutrients.

### AI Food Analysis

Upload a photo of your meal and get instant nutritional analysis powered by Firebase AI.

### Barcode Scanner

Quickly add packaged foods by scanning their barcodes.

### Goal Tracking

Set personalized nutrition goals and track your progress throughout the day.

## 🔧 Configuration

### Firebase Setup

1. Create a new Firebase project
2. Enable the following services:
   - Authentication (Email/Password, Anonymous)
   - Realtime Database
   - Firebase AI (Vertex AI)
3. Add your app configurations for all platforms
4. Download and place configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - `web/firebase-config.js`

### Environment Variables

Update `lib/firebase_options.dart` with your Firebase project configuration.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues or have questions:

- Create an issue in the GitHub repository
- Check the [Flutter documentation](https://flutter.dev/docs)
- Refer to [Firebase documentation](https://firebase.google.com/docs)

## 🎯 Roadmap

- [ ] Meal planning and recipes
- [ ] Social features and community sharing
- [ ] Advanced analytics and insights
- [ ] Machine learning for better food recognition

---

**Track your calories on the go** with this comprehensive nutrition tracking application! 🚀
