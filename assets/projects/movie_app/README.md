# Movie App 🎬

A Flutter-based movie application that displays trending movies and TV shows using The Movie Database (TMDB) API. Built with Clean Architecture principles and BLoC pattern for state management.

## 📱 Features

- **Home Screen**: Displays trending movies, past year movies, tense dramas, and South Indian movies
- **New & Hot**: Discover new movies and TV shows
- **Fast Laugh**: Watch funny video clips
- **Search**: Search for movies and TV shows
- **Downloads**: Manage downloaded content
- **Dark Theme**: Modern dark UI design

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/src/
├── domain/          # Business logic layer
│   ├── core/        # Core domain entities, failures, DI
│   ├── downloads/   # Downloads domain models and interfaces
│   ├── hot_and_new/ # Hot & New feature domain
│   └── search/      # Search feature domain
│
├── application/     # Application layer (BLoC)
│   ├── downloads/   # Downloads BLoC
│   ├── fast_laugh/  # Fast Laugh BLoC
│   ├── home_bloc/   # Home screen BLoC
│   ├── hotand_new_bloc.dart
│   └── search/      # Search BLoC
│
├── infrastructure/  # Data layer
│   ├── downloads/   # Downloads repository implementation
│   ├── hot_and_new/ # Hot & New repository implementation
│   └── search/      # Search repository implementation
│
├── presentation/    # UI layer
│   ├── downloads/   # Downloads screen and widgets
│   ├── first_laugh/ # Fast Laugh screen
│   ├── home/        # Home screen
│   ├── mainpage/    # Main navigation page
│   ├── new_hot/     # New & Hot screen
│   └── search/      # Search screen
│
└── core/            # Shared utilities
   ├── colors/      # App color scheme
   ├── constants.dart
   └── strings.dart # API base URL
```

### Architecture Layers

1. **Domain Layer**: Contains business logic, entities, and repository interfaces
   - Pure Dart code (no Flutter dependencies)
   - Defines contracts via interfaces
   - Uses `dartz` for functional programming (Either type)

2. **Application Layer**: Contains BLoC classes for state management
   - Handles business logic orchestration
   - Uses `flutter_bloc` for state management
   - Freezed for immutable state classes

3. **Infrastructure Layer**: Implements data sources
   - API calls using `Dio`
   - Implements domain repository interfaces
   - Handles error mapping

4. **Presentation Layer**: UI components
   - Flutter widgets and screens
   - Consumes BLoC for state
   - Uses ValueNotifier for simple state (bottom navigation)

## 🛠️ Technologies & Dependencies

### Core Dependencies
- **flutter_bloc**: State management using BLoC pattern
- **get_it**: Dependency injection container
- **injectable**: Code generation for dependency injection
- **dio**: HTTP client for API calls
- **dartz**: Functional programming utilities (Either type)
- **freezed**: Code generation for immutable classes
- **json_annotation/json_serializable**: JSON serialization
- **video_player**: Video playback functionality
- **share_plus**: Share functionality
- **path_provider**: File system paths

### Dev Dependencies
- **build_runner**: Code generation runner
- **injectable_generator**: Generates DI code
- **freezed**: Generates immutable classes
- **flutter_lints**: Linting rules

## 📋 Prerequisites

- Flutter SDK ^3.5.3
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS development: Xcode (for macOS)
- Android development: Android Studio

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone <repository-url>
cd movie_app
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate code
This project uses code generation for:
- Dependency injection (`injectable`)
- Immutable classes (`freezed`)
- JSON serialization (`json_serializable`)

Run the build runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Configure API Key
The app uses The Movie Database (TMDB) API. The API key is currently hardcoded in:
```
lib/src/infrastructure/api_key.dart
```

**⚠️ Security Note**: For production, consider using environment variables or secure storage instead of hardcoding the API key.

### 5. Run the app
```bash
# For Android
flutter run

# For iOS
flutter run

# For a specific device
flutter devices
flutter run -d <device-id>
```

## 🏃 Build Instructions

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 📁 Project Structure Details

### Domain Layer
- **Interfaces**: Abstract repository contracts (e.g., `IHotNewRepo`, `ISearchRepo`)
- **Models**: Domain entities with Freezed annotations
- **Failures**: Error handling using `MainFailure` sealed class

### Application Layer
- **BLoCs**: State management classes
  - `HomeBloc`: Manages home screen data (movies, TV shows)
  - `SearchBloc`: Handles search functionality
  - `DownloadsBloc`: Manages downloads
  - `FastLaughBloc`: Handles fast laugh videos
  - `HotandNewBloc`: Manages new & hot content

### Infrastructure Layer
- **Repositories**: Concrete implementations of domain interfaces
- **API Integration**: Uses Dio for HTTP requests to TMDB API
- **Error Handling**: Maps network errors to domain failures

### Presentation Layer
- **Screens**: Main UI screens for each feature
- **Widgets**: Reusable UI components
- **Navigation**: Bottom navigation using ValueNotifier

## 🔌 API Integration

The app integrates with **The Movie Database (TMDB) API**:
- Base URL: `https://api.themoviedb.org/3`
- Endpoints:
  - Trending: `/trending/all/day`
  - Search: `/search/movie`
  - Discover Movies: `/discover/movie`
  - Discover TV: `/discover/tv`

API endpoints are defined in `lib/src/domain/core/api_endpoints.dart`.

## 🎨 UI/UX Features

- **Dark Theme**: Modern dark mode interface
- **Bottom Navigation**: 5-tab navigation (Home, New & Hot, Fast Laugh, Search, Downloads)
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Video Playback**: Integrated video player for trailers/clips
- **Share Functionality**: Share movies/shows

## 🔧 State Management

The app uses a hybrid approach:
- **BLoC Pattern**: For complex state management (API calls, business logic)
- **ValueNotifier**: For simple UI state (bottom navigation index)

## 📝 Code Generation

After making changes to:
- Freezed classes (models, states, events)
- Injectable classes (repositories, BLoCs)
- JSON serializable classes

Run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or watch for changes:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 🧪 Testing

Run tests:
```bash
flutter test
```

## 📄 License

This project is for educational purposes.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run code generation if needed
5. Submit a pull request

## 📞 Support

For issues and questions, please open an issue in the repository.

---
**Note**: This is a Flutter project demonstrating Clean Architecture, BLoC pattern, and modern Flutter development practices.