# 🚍 MyBus - Real-Time Transportation Management Platform

A comprehensive Flutter-based mobile application for real-time bus tracking, ticket booking, and transportation management. Built with modern architecture patterns, supporting multi-role access (Super Admin, Admin, Vehicle, User), live GPS tracking via WebSocket, interactive maps, and intelligent trip planning.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Building the App](#building-the-app)
- [Testing](#testing)
- [Development Workflow](#development-workflow)
- [Key Components](#key-components)
- [API Integration](#api-integration)
- [Future Enhancements](#future-enhancements)

---

## 🎯 Overview

**MyBus** is a production-ready Flutter application designed for transportation management with the following key capabilities:

- **Multi-Role System**: Supports Super Admin, Admin, Vehicle operators, and regular Users
- **Real-Time Tracking**: WebSocket-based live vehicle location updates
- **Smart Booking**: Online ticket booking with payment integration
- **Interactive Maps**: Google Maps integration with route visualization
- **Trip Planning**: Intelligent route suggestions and trip planning
- **Offline Support**: Local caching and background sync capabilities
- **Observability**: Comprehensive error tracking with Sentry and Firebase Crashlytics

The architecture is designed for scalability, maintainability, and future AI integrations.

---

## ✨ Features

### 🔐 Authentication & Authorization
- Multi-role authentication (Super Admin, Admin, Vehicle, User)
- Role-based access control
- Secure session management
- Persistent login state

### 🎫 Booking System
- Online ticket booking
- Booking history and details
- Payment integration
- Booking status tracking (Pending, Confirmed, Cancelled, Completed)

### 📍 Live Tracking
- Real-time vehicle location updates via WebSocket
- GPS-based location tracking
- Vehicle status management (Active, Inactive, Maintenance)
- Route and direction updates

### 🗺 Maps & Navigation
- Interactive Google Maps integration
- Route visualization
- Nearby vehicle discovery
- Real-time ETA calculations

### 🔎 Search & Discovery
- Global search (stops, vehicles, routes, trips)
- Place autocomplete
- Route search with suggestions
- Filter and sort capabilities

### 👥 Admin Features
- Vehicle management
- Route management
- Booking oversight
- User registration for vehicles
- Banner management (Super Admin)

### 📊 Analytics & Monitoring
- Firebase Analytics integration
- Sentry error tracking
- Firebase Crashlytics
- Custom logging system

### 🎨 UI/UX
- Material Design 3
- Dark/Light theme support
- Responsive design with ScreenUtil
- Custom Poppins font family
- Smooth animations with Lottie

---

## 🏗 Architecture

### Architecture Pattern
**Feature-First + Domain Driven Design (DDD)**

The project follows a clean architecture approach with clear separation of concerns:

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (Screens, Widgets, Providers)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│       Domain Layer                  │
│  (Entities, Repositories, UseCases) │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        Data Layer                   │
│  (Models, Remote/Local DataSources) │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Core Services                  │
│  (Network, Cache, Location, etc.)  │
└─────────────────────────────────────┘
```

### State Management
**Riverpod** is used for state management with:
- `StateNotifier` for simple state
- `AsyncNotifier` for async operations
- `StreamProvider` for real-time data (WebSocket, location streams)
- Provider composition for dependency injection

### Why Riverpod?
- ✅ Excellent for handling real-time streams
- ✅ Scales well to large applications
- ✅ Low boilerplate, high readability
- ✅ Compile-time safety
- ✅ Perfect for composition-based architecture
- ✅ Built-in error handling and loading states

---

## 🛠 Tech Stack

### Core Framework
- **Flutter** `^3.5.3` - Cross-platform UI framework
- **Dart** - Programming language

### State Management & Dependency Injection
- **flutter_riverpod** `^2.6.1` - State management
- **riverpod_annotation** `^2.6.1` - Code generation for Riverpod
- **get_it** `^8.0.2` - Service locator (optional)

### UI & Design
- **google_fonts** `^6.1.0` - Custom fonts
- **flutter_screenutil** `^5.9.3` - Responsive design
- **lottie** `^3.1.2` - Animations
- **cupertino_icons** `^1.0.8` - iOS-style icons

### Data & Serialization
- **freezed** `^2.5.2` - Immutable data classes
- **json_serializable** `^6.8.0` - JSON serialization
- **equatable** `^2.0.7` - Value equality

### Routing
- **go_router** `^14.8.0` - Declarative routing with guards

### Localization
- **easy_localization** `^3.0.8` - Multi-language support

### Network & WebSocket
- **dio** `^5.7.0` - HTTP client
- **http** `^1.2.2` - Additional HTTP utilities
- **web_socket_channel** `^2.4.0` - WebSocket support

### Local Storage
- **shared_preferences** `^2.3.2` - Key-value storage
- **hive** `^2.2.3` - Fast NoSQL database
- **sqflite** `^2.3.3+2` - SQLite database
- **drift** `^2.18.0` - Type-safe SQLite ORM

### Maps & Location
- **google_maps_flutter** `^2.9.0` - Google Maps integration
- **flutter_map** `^7.0.2` - Alternative map solution
- **geolocator** `^13.0.1` - Location services
- **geocoding** `^3.0.0` - Geocoding and reverse geocoding

### Firebase Services
- **firebase_core** `^3.6.0` - Firebase initialization
- **firebase_messaging** `^15.1.3` - Push notifications
- **firebase_crashlytics** `^4.1.3` - Crash reporting
- **firebase_analytics** `^11.3.3` - Analytics

### Observability
- **sentry_flutter** `^8.4.0` - Error tracking and monitoring

### Utilities
- **logger** `^2.4.0` - Logging utility
- **uuid** `^4.5.1` - UUID generation
- **connectivity_plus** `^6.0.3` - Network connectivity
- **device_info_plus** `^10.1.0` - Device information
- **flutter_local_notifications** `^18.0.1` - Local notifications

### Development Tools
- **build_runner** `^2.4.13` - Code generation
- **riverpod_generator** `^2.4.0` - Riverpod code generation
- **hive_generator** `^2.0.1` - Hive code generation
- **drift_dev** `^2.18.0` - Drift code generation
- **flutter_lints** `^4.0.0` - Linting rules

---

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── bootstrap.dart                 # App initialization
│
├── app/                           # App-level configuration
│   ├── app.dart                   # MaterialApp + ProviderScope
│   ├── router/
│   │   └── app_router.dart        # GoRouter configuration
│   ├── env/
│   │   ├── env_dev.dart           # Development environment
│   │   └── env_prod.dart          # Production environment
│   ├── di/
│   │   └── providers.dart         # Global Riverpod providers
│   └── config/
│       ├── app_theme.dart         # Theme configuration
│       ├── app_constants.dart     # App-wide constants
│       └── theme_provider.dart    # Theme state management
│
├── core/                          # Core services and utilities
│   ├── errors/
│   │   ├── failures.dart          # Failure classes
│   │   └── app_exception.dart     # Custom exceptions
│   ├── network/
│   │   ├── dio_client.dart        # Dio HTTP client wrapper
│   │   ├── api_interceptor.dart   # Request/response interceptors
│   │   └── network_checker.dart   # Network connectivity checker
│   ├── observability/
│   │   ├── sentry_service.dart    # Sentry integration
│   │   ├── crashlytics_service.dart # Crashlytics integration
│   │   └── observability_service.dart # Unified observability
│   ├── cache/
│   │   ├── cache_manager.dart     # Cache management
│   │   ├── hive_adapters.dart     # Hive type adapters
│   │   └── local_cache_keys.dart  # Cache key constants
│   ├── persistence/
│   │   ├── database.dart          # Drift database
│   │   └── migrations/            # Database migrations
│   ├── services/
│   │   ├── location_service.dart  # Location services
│   │   ├── websocket_service.dart # WebSocket management
│   │   ├── notification_service.dart # Push notifications
│   │   ├── permission_service.dart # Permission handling
│   │   ├── analytics_service.dart # Analytics tracking
│   │   └── route_service.dart     # Route calculations
│   ├── geoutils/
│   │   ├── geo_utils.dart         # Geographic utilities
│   │   └── geo_clustering.dart   # Location clustering
│   ├── concurrency/
│   │   └── isolate_helper.dart   # Isolate utilities
│   └── utils/
│       ├── logger.dart            # Logging utility
│       ├── debounce.dart          # Debounce utility
│       └── formatter.dart         # Data formatters
│
├── domain/                        # Business logic layer
│   ├── entities/                  # Domain entities
│   │   ├── user.dart
│   │   ├── vehicle.dart
│   │   ├── trip.dart
│   │   ├── booking.dart
│   │   ├── review.dart
│   │   ├── route_info.dart
│   │   ├── admin.dart
│   │   └── banner.dart
│   ├── repositories/              # Repository interfaces
│   │   ├── auth_repository.dart
│   │   ├── booking_repository.dart
│   │   ├── tracking_repository.dart
│   │   ├── map_repository.dart
│   │   ├── search_repository.dart
│   │   ├── admin_repository.dart
│   │   └── banner_repository.dart
│   └── usecases/                  # Business use cases
│       ├── login_user.dart
│       ├── get_nearby_vehicles.dart
│       ├── create_booking.dart
│       ├── track_vehicle.dart
│       ├── get_trip_plan.dart
│       ├── submit_review.dart
│       └── admin_actions.dart
│
├── data/                          # Data layer
│   ├── models/                    # Data models (JSON serializable)
│   │   ├── user_model.dart
│   │   ├── vehicle_model.dart
│   │   ├── booking_model.dart
│   │   ├── search_result_model.dart
│   │   ├── admin_model.dart
│   │   └── banner_model.dart
│   ├── local/                     # Local data sources
│   │   ├── user_local_ds.dart
│   │   ├── booking_local_ds.dart
│   │   ├── admin_local_ds.dart
│   │   ├── banner_local_ds.dart
│   │   └── cache_local_ds.dart
│   ├── remote/                    # Remote data sources
│   │   ├── auth_remote_ds.dart
│   │   ├── booking_remote_ds.dart
│   │   ├── tracking_remote_ds.dart
│   │   └── map_remote_ds.dart
│   └── repositories/              # Repository implementations
│       ├── auth_repository_impl.dart
│       ├── booking_repository_impl.dart
│       ├── tracking_repository_impl.dart
│       ├── map_repository_impl.dart
│       ├── search_repository_impl.dart
│       ├── admin_repository_impl.dart
│       └── banner_repository_impl.dart
│
├── features/                      # Feature modules (Feature-first)
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   │   └── auth_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── register_screen.dart
│   │   │   │   └── role_selection_screen.dart
│   │   │   └── widgets/
│   │   └── data/
│   ├── booking/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   ├── screens/
│   │   │   │   ├── booking_home.dart
│   │   │   │   ├── booking_details.dart
│   │   │   │   └── payment_screen.dart
│   │   │   └── widgets/
│   │   ├── domain/
│   │   └── data/
│   ├── maps/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   ├── screens/
│   │   │   │   └── live_map_screen.dart
│   │   │   └── widgets/
│   │   └── data/
│   ├── live_tracking/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   └── screens/
│   │   ├── domain/
│   │   └── data/
│   ├── search/
│   │   └── presentation/
│   │       ├── providers/
│   │       └── search_screen.dart
│   ├── reviews/
│   ├── admin/
│   │   └── presentation/
│   │       └── screens/
│   │           ├── admin_vehicles_screen.dart
│   │           └── vehicle_user_registration_screen.dart
│   ├── vehicle/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   │   ├── vehicle_route_provider.dart
│   │   │   │   └── vehicle_status_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── vehicle_location_update_screen.dart
│   │   │   │   ├── vehicle_route_update_screen.dart
│   │   │   │   ├── vehicle_direction_update_screen.dart
│   │   │   │   └── vehicle_time_update_screen.dart
│   │   │   └── widgets/
│   │   │       ├── vehicle_route_display.dart
│   │   │       └── vehicle_status_toggle.dart
│   ├── super_admin/
│   │   └── presentation/
│   │       └── screens/
│   │           ├── super_admin_admins_screen.dart
│   │           ├── admin_details_screen.dart
│   │           ├── super_admin_banners_screen.dart
│   │           └── banner_details_screen.dart
│   ├── user/
│   │   ├── presentation/
│   │   │   ├── providers/
│   │   │   │   ├── place_suggestions_provider.dart
│   │   │   │   └── route_search_provider.dart
│   │   │   ├── screens/
│   │   │   │   ├── route_results_screen.dart
│   │   │   │   └── user_bookings_screen.dart
│   │   │   └── widgets/
│   │   │       ├── place_autocomplete_field.dart
│   │   │       └── vehicle_card.dart
│   ├── admins/
│   │   └── presentation/
│   │       └── providers/
│   │           └── admin_provider.dart
│   ├── banners/
│   │   └── presentation/
│   │       └── providers/
│   │           ├── banner_provider.dart
│   │           └── banner_visibility_provider.dart
│   └── common/
│       └── presentation/
│           ├── screens/
│           │   ├── splash_screen.dart
│           │   ├── onboarding_screen.dart
│           │   ├── role_home_screen.dart
│           │   ├── role_settings_screen.dart
│           │   └── webview_screen.dart
│           └── widgets/
│               ├── role_dashboard_shell.dart
│               ├── welcome_card.dart
│               ├── quick_online_booking_section.dart
│               ├── user_booking_section.dart
│               └── role_home_banner_items.dart
│
├── ui/                            # Shared UI components
│   ├── widgets/                   # Reusable widgets
│   ├── themes/                    # Theme definitions
│   └── styles/                    # Style definitions
│
└── utils/                         # Utility functions
    ├── mock_data/                 # Mock data for testing
    └── dev_tools/                 # Development tools
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.5.3` or higher
- **Dart SDK** (included with Flutter)
- **Android Studio** / **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Git**

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd my_bus
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (if needed)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure environment**
   - Update `lib/app/env/env_dev.dart` with your development API URLs
   - Update `lib/app/env/env_prod.dart` with your production API URLs
   - Add Firebase configuration files:
     - `android/app/google-services.json` (Android)
     - `ios/Runner/GoogleService-Info.plist` (iOS)

5. **Configure Google Maps** (if using maps)
   - Add Google Maps API key to:
     - `android/app/src/main/AndroidManifest.xml`
     - `ios/Runner/AppDelegate.swift`

6. **Run the app**
   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

### Environment Configuration

The app supports multiple environments through the `env` folder:

**Development** (`lib/app/env/env_dev.dart`):
```dart
class EnvDev {
  static const String apiBaseUrl = 'https://dev-api.mybus.com';
  static const String wsBaseUrl = 'wss://dev-ws.mybus.com';
  static const String sentryDsn = '';
  static const bool enableDebugLogs = true;
  static const bool enableAnalytics = false;
  static const bool enableCrashlytics = false;
}
```

**Production** (`lib/app/env/env_prod.dart`):
```dart
class EnvProd {
  static const String apiBaseUrl = 'https://api.mybus.com';
  static const String wsBaseUrl = 'wss://ws.mybus.com';
  static const String sentryDsn = '';
  static const bool enableDebugLogs = false;
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
}
```

The environment is automatically selected based on the build mode.

### App Constants

Key constants are defined in `lib/app/config/app_constants.dart`:

- API version: `/api/v1`
- Timeouts: 30 seconds
- Cache durations
- Location settings
- Map zoom levels
- Booking constraints
- Role definitions
- Booking statuses

### Theme Configuration

The app uses Material Design 3 with custom theming:

- **Primary Color**: `#003366` (Deep Blue)
- **Secondary Color**: `#03A9F4` (Light Blue)
- **Font Family**: Poppins (Regular, Bold, Italic)
- **Dark/Light Mode**: Supported

---

## 🔨 Building the App

### Development Build

```bash
# Run in debug mode
flutter run

# Run on specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### Release Build

**Android:**
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

**iOS:**
```bash
# Build iOS app
flutter build ios --release

# Build for specific configuration
flutter build ios --release --no-codesign
```

### Build Configuration

The app uses the following build configurations:

- **Android**: 
  - Minimum SDK: Defined in `android/app/build.gradle.kts`
  - Target SDK: Latest stable
  - Application ID: `com.example.where_is_my_bus`

- **iOS**:
  - Minimum iOS version: Defined in `ios/Podfile`
  - Deployment target: Latest stable

---

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/auth/auth_test.dart
```

### Test Credentials

The app includes mock authentication for testing:

**Super Admin:**
- Email: `superadmin@gmail.com`
- Password: `super@123`

**Admin 1:**
- Email: `admin1@gmail.com`
- Password: `admin1@123`

**Admin 1 - Vehicle 1:**
- Email: `vehicle1@gmail.com`
- Password: `vehicle1@123`

**Admin 1 - Vehicle 2:**
- Email: `vehicle2@gmail.com`
- Password: `vehicle2@123`

**Admin 2:**
- Email: `admin2@gmail.com`
- Password: `admin2@123`

**Admin 2 - Vehicle 1:**
- Email: `vehicle3@gmail.com`
- Password: `vehicle3@123`

**Admin 2 - Vehicle 2:**
- Email: `vehicle4@gmail.com`
- Password: `vehicle4@123`

**User 1:**
- Email: `user1@gmail.com`
- Password: `user1@123`

**User 2:**
- Email: `user2@gmail.com`
- Password: `user2@123`

---

## 💻 Development Workflow

### Code Generation

The project uses code generation for:
- **Freezed**: Immutable data classes
- **JSON Serializable**: JSON serialization
- **Riverpod Generator**: Provider code generation
- **Hive Generator**: Hive adapters
- **Drift Generator**: Database code generation

Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch mode (auto-regenerate on file changes):
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Linting

The project uses `flutter_lints` for code quality:

```bash
# Analyze code
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Project Structure Guidelines

1. **Features**: Each feature should be self-contained in `lib/features/`
2. **Domain Logic**: Business logic goes in `lib/domain/`
3. **Data Layer**: API calls and local storage in `lib/data/`
4. **Core Services**: Shared services in `lib/core/`
5. **UI Components**: Reusable widgets in `lib/ui/`

### Adding a New Feature

1. Create feature folder: `lib/features/<feature_name>/`
2. Add presentation layer: `presentation/screens/`, `presentation/providers/`, `presentation/widgets/`
3. Add domain layer: `domain/entities/`, `domain/repositories/`, `domain/usecases/`
4. Add data layer: `data/models/`, `data/remote/`, `data/local/`
5. Register routes in `lib/app/router/app_router.dart`
6. Add providers in `lib/app/di/providers.dart` if needed

---

## 🔧 Key Components

### Authentication Flow

1. **Splash Screen**: Checks authentication state
2. **Onboarding**: First-time user experience
3. **Login/Register**: User authentication
4. **Role Selection**: Choose user role (if applicable)
5. **Role Dashboard**: Role-specific home screen

### State Management Pattern

```dart
// Example: Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Usage in widget
final authState = ref.watch(authProvider);
```

### WebSocket Integration

Real-time vehicle tracking uses WebSocket:

```dart
// Connect to WebSocket
final wsService = ref.read(websocketServiceProvider);
await wsService.connect(wsUrl);

// Listen to messages
wsService.messageStream?.listen((message) {
  // Handle vehicle location update
});
```

### Network Layer

HTTP requests use Dio with interceptors:

```dart
final dioClient = ref.read(dioClientProvider);
final response = await dioClient.get('/api/endpoint');
```

### Caching Strategy

- **Hive**: Fast key-value storage for frequently accessed data
- **SharedPreferences**: User preferences and settings
- **SQLite/Drift**: Structured data and history

---

## 🔌 API Integration

### REST API

The app communicates with backend via REST API:

- **Base URL**: Configured in environment files
- **API Version**: `/api/v1`
- **Authentication**: Token-based (stored in SharedPreferences)
- **Error Handling**: Centralized in `DioClient` and interceptors

### WebSocket

Real-time updates via WebSocket:

- **Connection**: Auto-reconnect on failure
- **Heartbeat**: 30-second interval
- **Reconnect Delay**: 5 seconds
- **Message Format**: JSON

### Endpoints Structure

```
/api/v1/
  ├── auth/
  │   ├── login
  │   ├── register
  │   └── logout
  ├── bookings/
  │   ├── create
  │   ├── list
  │   └── details/:id
  ├── vehicles/
  │   ├── list
  │   ├── track/:id
  │   └── nearby
  ├── routes/
  │   ├── search
  │   └── plan
  └── admin/
      ├── vehicles
      ├── routes
      └── bookings
```

---

## 🚀 Future Enhancements

### AI Integrations (Planned)

- **Predictive ETA**: Machine learning-based arrival time prediction
- **Route Optimization**: AI-powered route suggestions
- **Travel Assistant**: Chatbot for trip planning
- **Anomaly Detection**: Automatic detection of route deviations
- **Demand Forecasting**: Predict passenger demand

### Additional Features

- [ ] Push notifications for booking updates
- [ ] Offline mode with sync
- [ ] Multi-language support expansion
- [ ] Advanced analytics dashboard
- [ ] Social features (share trips, reviews)
- [ ] Payment gateway integration
- [ ] QR code ticket scanning
- [ ] Voice navigation
- [ ] Accessibility improvements

---

## 📝 License

MIT License

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📞 Support

For issues, questions, or contributions, please open an issue on the repository.

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- All open-source contributors

---
**Built with ❤️ using Flutter**