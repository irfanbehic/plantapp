# PlantApp - Flutter Developer Case Study

PlantApp is a pixel-perfect, feature-rich Flutter application developed as a recruitment case study. The project demonstrates advanced Flutter development skills, including Clean Architecture, reactive state management with BLoC, and robust networking.

## 📱 Features

- **Onboarding Experience**: Smooth onboarding flow with persistent state handling.
- **Dynamic Paywall**: Modern subscription/paywall screen implementation.
- **Home Dashboard**: Functional home screen with category navigation and search functionality.
- **Responsive Design**: UI that adapts gracefully to different screen sizes.
- **Error Handling**: Graceful handling of network states and errors.

## 🏗️ Architecture

The project follows **Clean Architecture** principles to ensure scalability, testability, and maintainability:

- **Data Layer**: Responsible for external data sources (API with Dio, Local storage with SharedPreferences).
- **Domain Layer**: Contains the core business logic (Entities, UseCases, Repositories definitions).
- **Presentation Layer**: UI elements and state management using the BLoC pattern.

## 📦 Tech Stack & Packages

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) for predictable state management.
- **Routing**: [auto_route](https://pub.dev/packages/auto_route) for strong-typed navigation.
- **Networking**: [dio](https://pub.dev/packages/dio) for robust HTTP requests.
- **Data Modeling**: [freezed](https://pub.dev/packages/freezed) and [json_serializable](https://pub.dev/packages/json_serializable) for type-safe models.
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) for simple persistence.
- **UI & Styling**: [google_fonts](https://pub.dev/packages/google_fonts) and [flutter_svg](https://pub.dev/packages/flutter_svg).

## 🚀 Getting Started

Follow these steps to run the project locally:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/irfanbehic/plantapp.git
   cd plantapp
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code (Freezed & AutoRoute)**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the project**:
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes unit and bloc tests:
```bash
flutter test
```

