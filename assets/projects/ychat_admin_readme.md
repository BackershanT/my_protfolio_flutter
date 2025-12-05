# 🚀 YChat Admin Frontend

<div align="center">

**A comprehensive Flutter-based admin dashboard for YChat application management**

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Documentation](#-documentation)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Configuration](#-configuration)
- [Development](#-development)
- [Testing](#-testing)
- [Deployment](#-deployment)
- [Real-time Features](#-real-time-features)
- [Design System](#-design-system)
- [Contributing](#-contributing)
- [Documentation](#-documentation)

---

## 🎯 Overview

**YChat Admin Frontend** is a production-ready Flutter application that provides comprehensive administrative capabilities for managing the YChat ecosystem. Built with modern architecture patterns, it offers a scalable, maintainable, and testable codebase following Clean Architecture principles.

### Key Highlights

- 🏗️ **Clean Architecture** - Proper separation of concerns with feature-based structure
- 💻 **Desktop-First Design** - Optimized for desktop environments (minimum 1200x800 resolution)
- 🔐 **Secure Authentication** - Token-based auth with role-based access control
- 📊 **Dashboard Analytics** - Comprehensive statistics and metrics visualization
- 🎫 **Ticket Management** - Complete ticket management system with filtering
- 👥 **User Management** - Comprehensive user administration tools
- 📱 **App Management** - Application lifecycle management
- ⚙️ **Settings Management** - System configuration and preferences
- 🌓 **Theme Support** - Light/Dark mode with system preference detection
- 🎨 **Material Design 3** - Modern UI following Material Design guidelines

---

## ✨ Features

### 🔐 Authentication & Security

- **Secure Login/Logout** - JWT token-based authentication
- **Super Admin Registration** - Initial setup and admin creation
- **Role-Based Access Control** - Granular permissions system
- **Session Management** - Automatic token refresh and validation
- **Password Management** - Change password functionality
- **Token Storage** - Secure local storage with encryption

### 📊 Dashboard & Analytics

- **Real-time Metrics** - Live statistics and KPIs
- **Interactive Charts** - FL Chart and Syncfusion visualizations
- **User Activity Monitoring** - Track user engagement
- **System Performance** - Monitor app health and performance
- **Customizable Widgets** - Configurable dashboard layout
- **Data Export** - Export analytics data

### 🎫 Ticket Management System

- **CRUD Operations** - Create, read, update, delete tickets
- **Advanced Filtering** - Filter by status, priority, category, date
- **Status Management** - Open, In Progress, Resolved, Closed
- **Priority Levels** - Low, Medium, High, Critical
- **Category Organization** - Organize tickets by categories
- **Reply System** - Thread-based conversations
- **Bulk Operations** - Multi-select and batch actions
- **Search Functionality** - Full-text search across tickets
- **Statistics** - Ticket analytics and reporting

### 👥 User Management

- **User CRUD** - Complete user lifecycle management
- **Activation/Deactivation** - Control user access
- **Ban/Unban** - Temporary and permanent restrictions
- **Role Management** - Assign and modify user roles
- **Profile Management** - View and edit user profiles
- **User Analytics** - Track user behavior and statistics
- **Bulk Operations** - Mass user actions

### 📱 App Management

- **App Lifecycle** - Create, update, delete applications
- **Category Management** - Organize apps by categories
- **Status Tracking** - Monitor app status and health
- **Version Management** - Track app versions
- **App Analytics** - Usage statistics and metrics
- **Search & Filter** - Find apps quickly
- **Bulk Operations** - Manage multiple apps

### ⚙️ Settings Management

- **System Configuration** - Global settings management
- **Feature Toggles** - Enable/disable features
- **Offline Mode** - Local storage fallback
- **Real-time Updates** - Live settings synchronization
- **Export/Import** - Backup and restore settings
- **Theme Configuration** - Customize appearance

### 🎨 UI/UX Features

- **Material Design 3** - Modern Material Design implementation
- **Desktop-Optimized Layout** - Fixed design size (1440x900) with minimum window constraints
- **Dark/Light Theme** - System-aware theme switching
- **Smooth Animations** - Polished transitions and effects
- **Loading States** - Shimmer loading and skeleton screens
- **Error Handling** - User-friendly error messages
- **Empty States** - Contextual empty state illustrations
- **Accessibility** - Screen reader and keyboard navigation support

---

## 🏗️ Architecture

The project follows **Clean Architecture** principles with a **feature-based** structure, ensuring scalability, maintainability, and testability.

### Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│              Presentation Layer (UI)                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │    Pages     │  │   Widgets    │  │     BLoC     │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────────┐
│                  Domain Layer (Business Logic)              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   Entities   │  │  Use Cases   │  │ Repositories │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
                          ↕
┌─────────────────────────────────────────────────────────────┐
│                   Data Layer (Data Sources)                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │Data Sources  │  │    Models    │  │ Repositories │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

### Architecture Principles

- **Dependency Inversion** - High-level modules don't depend on low-level modules
- **Single Responsibility** - Each class has one reason to change
- **Open/Closed** - Open for extension, closed for modification
- **Interface Segregation** - Clients don't depend on unused interfaces
- **Separation of Concerns** - Clear boundaries between layers

### Desktop-Only Configuration

The application is configured for desktop-only use:
- **Fixed Design Size**: 1440x900 pixels (consistent scaling)
- **Minimum Window Size**: 1200x800 pixels (enforced in `AppWrapper`)
- **No Responsive Breakpoints**: All layouts optimized for desktop
- **Single Layout Mode**: No mobile/tablet variations

### State Management

- **BLoC Pattern** - Predictable state management with `flutter_bloc`
- **Freezed** - Immutable data classes with code generation
- **Event-Driven** - Clear event/state separation
- **Reactive** - Stream-based state updates

---

## 🛠️ Tech Stack

### Core Framework
- **Flutter** `^3.8.1` - Cross-platform UI framework
- **Dart** `^3.8.1` - Programming language

### State Management
- **flutter_bloc** `^8.1.6` - BLoC state management
- **bloc** `^8.1.4` - Core BLoC library
- **freezed** `^2.5.7` - Code generation for immutable classes
- **equatable** `^2.0.5` - Value equality

### Navigation & Routing
- **go_router** `^14.2.7` - Declarative routing with guards

### HTTP & Networking
- **dio** `^5.4.0` - Powerful HTTP client
- **http** `^1.1.0` - Additional HTTP utilities
- **socket_io_client** `^2.0.3+1` - Real-time Socket.IO communication

### Dependency Injection
- **get_it** `^7.7.0` - Service locator
- **injectable** `^2.4.2` - Code generation for DI

### UI & Styling
- **flutter_screenutil** `^5.9.3` - Responsive design utilities
- **google_fonts** `^6.1.0` - Typography
- **fl_chart** `^1.0.0` - Beautiful charts
- **syncfusion_flutter_charts** `^30.2.6+1` - Advanced charting
- **shimmer** `^3.0.0` - Loading animations
- **lottie** `^3.1.2` - Animations

### Data & Storage
- **shared_preferences** `^2.2.1` - Local key-value storage
- **dartz** `^0.10.1` - Functional programming utilities

### Code Generation
- **build_runner** `^2.4.13` - Code generation runner
- **json_serializable** `^6.8.0` - JSON serialization
- **injectable_generator** `^2.6.2` - DI code generation

### Testing
- **flutter_test** - Flutter testing framework
- **mockito** `^5.4.4` - Mocking framework
- **bloc_test** `^9.1.7` - BLoC testing utilities
- **integration_test** - Integration testing

### Utilities
- **uuid** `^4.5.1` - Unique identifier generation
- **intl** `^0.19.0` - Internationalization

---

## 📁 Project Structure

```
lib/
├── main.dart                          # Application entry point & initialization
└── src/
    ├── core/                          # Shared core functionality
    │   ├── constants/                 # App constants & design system
    │   │   ├── app_assets.dart        # Asset paths
    │   │   ├── app_breakpoints.dart   # Screen breakpoints (legacy, desktop-only now)
    │   │   ├── app_colors.dart        # Color definitions
    │   │   ├── app_endpoints.dart     # API endpoints
    │   │   └── app_spacing.dart       # Spacing constants
    │   ├── error/                     # Error handling
    │   │   └── api_exception.dart     # API exception types
    │   ├── routes/                    # Navigation configuration
    │   │   └── app_router.dart        # GoRouter setup
    │   ├── services/                  # Core services
    │   │   ├── auth_interceptor.dart  # Dio auth interceptor
    │   │   └── dio_client.dart        # HTTP client setup
    │   ├── theme/                     # App theming
    │   │   ├── app_theme.dart         # Material Design 3 theme
    │   │   └── theme_provider.dart    # Theme management (Provider)
    │   └── widgets/                   # Reusable core widgets
    │       └── app_wrapper.dart       # Root app wrapper with size constraints
    │
    ├── features/                      # Feature modules (Clean Architecture)
    │   ├── auth/                      # ✅ Authentication feature (Complete)
    │   │   ├── data/                  # Data layer
    │   │   │   ├── datasources/       # Local & remote data sources
    │   │   │   ├── models/            # DTOs with Freezed
    │   │   │   └── repositories/      # Repository implementations
    │   │   ├── domain/                # Domain layer
    │   │   │   ├── entities/          # Domain entities
    │   │   │   ├── repositories/      # Repository interfaces
    │   │   │   └── usecases/          # Business logic
    │   │   └── presentation/          # Presentation layer
    │   │       ├── bloc/              # BLoC state management
    │   │       ├── pages/             # Login, Register, etc.
    │   │       └── widgets/           # Auth widgets
    │   ├── dashboard/                 # ⚠️ Dashboard feature (Mock data)
    │   │   ├── data/                  # Data layer with mock stats
    │   │   ├── domain/                # Domain layer
    │   │   └── presentation/          # Dashboard UI
    │   ├── profile/                   # ✅ Profile feature (Complete)
    │   ├── application/               # ⚠️ App management (Mock data)
    │   ├── banner_management/         # ⚠️ Banner management (Mock repo)
    │   ├── tickets/                   # ⚠️ Ticket management (Mock data)
    │   ├── notifications/             # ⚠️ Notifications (UI only)
    │   └── settings/                  # ⚠️ Settings (UI only)
    │
    └── shared/                        # Shared across features
        └── widgets/                   # Shared reusable widgets
            ├── buttons/               # App buttons
            ├── dashboard/             # Dashboard charts & widgets
            ├── inputs/                # Form inputs
            └── layout/                # Layout widgets (ResponsiveScaffold - unused)
```

**Legend**:
- ✅ Complete implementation
- ⚠️ Partial implementation (mock data or missing layers)
- ❌ Missing implementation

### Feature Module Structure

Each feature follows the same structure:

```
feature_name/
├── data/                              # Data layer
│   ├── datasources/                   # Remote/local data sources
│   ├── models/                        # Data models (Freezed)
│   └── repositories/                  # Repository implementations
├── domain/                            # Domain layer
│   ├── entities/                      # Business entities (Freezed)
│   ├── repositories/                  # Repository interfaces
│   └── usecases/                      # Business logic use cases
└── presentation/                      # Presentation layer
    ├── bloc/                          # BLoC files (Freezed)
    ├── pages/                         # UI pages
    └── widgets/                        # Feature-specific widgets
```

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.8.1` or higher
- **Dart SDK** `^3.8.1` or higher
- **Android Studio** / **VS Code** with Flutter extensions
- **Git** for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ychat_admin_frontend
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for Freezed, JSON serialization, etc.)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Platform Support

- ✅ **Desktop (Primary)** - Windows, macOS, Linux with desktop-optimized UI
- ✅ **Web** - Full support in desktop browser environments
- ⚠️ **Mobile/Tablet** - Not optimized for mobile or tablet devices

**Note**: This application is designed for desktop use with a minimum window size of 1200x800 pixels. It uses a fixed design size of 1440x900 for consistent scaling across desktop platforms.

### Development Setup

1. **Configure API endpoints** in `lib/src/core/api/api_config.dart`
2. **Set up environment variables** (optional)
3. **Run code generation** when modifying models
4. **Start development server**

---

## ⚙️ Configuration

### API Configuration

The app uses environment-aware configuration. API endpoints are configured in `lib/src/core/api/api_config.dart`:

```dart
// Base URL is automatically detected based on platform
// Web: https://dev-api.ychatt.com/api
// Mobile: https://dev-api.ychatt.com/api
// Desktop: https://dev-api.ychatt.com/api
```

### Environment Variables

You can override default values using environment variables:

```bash
# Development
flutter run --dart-define=API_BASE_URL=http://localhost:3002/api

# Production
flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com/api
```

### Socket.IO Configuration

Socket.IO URL is configured in `ApiConfig` and automatically handles:
- URL parsing and validation
- Port detection for HTTPS/HTTP
- Connection management
- Reconnection logic

### Backend Requirements

- Node.js backend with RESTful API
- Socket.IO server for real-time features
- JWT token authentication
- CORS enabled for web development

---

## 🛠️ Development

### Code Generation

Run code generation after modifying Freezed classes or models:

```bash
# Generate all code
flutter pub run build_runner build

# Watch for changes (recommended during development)
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs
```

### Development Commands

```bash
# Run in debug mode (desktop recommended)
flutter run -d macos          # macOS
flutter run -d windows        # Windows
flutter run -d linux          # Linux
flutter run -d chrome         # Web (desktop browser)

# Run in release mode
flutter run --release

# Analyze code
flutter analyze

# Format code
flutter format .
```

### Desktop Development

For optimal development experience:
- Use desktop platforms (macOS, Windows, Linux)
- Minimum screen resolution: 1200x800
- Browser testing should be done in desktop mode (window size >= 1200px)

### Architecture Guidelines

#### 1. State Management
- ✅ Use **BLoC** for all state management
- ✅ Use **Freezed** for all entities, states, and events
- ❌ Never use `setState()` for complex state
- ❌ Never mix different state management solutions

#### 2. Navigation
- ✅ Use **GoRouter** for all navigation
- ✅ Define routes in `app_routes.dart`
- ✅ Use route guards for authentication
- ❌ Never use `Navigator.push()` directly

#### 3. API Calls
- ✅ Use **Dio** for HTTP requests
- ✅ Implement proper error handling
- ✅ Use repository pattern for data access
- ✅ Handle loading, success, and error states

#### 4. UI Development
- ✅ Use **Flutter ScreenUtil** with fixed design size (1440x900)
- ✅ Follow Material Design 3 guidelines
- ✅ Create reusable widgets
- ✅ Use consistent spacing and typography
- ✅ Design for desktop resolutions (minimum 1200x800)

### Code Style

- Follow Dart/Flutter style guide
- Use meaningful variable and function names
- Add comprehensive comments for complex logic
- Implement proper error handling
- Write unit tests for business logic

---

## 🧪 Testing

### Test Structure

```
test/
├── unit/                    # Unit tests
│   ├── features/           # Feature-specific tests
│   └── core/               # Core functionality tests
├── widget/                 # Widget tests
└── integration/            # Integration tests
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/features/auth/auth_bloc_test.dart

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

### Test Coverage

- Unit tests for business logic (Use Cases, Repositories)
- Widget tests for UI components
- Integration tests for user flows
- Mock external dependencies

---

## 📦 Deployment

### Web Deployment

```bash
# Build for web (desktop-optimized)
flutter build web --release

# Deploy to hosting service
# Copy build/web/ contents to your web server
# Note: Application requires minimum 1200px width for proper display
```

### Android Deployment

```bash
# Build Android APK
flutter build apk --release

# Build Android App Bundle
flutter build appbundle --release
```

### iOS Deployment

```bash
# Build iOS
flutter build ios --release

# Archive and upload via Xcode
```

### Environment Configuration

- Set up different configurations for dev/staging/prod
- Use environment variables for API URLs
- Configure proper security settings
- Set up CI/CD pipelines

---

## 🔄 Real-time Features

### Socket.IO Integration

The app uses Socket.IO for real-time communication:

- **Connection Management** - Automatic connection and reconnection
- **Event Handling** - Listen to server events
- **Room Management** - Join/leave rooms for targeted updates
- **Error Handling** - Comprehensive error handling and recovery

### Socket Events

- `app_state_update` - Application state changes
- `user_update` - User data updates
- `notification` - Push notifications
- `message` - Real-time messages

### Usage Example

```dart
// Initialize socket connection
await SocketManager.instance.initialize();

// Listen to connection state
SocketManager.instance.connectionStateStream.listen((state) {
  print('Connection state: $state');
});

// Listen to messages
SocketManager.instance.messageStream.listen((data) {
  print('Received: $data');
});

// Send message
SocketManager.instance.sendMessage('event_name', {'key': 'value'});
```

---

## 🎨 Design System

### Color Palette

- **Primary**: `#584fbc` - Main brand color
- **Secondary**: `#b3a8e8` - Secondary brand color
- **Success**: `#4caf50` - Success states
- **Warning**: `#ff9800` - Warning states
- **Error**: `#f44336` - Error states
- **Info**: `#2196f3` - Information states

### Typography

- **Headlines**: 32sp, 28sp, 24sp (Bold)
- **Titles**: 22sp, 18sp, 16sp (Semi-bold)
- **Body**: 16sp, 14sp, 12sp (Regular)
- **Labels**: 14sp, 12sp, 10sp (Medium)

### Spacing System

- **Base Unit**: 8px grid system
- **Spacing Scale**: 2px, 4px, 8px, 12px, 16px, 24px, 32px, 40px, 48px, 64px, 80px

### Border Radius

- **Small**: 4px
- **Medium**: 8px
- **Large**: 12px
- **Extra Large**: 16px
- **Round**: 50px

### Reusable Components

- **Loading States** - Shimmer loading, skeleton screens
- **Empty States** - Contextual empty state illustrations
- **Error States** - User-friendly error messages
- **UI Components** - Custom buttons, inputs, cards, navigation

---

## 🤝 Contributing

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Follow the coding standards
4. Write tests for new features
5. Commit your changes (`git commit -m 'feat: add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Commit Convention

```
feat: add new feature
fix: bug fix
docs: documentation update
style: code formatting
refactor: code refactoring
test: add tests
chore: maintenance tasks
```

### Coding Standards

- Follow Dart/Flutter style guide
- Use meaningful variable and function names
- Write comprehensive comments
- Maintain test coverage above 80%
- Follow Clean Architecture principles

---

## 📚 Documentation

### Project Documentation

- [PROJECT_ANALYSIS.md](PROJECT_ANALYSIS.md) - Comprehensive project analysis and findings
- [PROJECT_RULES.md](PROJECT_RULES.md) - Development rules and guidelines
- [TESTING_GUIDE.md](TESTING_GUIDE.md) - Testing guidelines

### Key Findings

- **Architecture**: Clean Architecture with feature-based structure
- **Desktop-Only**: Optimized for desktop environments (1200x800 minimum)
- **Feature Status**: Core features (Auth, Profile) are complete; some features use mock data
- **Code Quality**: Consistent patterns with Freezed and BLoC throughout
- **See [PROJECT_ANALYSIS.md](PROJECT_ANALYSIS.md) for detailed analysis**

### External Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
- [Material Design 3](https://m3.material.io/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [GoRouter Documentation](https://pub.dev/packages/go_router)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Support

For support and questions:

- Create an issue in the repository
- Contact the development team
- Check the documentation files
- Review existing issues and discussions

---

## 🔄 Changelog

### Version 1.0.0

- ✅ Initial release
- ✅ Complete admin dashboard functionality
- ✅ Authentication system with JWT (fully implemented)
- ✅ Profile management (fully implemented)
- ✅ Dashboard with statistics and charts
- ✅ Desktop-optimized UI (1440x900 design size)
- ✅ Minimum window size constraints (1200x800)
- ✅ Dark/Light theme support
- ✅ Material Design 3 implementation
- ✅ Comprehensive error handling
- ✅ Loading states and animations
- ⚠️ Some features use mock data (see PROJECT_ANALYSIS.md for details)
- ⚠️ Partial implementations for Tickets, Banners, Applications, Settings, Notifications

---

<div align="center">

**Built with ❤️ using Flutter**

[⬆ Back to Top](#-ychat-admin-frontend)

</div>