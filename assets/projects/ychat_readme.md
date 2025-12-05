# Y Chat - Flutter Chat Application

A comprehensive Flutter-based chat application with video calling, screen sharing, and real-time messaging capabilities. Built with Clean Architecture principles and modern Flutter best practices.

## 📱 Overview

Y Chat is a feature-rich messaging application that provides:
- **Real-time messaging** via Socket.IO
- **Video and audio calling** using WebRTC
- **Screen sharing** capabilities
- **Group chats** and contact management
- **Media sharing** (images, videos, audio, documents)
- **Location sharing** with Google Maps integration
- **End-to-end encryption** support
- **Multi-language support** (English, Hindi)
- **Dark/Light theme** support

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear layer separation:

```
lib/
├── core/                    # Shared utilities and configurations
│   ├── constants/          # App constants, routes, themes
│   ├── di/                 # Dependency injection setup
│   ├── network/            # API client and network layer
│   ├── services/           # Core services (auth, socket, notifications)
│   ├── utils/              # Utility functions
│   └── error/              # Error handling
├── features/               # Feature modules (Clean Architecture)
│   └── {feature_name}/
│       ├── domain/         # Business logic layer
│       │   ├── entities/   # Domain entities
│       │   ├── repositories/ # Repository interfaces
│       │   └── usecases/   # Use cases
│       ├── data/           # Data layer
│       │   ├── datasources/ # Data sources (API, Local)
│       │   ├── models/     # Data models
│       │   └── repositories/ # Repository implementations
│       ├── application/    # Application layer
│       │   └── blocs/      # BLoC state management
│       └── presentation/   # UI layer
│           ├── pages/      # Screen pages
│           └── widgets/    # Feature-specific widgets
└── shared/                 # Shared widgets and utilities
   └── widgets/            # Reusable UI components
```

### Architecture Principles

- **Dependency Rule**: Dependencies point inward (Presentation → Application → Domain ← Data)
- **Domain Layer**: Pure Dart, no external dependencies
- **Feature-based**: Each feature is self-contained
- **State Management**: BLoC pattern with Freezed for immutable states
- **Dependency Injection**: GetIt for service locator pattern

## 🛠️ Tech Stack

### Core Framework
- **Flutter**: 3.38.1 (managed via FVM)
- **Dart**: SDK ^3.9.0

### State Management & Architecture
- **flutter_bloc**: ^8.1.1 - BLoC pattern implementation
- **freezed**: ^3.2.3 - Immutable data classes and unions
- **equatable**: ^2.0.5 - Value equality
- **get_it**: ^8.0.0 - Dependency injection
- **dartz**: ^0.10.1 - Functional programming (Either pattern)

### Networking & Real-time
- **dio**: ^5.9.0 - HTTP client
- **socket_io_client**: ^3.1.2 - Real-time Socket.IO communication
- **flutter_webrtc**: ^1.1.0 - WebRTC for video/audio calls

### Data Persistence
- **hive**: ^2.2.3 - Fast NoSQL database
- **shared_preferences**: ^2.5.3 - Key-value storage
- **path_provider**: ^2.1.1 - File system paths

### UI & Design
- **flutter_screenutil**: ^5.9.3 - Responsive design
- **google_fonts**: ^6.3.1 - Custom typography
- **flutter_svg**: ^2.0.9 - SVG support
- **shimmer**: ^3.0.0 - Loading animations
- **carousel_slider**: ^5.1.1 - Image carousels

### Navigation
- **go_router**: ^16.2.1 - Declarative routing

### Media & Files
- **image_picker**: ^1.0.7 - Image selection
- **cached_network_image**: ^3.3.1 - Image caching
- **file_picker**: ^10.3.2 - File selection
- **photo_manager**: ^3.0.0 - Gallery access
- **video_player**: ^2.8.2 - Video playback
- **chewie**: ^1.7.4 - Video player UI
- **audioplayers**: ^6.0.0 - Audio playback
- **record**: ^6.1.2 - Audio recording

### Location & Maps
- **geolocator**: ^10.1.0 - Location services
- **google_maps_flutter**: ^2.5.0 - Google Maps integration
- **flutter_map**: ^7.0.2 - Alternative map solution

### Firebase
- **firebase_core**: ^4.2.0
- **firebase_messaging**: ^16.0.3 - Push notifications
- **firebase_analytics**: ^12.0.3 - Analytics

### Localization
- **easy_localization**: ^3.0.8 - Multi-language support
- **intl**: ^0.20.2 - Internationalization

### Other Key Packages
- **permission_handler**: ^12.0.1 - Runtime permissions
- **flutter_local_notifications**: ^17.2.3 - Local notifications
- **qr_code_scanner_plus**: ^2.0.12 - QR code scanning
- **connectivity_plus**: ^6.1.2 - Network connectivity monitoring

## 📦 Project Structure

### Core Features

1. **Authentication** (`features/auth/`)
   - Phone number registration
   - OTP verification
   - Profile completion

2. **Chat** (`features/chat/`)
   - One-on-one messaging
   - Group messaging
   - Message types: text, image, video, audio, document, location
   - Real-time message delivery
   - Message status indicators
   - Message search and pagination

3. **Calls** (`features/call/`)
   - Video calls
   - Audio calls
   - Screen sharing during calls
   - Call history
   - Call statistics

4. **Contacts** (`features/contact/`)
   - Contact list
   - Contact synchronization
   - Contact profiles
   - Add/remove contacts

5. **Groups** (`features/group/`)
   - Create groups
   - Group management
   - Group profiles
   - Group settings

6. **Settings** (`features/settings/`)
   - Account settings
   - Privacy settings
   - Notification settings
   - Theme settings
   - Language settings
   - Chat settings
   - Data storage management

7. **Screen Mirror** (`features/screen_mirror/`)
   - Screen sharing
   - Real-time screen mirroring

8. **Gallery** (`features/gallery/`)
   - Media gallery
   - Photo/video viewer

9. **Files** (`features/files/`)
   - File management
   - Document viewer

10. **YApps** (`features/yapps/`)
    - Integrated mini-apps
    - App categories

### Core Services

- **AuthService**: Authentication and session management
- **SocketService**: Socket.IO connection management
- **NotificationService**: Push and local notifications
- **WebRTCService**: Video/audio call handling
- **ErrorHandler**: Centralized error handling
- **Logger**: Structured logging system
- **PerformanceMonitor**: Performance tracking

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.38.1 (managed via FVM)
- Dart SDK ^3.9.0
- FVM (Flutter Version Management)
- Android Studio / Xcode (for mobile development)
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ychat_frontend
   ```

2. **Install FVM and Flutter version**
   ```bash
   # Install FVM (if not already installed)
   dart pub global activate fvm
   
   # Install the Flutter version specified in .fvmrc
   fvm install
   
   # Use the Flutter version
   fvm use
   ```

3. **Install dependencies**
   ```bash
   fvm flutter pub get
   ```

4. **Set up Firebase**
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`
   - Configure Firebase in `lib/firebase_options.dart`

5. **Generate code**
   ```bash
   fvm flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

6. **Run the app**
   ```bash
   fvm flutter run
   ```

### Environment Configuration

The app uses environment-based configuration. Set up your environment variables in:
- `lib/core/config/environment.dart`
- `lib/core/config/api_endpoints.dart`

## 🧪 Development

### Code Generation

After creating or modifying Freezed classes, run:
```bash
fvm flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Running Tests

```bash
fvm flutter test
```

### Code Analysis

```bash
fvm flutter analyze
```

### Building for Production

**Android:**
```bash
fvm flutter build apk --release
# or
fvm flutter build appbundle --release
```

**iOS:**
```bash
fvm flutter build ios --release
```

## 📝 Development Guidelines

### State Management

- **Always use BLoC** for state management
- **Always use Freezed** for BLoC events and states
- Follow naming: `{Feature}Bloc`, `{Feature}Event`, `{Feature}State`
- Handle errors using Either pattern

### Code Style

- Follow official Dart style guide
- Use `const` constructors whenever possible
- Add `@override` annotations
- Use trailing commas for better formatting

### Error Handling

- Use `Failure` types from `lib/core/error/failures.dart`
- Use `ErrorHandler` service for global error handling
- Always convert exceptions to failures in repositories
- Use Either pattern: `Future<Either<Failure, Success>>`

### Logging

- Use structured logging with `Logger` class
- Use appropriate log levels: `debug`, `info`, `warning`, `error`
- Log API requests: `Logger.apiRequest()`
- Log BLoC events: `Logger.blocEvent()`

### UI Guidelines

- Use `flutter_screenutil` for responsive design
- Use `.w`, `.h`, `.sp` extensions for sizing
- Use shimmer effects for loading states
- Follow Material Design 3 guidelines
- Support both light and dark themes

### Dependency Injection

- Register dependencies in feature-specific DI modules
- Use lazy singletons for repositories and services
- Use factory for BLoCs and short-lived objects
- Follow registration order: External → Data Sources → Repositories → Use Cases → BLoCs

## 🔐 Security

- JWT token-based authentication
- Secure token storage using `TokenStorageService`
- HTTPS for all network communications
- Input validation on all user inputs
- Permission handling for sensitive operations

## 🌐 Localization

The app supports multiple languages:
- English (en)
- Hindi (hi)

Translation files are located in `assets/translations/`.

## 🎨 Theming

The app supports light and dark themes with a custom color scheme:
- **Primary Color**: #584fbc (Purple)
- **Secondary Color**: #7a73d4 (Light Purple)
- **Typography**: Poppins font family

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (partial)
- ✅ macOS (partial)
- ✅ Linux (partial)
- ✅ Windows (partial)

## 🤝 Contributing

1. Follow the Clean Architecture structure
2. Use BLoC for state management
3. Write tests for new features
4. Follow the coding conventions
5. Update documentation as needed

## 📄 License

[Add your license information here]

## 👥 Team

[Add team information here]

## 📞 Support

[Add support contact information here]

---
**Built with ❤️ using Flutter**