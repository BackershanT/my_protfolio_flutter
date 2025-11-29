import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class ProjectDesign {
  final Color bgColor;
  final Color textColor;
  final Color logoColor;
  final Color descColor;
  final List<BlobShape> blobs;

  const ProjectDesign({
    required this.bgColor,
    required this.textColor,
    required this.logoColor,
    required this.descColor,
    required this.blobs,
  });
}

class BlobShape {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const BlobShape({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });
}

class ProjectData {
  static final projects = [
    Project(
      id: '1',
      title: 'Netflix Clone',
      description: 'Netflix Clone - A Netflix clone built with React',
      technologies: ['React', 'firebase', 'useState'],
      imageUrl: AppAssets.projectNetflix,
      screenshots: [AppAssets.projectNetflix01, AppAssets.projectNetflix02],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.website,
      readmeContent: '''
# Netflix React Clone 🎬

A Netflix-inspired web application built with React that displays movies and TV shows using The Movie Database (TMDB) API. The app features a dynamic banner, movie rows, and embedded YouTube trailers.

## 🚀 Features

- **Dynamic Banner**: Displays a randomly selected trending movie or TV show with backdrop image
- **Movie Categories**: 
  - Netflix Originals
  - Action Movies
- **Trailer Playback**: Click on any movie poster to watch its YouTube trailer
- **Responsive Design**: Modern UI with Netflix-inspired styling
- **API Integration**: Real-time data fetching from TMDB API

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Node.js (v14 or higher)
- npm (Node Package Manager)

## 🛠️ Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd netflix_react
```

2. Install dependencies:
```bash
npm install
```

## 🔧 Configuration

The app uses The Movie Database (TMDB) API. The API key is configured in `src/Constants/Constants.js`.

**Note**: For production use, consider moving the API key to environment variables for better security.

## ▶️ Running the Application

### Development Mode

Start the development server:
```bash
npm start
# or
npm run dev
```

The app will open at [http://localhost:3000](http://localhost:3000) in your browser.

### Production Build

Create an optimized production build:
```bash
npm run build
```

### Testing

Run the test suite:
```bash
npm test
```

## 📁 Project Structure

```
netflix_react/
├── public/
│   ├── index.html
│   └── ...
├── src/
│   ├── Components/
│   │   ├── Banner/
│   │   │   ├── Banner.js          # Hero banner component
│   │   │   └── Banner.css
│   │   ├── NavBar/
│   │   │   ├── NavBar.js          # Navigation bar component
│   │   │   └── NavBar.css
│   │   └── RowPost/
│   │       ├── RowPost.js         # Movie row component with trailer functionality
│   │       └── RowPost.css
│   ├── Constants/
│   │   ├── Constants.js           # API configuration (base URL, API key, image URL)
│   │   └── urls.js                # API endpoint URLs
│   ├── axios/
│   │   └── axios.js               # Axios instance configuration
│   ├── App.js                     # Main application component
│   ├── App.css                    # Global styles
│   ├── index.js                   # Application entry point
│   └── index.css                  # Base styles
├── package.json
└── README.md
```

## 🧩 Components

### Banner Component
- Fetches trending movies/TV shows
- Displays a random selection with backdrop image
- Shows movie title, overview, and action buttons

### NavBar Component
- Displays Netflix logo
- Shows user avatar

### RowPost Component
- Displays movies in a horizontal scrolling row
- Supports different sizes (normal and small posters)
- Fetches and displays YouTube trailers on click
- Accepts props:
  - `url`: API endpoint for fetching movies
  - `title`: Category title
  - `isSmall`: Boolean to render smaller posters

## 🔌 API Integration

The application integrates with [The Movie Database (TMDB) API](https://www.themoviedb.org/):

- **Base URL**: `https://api.themoviedb.org/3/`
- **Endpoints Used**:
  - Trending content: `trending/all/week`
  - Netflix Originals: `discover/tv?with_networks=213`
  - Action Movies: `discover/movie?with_genres=28`
  - Movie Videos/Trailers: `movie/{id}/videos`

## 📦 Dependencies

- **react** (^19.1.0): UI library
- **react-dom** (^19.1.0): React DOM rendering
- **react-scripts** (5.0.1): Create React App scripts
- **axios** (^1.9.0): HTTP client for API requests
- **react-youtube** (^10.1.0): YouTube video player component
- **@testing-library/react** (^16.3.0): React testing utilities

## 🎨 Styling

- Custom CSS files for each component
- Dark theme with Netflix-inspired color scheme (#111 background)
- Responsive poster images from TMDB
- Smooth hover effects and transitions

## 🔒 Security Note

The API key is currently hardcoded in the source code. For production deployments:
1. Store the API key in environment variables
2. Use `.env` file (add it to `.gitignore`)
3. Access via `process.env.REACT_APP_API_KEY`

## 🚀 Deployment

The app can be deployed to various platforms:

### Vercel
```bash
npm install -g vercel
vercel
```

### Netlify
```bash
npm run build
# Drag and drop the build folder to Netlify
```

### GitHub Pages
See [Create React App deployment docs](https://create-react-app.dev/docs/deployment/)

## 🐛 Troubleshooting

**Issue**: API requests failing
- Verify the API key in `src/Constants/Constants.js` is valid
- Check your internet connection
- Ensure TMDB API is accessible

**Issue**: Videos not playing
- Ensure the movie has an available trailer on YouTube
- Check browser console for errors

## 📝 Future Enhancements

- [ ] Add more movie genres
- [ ] Implement search functionality
- [ ] Add user authentication
- [ ] Create movie detail pages
- [ ] Add favorites/watchlist feature
- [ ] Implement responsive design improvements
- [ ] Add loading states and error handling
- [ ] Optimize API calls with caching

## 👨‍💻 Development

This project was created with [Create React App](https://github.com/facebook/create-react-app).

## 📄 License

This project is open source and available for educational purposes.

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the movie data API
- Netflix for design inspiration

---
Made with ❤️ using React
''',
    ),

    Project(
      id: '2',
      title: 'Movie App',
      description: 'Movie App - A movie app with search functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMovieApp,
      screenshots: [
        AppAssets.projectMovieApp01,
        AppAssets.projectMovieApp02,
        AppAssets.projectMovieApp03,
        AppAssets.projectMovieApp04,
        AppAssets.projectMovieApp05,
        AppAssets.projectMovieApp06,
        AppAssets.projectMovieApp07,
        AppAssets.projectMovieApp08,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
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
''',
    ),

    Project(
      id: '3',
      title: 'Leo Inspector Admin',
      description:
          'Leo Inspector Admin  - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [AppAssets.projectInspector],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# LEO Inspector Admin

LEO Inspector Admin is a comprehensive mobile application built with Flutter for managing certificate inspections. The application provides different interfaces for Admins, Inspectors, Clients, and Guests to handle various aspects of certificate management, inspection processes, and request handling.

## Table of Contents
- [Features](#features)
- [Application Flow](#application-flow)
- [User Roles](#user-roles)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Assets](#assets)
- [Fonts](#fonts)

## Features

### Admin Features
- Manage Inspectors (Add, Delete, Search, Detailed View)
- Manage Clients (Add, Delete, Search, Detailed View)
- Manage Certificates (List, Search, Download)
- Manage Requests (List, View, Search, Call)
- QR Code Scanner
- Notifications
- Settings (Company Profile, Admin Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Inspector Features
- Inspection processes with equipment type selection
- Form filling and checklist completion
- PDF generation for certificates
- Issued Certificates management
- Edit Certificate functionality
- QR Code Scanner
- Notifications
- Settings (Inspector Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Client Features
- Request Form submission
- View and Download Certificates
- QR Code Scanner
- Notifications
- Settings (Client Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Guest Features
- Home access
- QR Code Scanner
- Notifications
- Settings

## Application Flow

```
LEO Inspector Admin
|
|-- Admin
|   |-- Home
|   |   |-- Manage Inspectors
|   |   |   |-- Inspectors List
|   |   |   |-- Search
|   |   |   |-- Add Inspector
|   |   |   |-- Delete Inspector
|   |   |   |-- Detailed view
|   |   |-- Manage Client
|   |   |   |-- Client List
|   |   |   |-- Search
|   |   |   |-- Add Client
|   |   |   |-- Delete Client
|   |   |   |-- Detailed view
|   |   |-- Manage Certificate
|   |   |   |-- Certificate List
|   |   |   |-- Search
|   |   |   |-- Download Certificate
|   |   |-- Manage Request
|   |       |-- Request List
|   |       |-- Request View
|   |       |-- Search
|   |       |-- Call 
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Company Profile
|       |-- Admin Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Inspectors
|   |-- Home
|   |   |-- Inspection
|   |   |   |-- Equipment Type
|   |   |       |-- Fill Form
|   |   |           |-- Fill checklist
|   |   |               |-- Filled Form
|   |   |                   |-- Generate Pdf
|   |   |                       |-- Send to Signature Authority
|   |   |-- Issued Certificates
|   |   |   |-- Search
|   |   |   |-- Client List
|   |   |       |-- Search
|   |   |       |-- Certificate List
|   |   |           |-- Download                
|   |   |-- Edit Certificate
|   |       |-- Search
|   |       |-- Client List
|   |           |-- Search
|   |           |-- Certificate List
|   |               |-- Fill Form
|   |               |-- Fill checklist
|   |                   |-- Filled Form
|   |                       |-- Generate Pdf
|   |                           |-- Send to Signature Authority
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Setting
|       |-- Inspector Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Client
|   |-- Home
|   |   |-- Request Form
|   |   |-- View and Download Certificate
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Client Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Guest
|   |-- Home
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
```

## User Roles

1. **Admin**: Has full access to manage inspectors, clients, certificates, and requests
2. **Inspector**: Can perform inspections, generate certificates, and manage issued certificates
3. **Client**: Can submit requests and view/download certificates
4. **Guest**: Limited access for browsing and scanning QR codes

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Flutter Bloc
- **Networking**: Dio
- **PDF Generation**: Syncfusion Flutter PDF
- **UI Components**: Flutter Neumorphic, Google Fonts
- **Data Storage**: Shared Preferences
- **QR Code**: QR Code Scanner, QR Flutter

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

Key dependencies used in this project:
- flutter_neumorphic: For neumorphic UI design
- dio: For HTTP requests
- flutter_bloc: For state management
- qr_code_scanner: For QR code scanning functionality
- syncfusion_flutter_pdf: For PDF generation and viewing
- shared_preferences: For local data storage
- google_fonts: For custom fonts
- image_picker: For image selection
- path_provider: For accessing device paths

## Assets

The application uses various assets including:
- Icons for different features
- Images for branding and UI elements
- PDF templates and assets

## Fonts

Custom fonts used in the application:
- Barlow-Regular
- Barlow-Medium
- Barlow-Bold
- Barlow-SemiBold

## Contributing

This project is currently maintained by ClanLEO. For major changes, please contact the development team.

## Version

Current version: 1.0.0+1
''',
    ),

    Project(
      id: '4',
      title: 'Leo Inspector',
      description:
          'Leo Inspector - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [AppAssets.projectInspector],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# LEO Inspector

LEO Inspector is a comprehensive mobile application built with Flutter for managing certificate inspections. The application provides different interfaces for Admins, Inspectors, Clients, and Guests to handle various aspects of certificate management, inspection processes, and request handling.

## Table of Contents
- [Features](#features)
- [Application Flow](#application-flow)
- [User Roles](#user-roles)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Assets](#assets)
- [Fonts](#fonts)

## Features

### Admin Features
- Manage Inspectors (Add, Delete, Search, Detailed View)
- Manage Clients (Add, Delete, Search, Detailed View)
- Manage Certificates (List, Search, Download)
- Manage Requests (List, View, Search, Call)
- QR Code Scanner
- Notifications
- Settings (Company Profile, Admin Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Inspector Features
- Inspection processes with equipment type selection
- Form filling and checklist completion
- PDF generation for certificates
- Issued Certificates management
- Edit Certificate functionality
- QR Code Scanner
- Notifications
- Settings (Inspector Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Client Features
- Request Form submission
- View and Download Certificates
- QR Code Scanner
- Notifications
- Settings (Client Profile, Trash, Change Password, Terms and Conditions, Privacy Policy)

### Guest Features
- Home access
- QR Code Scanner
- Notifications
- Settings

## Application Flow

```
LEO Inspector
|
|-- Admin
|   |-- Home
|   |   |-- Manage Inspectors
|   |   |   |-- Inspectors List
|   |   |   |-- Search
|   |   |   |-- Add Inspector
|   |   |   |-- Delete Inspector
|   |   |   |-- Detailed view
|   |   |-- Manage Client
|   |   |   |-- Client List
|   |   |   |-- Search
|   |   |   |-- Add Client
|   |   |   |-- Delete Client
|   |   |   |-- Detailed view
|   |   |-- Manage Certificate
|   |   |   |-- Certificate List
|   |   |   |-- Search
|   |   |   |-- Download Certificate
|   |   |-- Manage Request
|   |       |-- Request List
|   |       |-- Request View
|   |       |-- Search
|   |       |-- Call 
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Company Profile
|       |-- Admin Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Inspectors
|   |-- Home
|   |   |-- Inspection
|   |   |   |-- Equipment Type
|   |   |       |-- Fill Form
|   |   |           |-- Fill checklist
|   |   |               |-- Filled Form
|   |   |                   |-- Generate Pdf
|   |   |                       |-- Send to Signature Authority
|   |   |-- Issued Certificates
|   |   |   |-- Search
|   |   |   |-- Client List
|   |   |       |-- Search
|   |   |       |-- Certificate List
|   |   |           |-- Download                
|   |   |-- Edit Certificate
|   |       |-- Search
|   |       |-- Client List
|   |           |-- Search
|   |           |-- Certificate List
|   |               |-- Fill Form
|   |               |-- Fill checklist
|   |                   |-- Filled Form
|   |                       |-- Generate Pdf
|   |                           |-- Send to Signature Authority
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Setting
|       |-- Inspector Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Client
|   |-- Home
|   |   |-- Request Form
|   |   |-- View and Download Certificate
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
|       |-- Client Profile
|       |-- Trash
|       |-- Change Password
|       |-- Terms and Conditions
|       |-- Privacy Policy
|
|-- Guest
|   |-- Home
|   |-- QrCode Scanner
|   |-- Notifications
|   |-- Settings
```

## User Roles

1. **Admin**: Has full access to manage inspectors, clients, certificates, and requests
2. **Inspector**: Can perform inspections, generate certificates, and manage issued certificates
3. **Client**: Can submit requests and view/download certificates
4. **Guest**: Limited access for browsing and scanning QR codes

## Technology Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: Flutter Bloc
- **Networking**: Dio
- **PDF Generation**: Syncfusion Flutter PDF
- **UI Components**: Flutter Neumorphic, Google Fonts
- **Data Storage**: Shared Preferences
- **QR Code**: QR Code Scanner, QR Flutter

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

Key dependencies used in this project:
- flutter_neumorphic: For neumorphic UI design
- dio: For HTTP requests
- flutter_bloc: For state management
- qr_code_scanner: For QR code scanning functionality
- syncfusion_flutter_pdf: For PDF generation and viewing
- shared_preferences: For local data storage
- google_fonts: For custom fonts
- image_picker: For image selection
- path_provider: For accessing device paths

## Assets

The application uses various assets including:
- Icons for different features
- Images for branding and UI elements
- PDF templates and assets

## Fonts

Custom fonts used in the application:
- Barlow-Regular
- Barlow-Medium
- Barlow-Bold
- Barlow-SemiBold

## Contributing

This project is currently maintained by ClanLEO. For major changes, please contact the development team.

## Version

Current version: 1.0.0+1
''',
    ),

    Project(
      id: '5',
      title: 'Leo Rigging Calculator',
      description: 'Leo Rigging Calculator - A calculator built with flutter.',
      technologies: ['Flutter', 'Dart'],
      imageUrl: AppAssets.projectRigCalculator,
      screenshots: [AppAssets.projectRigCalculator],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# Leo Rigging Calculator

A specialized engineering calculator application built with Flutter for rigging, transportation, and weight calculations.

## Features

- **Rigging Calculator**: Calculate sling tensions, load distributions, and safety factors for various rigging configurations
- **Transportation Calculator**: Determine transportation requirements and constraints for heavy equipment
- **Weight Calculator**: Calculate weights of various materials and objects for engineering purposes

## Screenshots

![App Screenshots](assets/app_logo/leo_logo_large.png)

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 2.17 or higher
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator for mobile testing
- Chrome browser for web testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/leo_rigging_calculator.git
   ```

2. Navigate to the project directory:
   ```bash
   cd leo_rigging_calculator
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the Application

#### Mobile (Android/iOS)
```bash
flutter run
```

#### Web
```bash
flutter run -d chrome
```

#### Desktop (Windows/macOS/Linux)
```bash
flutter run -d windows
```

### Building for Production

#### Android
```bash
flutter build apk
```

#### iOS
```bash
flutter build ios
```

#### Web
```bash
flutter build web
```

#### Desktop
```bash
flutter build windows
```

## Project Structure

```
lib/
├── src/
│   ├── appcolors/          # Color definitions and themes
│   ├── pages/              # UI screens and pages
│   │   ├── rigging_calculator/
│   │   ├── transportation_calculator/
│   │   ├── weight_calculator/
│   │   ├── home_page.dart
│   │   └── splash_screen_page.dart
│   └── app.dart            # Main app configuration
├── main.dart               # Entry point
```

## Dependencies

- flutter: SDK
- cupertino_icons: For iOS-style icons
- carousel_slider: For image sliders
- url_launcher: To open URLs
- smooth_page_indicator: For page indicators

## Development

### Code Style

This project follows the Flutter linting rules defined in analysis_options.yaml.

### Adding New Features

1. Create a new branch for your feature
2. Implement your changes
3. Write tests if applicable
4. Run flutter analyze to check for issues
5. Create a pull request

## Troubleshooting

### Gradle Issues

If you encounter Gradle build issues:
1. Run flutter clean
2. Delete the android/.gradle folder
3. Run flutter pub get
4. Try building again

### Android Build Issues

Ensure you have the correct Android SDK versions installed:
- compileSdkVersion: 33
- minSdkVersion: 16
- targetSdkVersion: 33

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## License

This project is proprietary and confidential. All rights reserved.

## Contact

For support or inquiries, please contact the development team.
''',
    ),

    Project(
      id: '6',
      title: 'Reachout',
      description:
          'Reachout - A social platform for connecting with people.with card creating functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectReachout,
      screenshots: [AppAssets.projectReachout],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
    ),

    Project(
      id: '7',
      title: 'Calculator',
      description: 'Calculator App built with Flutter.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalculator,
      screenshots: [
        AppAssets.projectCalculator01,
        AppAssets.projectCalculator02,
        AppAssets.projectCalculator03,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# YCalc - Scientific Calculator

A modern, feature-rich scientific calculator app built with Flutter, implementing clean architecture principles and the BLoC pattern for state management. The app provides both basic and scientific calculation modes with a beautiful Material Design 3 interface.

## 📱 Features

### Basic Calculator Mode
- **Arithmetic Operations**: Addition (+), Subtraction (-), Multiplication (×), Division (÷)
- **Percentage**: Calculate percentages
- **Clear (AC)**: All clear functionality
- **Backspace (⌫)**: Remove last entered character
- **Decimal Support**: Floating-point number input

### Scientific Calculator Mode
- **Trigonometric Functions**: sin, cos, tan
- **Logarithmic Functions**: log (base 10), ln (natural logarithm)
- **Power Operations**: Exponentiation (^)
- **Square Root**: √
- **Factorial**: !
- **Parentheses**: Support for complex nested expressions
- **Mathematical Constants**: π (pi), e (Euler's number)
- **Advanced Expression Parsing**: Supports complex mathematical expressions

### UI/UX Features
- **Material Design 3**: Modern, polished interface
- **Light/Dark Theme**: Automatic system theme detection with manual override
- **Responsive Design**: Adaptive layout using `flutter_screenutil` for different screen sizes
- **Smooth Animations**: Enhanced user experience with `flutter_animate`
- **Haptic Feedback**: Tactile response on button presses
- **Mode Toggle**: Easy switching between basic and scientific modes via AppBar icon
- **Custom Typography**: Google Fonts (Inter) for improved readability
- **Error Handling**: Graceful handling of invalid expressions and division by zero

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart          # Theme configuration (light/dark)
│
├── features/
│   └── calculator/
│       ├── domain/
│       │   └── entities/
│       │       └── calculator.dart  # Domain entity
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── calculator_bloc.dart      # Business logic & state management
│           │   ├── calculator_event.dart     # Event definitions
│           │   └── calculator_state.dart     # State definitions
│           │
│           ├── pages/
│           │   └── calculator_page.dart      # Main calculator page
│           │
│           └── widgets/
│               ├── calc_button.dart          # Reusable button widget
│               ├── display_screen.dart       # Expression & result display
│               ├── keyboard_grid.dart        # Keyboard layout (basic/scientific)
│               └── mode_switch.dart          # Mode toggle widget
│
└── main.dart                                # App entry point
```

### Architecture Layers

1. **Domain Layer** (`domain/`)
   - Contains business entities and core domain logic
   - Calculator entity with expression and result

2. **Presentation Layer** (`presentation/`)
   - BLoC for state management
   - UI widgets and pages
   - Event-driven architecture

## 🔄 State Management

The app uses the **BLoC (Business Logic Component) Pattern** via `flutter_bloc`:

### Events
- `InputNumber`: Adds a number to the expression
- `InputOperator`: Adds an operator (+, -, ×, ÷, =)
- `InputFunction`: Adds a mathematical function (sin, cos, log, etc.)
- `InputConstant`: Adds constants (π, e)
- `ClearInput`: Clears the entire expression
- `Backspace`: Removes the last character
- `CalculateResult`: Evaluates the current expression
- `ToggleMode`: Switches between basic and scientific modes

### States
- `CalculatorInitial`: Initial state with empty expression
- `CalculatorUpdated`: State with current expression and result

### State Flow
```
User Action → Event → BLoC Handler → State Update → UI Rebuild
```

## 🛠️ Technology Stack

### Core Dependencies
- **Flutter SDK**: ^3.9.0
- **flutter_bloc**: ^8.1.3 - State management
- **math_expressions**: ^2.4.0 - Mathematical expression parsing and evaluation

### UI Dependencies
- **google_fonts**: ^6.1.0 - Custom typography
- **flutter_animate**: ^4.3.0 - Smooth animations
- **flutter_screenutil**: ^5.9.0 - Responsive design utilities

### Development Dependencies
- **flutter_lints**: ^5.0.0 - Code linting
- **flutter_launcher_icons**: ^0.13.1 - App icon generation
- **flutter_native_splash**: ^2.3.5 - Splash screen configuration

## 📦 Installation

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK (3.9.0 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code / Android Studio (for development)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd y_calc
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- No additional configuration required

#### iOS
- iOS 12.0 or higher
- Run `pod install` in the `ios/` directory if needed

#### Web
- Fully supported, run with `flutter run -d chrome`

#### Desktop (Windows, macOS, Linux)
- Supported platforms with full functionality

## 🧪 Testing

The project includes comprehensive unit tests for the calculator logic:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Test Coverage
- Calculator BLoC state management
- Expression input handling
- Calculation logic
- Mode switching

Test files are located in the `test/` directory:
- `calculator_test.dart` - BLoC unit tests
- `calculator_functionality_test.dart` - Functional tests
- `widget_test.dart` - Widget tests

## 🎨 Customization

### Theme Customization
Modify `lib/core/theme/app_theme.dart` to customize:
- Color scheme (currently Deep Purple)
- Light/Dark theme variants
- Typography styles

### App Icon
App icons are configured in `pubspec.yaml`:
- Icon: `assets/icon/app_icon.png`
- Adaptive icon support for Android
- Custom icon set for iOS

### Splash Screen
Splash screen configuration in `pubspec.yaml`:
- Color: Deep Purple (#673AB7)
- Icon: `assets/splash/splash_icon.png`
- Supports Android 12+ splash screen API

To regenerate icons and splash screen:
```bash
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

## 📐 Expression Evaluation

The calculator uses the `math_expressions` package for robust mathematical expression parsing:

### Supported Operations
- Basic arithmetic: `+, -, *, /`
- Power operations: `^` or `pow(x, y)`
- Functions: `sin, cos, tan, log, ln, sqrt, factorial`
- Constants: `π (pi), e`
- Parentheses: `( )` for grouping

### Expression Processing
1. **Input Collection**: User input is collected as a string
2. **Symbol Replacement**: Display symbols (×, ÷) are converted to math symbols (*, /)
3. **Implicit Multiplication**: Automatically handles cases like `2(3)` → `2*(3)`
4. **Parsing**: Expression is parsed into an abstract syntax tree
5. **Evaluation**: Mathematical evaluation using context model
6. **Error Handling**: Invalid expressions return "Error"

### Example Expressions
- `5 + 3 * 2` → 11
- `sin(π/2)` → 1.0
- `2^3 + log(100)` → 11.0
- `√(16) + √(9)` → 7.0

## 🚀 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines
1. Follow Flutter/Dart style guidelines
2. Write tests for new features
3. Update documentation as needed
4. Ensure all tests pass before submitting

## 📝 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev/)
- State management with [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- Mathematical expressions with [math_expressions](https://pub.dev/packages/math_expressions)
- Design inspiration from Material Design 3

---
**Version**: 1.0.0+1  
**Last Updated**: 2024
''',
    ),

    Project(
      id: '8',
      title: 'Mahathma Veliyancode',
      description: 'Mahathma Veliyancode - A website built with React',
      technologies: ['React', 'useState'],
      imageUrl: AppAssets.projectMahathma,
      screenshots: [
        AppAssets.projectMahathma01,
        AppAssets.projectMahathma02,
        AppAssets.projectMahathma03,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.website,
      readmeContent: '''
# Mahathma Veliyancode - Web Application

A modern web application for **Mahathma Veliyancode**, a social club established in 2000 that performs social activities in Veliyancode, Kerala. This platform enables community members to register, view events, access membership information, and interact with the organization.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Key Components](#key-components)
- [Firebase Setup](#firebase-setup)
- [Available Scripts](#available-scripts)
- [Routing](#routing)
- [Contributing](#contributing)

## 🎯 Overview

This is a React-based single-page application (SPA) that serves as the official website for Mahathma Veliyancode social club. The platform provides:

- **Public Access**: Browse events, learn about the organization, and contact the club
- **Member Features**: Register as a member, view personalized membership cards, and access community resources
- **Admin Dashboard**: Manage members, view statistics, organize events, and track blood group data

## ✨ Features

### Public Features
- **Hero Section**: Welcome page with navigation and community information
- **Events Section**: 
  - View upcoming events in a vertical list
  - Browse past events in a horizontal grid
  - Click "View More" to see detailed event information
- **About Us**: Vision and mission of the organization
- **Contact Form**: 
  - Send messages via EmailJS integration
  - Contact information and social media links

### Member Features
- **User Authentication**: 
  - Secure signup with comprehensive member registration form
  - Login/logout functionality
  - Session management with Firebase Auth
- **Membership Card**: 
  - Interactive flip card showing member details
  - Front side: ID, Name, Blood Group, Date of Birth
  - Back side: Address, Mobile, Email
- **Personalized Experience**: 
  - User-specific content and navigation
  - Quick access to membership card via floating action button

### Admin Features
- **Dashboard** (`/dashboard`):
  - View all registered members
  - Statistics: Male/Female member counts, total members
  - Blood group directory organized by blood type
  - Event management: Add new events with details (title, date, time, description, image)
  - Accessible via admin email: `admin@gmail.com`

## 🛠 Tech Stack

### Core Framework
- **React** 19.1.0 - UI library
- **React Router DOM** 7.5.3 - Client-side routing
- **React Scripts** 5.0.1 - Build tooling (Create React App)

### Backend & Authentication
- **Firebase** 11.6.1
  - Firebase Authentication (Email/Password)
  - Cloud Firestore (Database)

### UI Libraries & Icons
- **Material-UI (MUI)** 7.0.2 - Component library
- **React Icons** 5.5.0 - Icon library
- **Emotion** 11.14.0 - CSS-in-JS styling (used by MUI)
- **Swiper** 11.2.6 - Touch slider library

### Data Visualization
- **Chart.js** 4.4.9
- **React-ChartJS-2** 5.3.0

### Services
- **EmailJS** 4.4.1 - Contact form email service

### Testing
- **React Testing Library** 16.3.0
- **Jest** (included with react-scripts)

## 📁 Project Structure

```
mahathma_vkd/
├── public/
│   ├── index.html          # HTML template
│   ├── favicon.ico
│   ├── manifest.json
│   └── robots.txt
├── src/
│   ├── Component/
│   │   ├── AboutUs/        # About section component
│   │   ├── AuthContext/    # Authentication context provider
│   │   ├── Contact/        # Contact form component
│   │   ├── Dashboard/      # Admin dashboard
│   │   ├── EventDetails/   # Individual event details page
│   │   ├── Events/         # Events listing component
│   │   ├── Firebase/       # Firebase configuration
│   │   ├── FloatingBar/    # Floating navigation (commented out)
│   │   ├── Hero/           # Hero/landing section
│   │   ├── Login/          # Login page
│   │   ├── MembershipCard/ # Member card component
│   │   └── Signup/         # Registration page
│   ├── Assets/             # Images and static assets
│   │   ├── logo_big.png
│   │   └── logo_text.png
│   ├── App.js              # Main app component with routing
│   ├── App.css             # Global app styles
│   ├── index.js            # Application entry point
│   ├── index.css           # Global styles
│   ├── reportWebVitals.js  # Performance monitoring
│   └── setupTests.js       # Test configuration
├── package.json            # Dependencies and scripts
└── README.md               # This file
```

## 🚀 Getting Started

### Prerequisites

- **Node.js** (v14 or higher recommended)
- **npm** or **yarn** package manager
- **Firebase account** (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd mahathma_vkd
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure Firebase**
   - The Firebase configuration is already set in `src/Component/Firebase/Firebase.js`
   - Make sure your Firebase project has:
     - Authentication enabled (Email/Password provider)
     - Firestore Database created
     - Collections: `users` and `events`

4. **Configure EmailJS** (for contact form)
   - Service ID: `service_luetwvj`
   - Template ID: `template_5vpqvie`
   - Public Key: `KmiTDTJnuMogsQ9Gr`
   - Update these in `src/Component/Contact/Contact.js` if needed

5. **Start the development server**
   ```bash
   npm start
   ```

6. **Open your browser**
   - Navigate to `http://localhost:3000`

## ⚙️ Configuration

### Firebase Configuration

The Firebase configuration is located in `src/Component/Firebase/Firebase.js`:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyCjiNip6kJFTAtoEXRRmMKrALKY10ix6Og",
  authDomain: "mahathmawebsite.firebaseapp.com",
  projectId: "mahathmawebsite",
  storageBucket: "mahathmawebsite.firebasestorage.app",
  messagingSenderId: "565626635632",
  appId: "1:565626635632:web:772a5fe7de852740c07bb5",
  measurementId: "G-ND9HM6FTWL"
};
```

### Firestore Collections

#### `users` Collection
Stores member information with document ID as user UID:
- `name`, `lastName`, `email`, `mobile`
- `address`, `bloodGroup`, `gender`, `dob`
- `fatherName`, `qualification`
- `profession`, `workplace` (if working)
- `status` (Studying/Working)
- `availability` (Native/Abroad)
- `createdAt` (timestamp)

#### `events` Collection
Stores event information:
- `title`, `date`, `time`, `description`
- `image` (URL)
- `status` (upcoming/past - determined by date comparison)

## 🧩 Key Components

### Authentication System
- **AuthContext** (`src/Component/AuthContext/AuthContext.jsx`): Provides authentication state throughout the app
- **Login** (`src/Component/Login/Login.js`): User login with Firebase Auth
- **Signup** (`src/Component/Signup/Signup.js`): Comprehensive member registration form

### Event Management
- **Events** (`src/Component/Events/Events.js`): Displays upcoming and past events from Firestore
- **EventDetails** (`src/Component/EventDetails/EventDetails.js`): Detailed view of individual events

### Admin Dashboard
- **Dashboard** (`src/Component/Dashboard/Dashboard.js`):
  - Member list with filtering
  - Statistics overview
  - Blood group directory
  - Event creation modal

### Member Features
- **MembershipCard** (`src/Component/MembershipCard/MembershipCard.js`): Interactive flip card with member details
- **HeroSection** (`src/Component/Hero/HeroSection.js`): Landing page with navigation and FAB for membership card

## 📡 Routing

The application uses React Router for navigation:

| Route | Component | Description |
|-------|-----------|-------------|
| `/` | Home | Landing page with Hero, Events, About, Contact sections |
| `/login` | Login | User authentication page |
| `/signup` | Signup | Member registration page |
| `/eventdetails/:Id` | EventDetails | Individual event details page |
| `/membership` | MembershipCard | User's membership card |
| `/dashboard` | Dashboard | Admin dashboard (admin access only) |

## 📜 Available Scripts

### `npm start`
Runs the app in development mode at [http://localhost:3000](http://localhost:3000)

### `npm run build`
Creates an optimized production build in the `build` folder

### `npm test`
Launches the test runner in interactive watch mode

### `npm run eject`
**⚠️ Warning: This is a one-way operation!** Ejects from Create React App to expose configuration files

## 🔐 Admin Access

To access the admin dashboard:
1. Sign up or log in with email: `admin@gmail.com`
2. The application will automatically redirect to `/dashboard` after login
3. Admin features include:
   - View all registered members
   - View member statistics
   - Browse blood group directory
   - Add new events

## 🌐 Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## 📝 Development Notes

- The app uses **React 19.1.0** with modern hooks and context API
- Authentication state is managed globally via `AuthContext`
- Firestore real-time database is used for data persistence
- The contact form uses EmailJS service for sending emails
- Component styles are organized in separate CSS files per component

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is private and proprietary.

## 👥 Contact

**Mahathma Veliyancode**
- **Phone**: +91 9946411699
- **Email**: mahathmavkd123@gmail.com
- **Address**: Mahathma Veliyancode, Veliyancode Kinar, Veliyancode P.O, Malappuram, Kerala - 679579

---
**Built with ❤️ for the Mahathma Veliyancode community**
''',
    ),

    Project(
      id: '9',
      title: 'My Games',
      description:
          'My Games - A collection of games built with Flutter and the Flame game engine.',
      technologies: ['flutter', 'Flame', 'Forge 2D'],
      imageUrl: AppAssets.projectMyGame,
      screenshots: [
        AppAssets.projectMyGame01,
        AppAssets.projectMyGame02,
        AppAssets.projectMyGame03,
        AppAssets.projectMyGame04,
        AppAssets.projectMyGame05,
        AppAssets.projectMyGame06,
        AppAssets.projectMyGame07,
        AppAssets.projectMyGame08,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# Sky Jumper

A Flutter-based Doodle Jump clone built using the Flame game engine and Forge2D physics engine.

## Description

Sky Jumper is a physics-based platform game where players control a character that automatically jumps upward through procedurally generated platforms. The objective is to climb as high as possible while collecting coins for bonus points. The game features three platform types (normal, moving, and broken), stage progression every 1000 points, and local high score persistence.

## Features

- Physics-based movement and collision detection with Forge2D
- Three platform types:
  - Normal platforms (stable)
  - Moving platforms (horizontal movement)
  - Broken platforms (disappear after landing)
- Coin collection system for score bonuses
- Stage progression every 1000 points with changing backgrounds
- Local high score persistence using SharedPreferences
- Cross-platform support: Android, iOS, Web, Linux, macOS, Windows

## Screenshots

(Add screenshots of your game here)

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter extensions
- Android/iOS emulator or physical device for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/sky-jumper.git
   ```

2. Navigate to the project directory:
   ```bash
   cd sky-jumper
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── constants/          # App-wide constants (colors, game settings)
│   └── utils/              # Utility functions (e.g., score formatting)
├── data/local/             # Local data storage logic (score_storage.dart)
├── domain/models/          # Data models (e.g., PlatformType)
├── game/
│   ├── components/         # Flame game entities: Player, Platforms, Coins, Background
│   ├── managers/           # ScoreManager, StageManager
│   └── sky_jumper_game.dart # Main Flame game class
├── presentation/
│   ├── screens/            # Flutter UI screens: Home, Game, Game Over, Mini-games
│   └── widgets/            # Reusable UI elements: ScoreDisplay, StageIndicator
└── main.dart               # Application entry point
```

## Dependencies

- [Flutter](https://flutter.dev/) - UI toolkit for building natively compiled applications
- [Flame](https://pub.dev/packages/flame) - Game engine for Flutter
- [flame_forge2d](https://pub.dev/packages/flame_forge2d) - Physics engine integration for Flame
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Persistent storage for high scores
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - State management

## Running Tests

To run the test suite:
```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Contributing

1. Fork the repository
2. Create a feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some AmazingFeature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the classic Doodle Jump game
- Built with the amazing Flame game engine
''',
    ),

    Project(
      id: '10',
      title: 'Door to Door',
      description:
          'Door to Door Application for Delivering groceries and other essentials from your doorstep.',
      technologies: ['Flutter', 'Getx', 'Flutter Maps', 'Rest Apis'],
      imageUrl: '',
      screenshots: [
        // AppAssets.projectYchat01,
        // AppAssets.projectYchat02,
        // AppAssets.projectYchat03,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
    ),

    Project(
      id: '11',
      title: 'Yachii',
      description: 'Yachii - Company Website with React.',
      technologies: ['React', 'JavaScript', 'useState'],
      imageUrl: AppAssets.projectYachii,
      screenshots: [
        AppAssets.projectYachii01,
        AppAssets.projectYachii02,
        AppAssets.projectYachii03,
        AppAssets.projectYachii04,
        AppAssets.projectYachii05,
        AppAssets.projectYachii06,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.website,
      readmeContent: '''
# Yachii - Modern React Portfolio Website

A modern, responsive portfolio website for Yachii built with React 19, featuring cutting-edge animations, a sleek design system, and seamless API integration.

## 🌟 Key Features

### Modern Design System
- Contemporary UI with glass morphism effects and gradient accents
- Responsive design that works flawlessly across all devices
- Professional color palette with carefully curated typography
- Consistent design language throughout all components

### Advanced Animations
- Smooth scroll animations powered by AOS (Animate On Scroll)
- 40+ custom keyframe animations for engaging micro-interactions
- Staggered loading sequences for dynamic content presentation
- Performance-optimized animations that respect user preferences

### Core Components
- **Dynamic Image Slider**: Auto-advancing carousel with Ken Burns effect
- **Mission Section**: Interactive cards showcasing company objectives
- **Product Showcase**: Elegant display of YChat with "Coming Soon" feature
- **Newsletter Subscription**: Fully functional subscription form with validation
- **Contact Form**: Complete contact solution with real-time feedback
- **Responsive Navigation**: Mobile-friendly header with animated hamburger menu

### Technical Excellence
- Built with React 19 and Vite for lightning-fast performance
- Component-based architecture with lazy loading for optimal speed
- RESTful API integration for contact and newsletter functionality
- Comprehensive error handling and loading states
- Accessibility-first approach with keyboard navigation support

## 🛠️ Technologies Used

| Category | Technologies |
|----------|--------------|
| Frontend | React 19, JavaScript (ES6+) |
| Styling | CSS3, Flexbox, Grid, Bootstrap Icons |
| Build Tool | Vite |
| Routing | React Router DOM v7 |
| Animations | AOS, Custom CSS Keyframes |
| API Client | Axios |
| Utilities | React Scrollspy |
| Linting | ESLint |

## 🚀 Getting Started

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn package manager

## 📁 Project Structure

```
src/
├── assets/           # Static assets and global styles
├── components/       # Reusable UI components
├── layouts/          # Page layouts
├── pages/            # Page components
├── routes/           # Application routing
├── services/         # API service layer
├── config/           # Configuration files
└── App.jsx          # Main application component
```

## 🔧 API Integration

The website integrates with a backend API for:
- Newsletter subscriptions (`/api/newsletter/subscribe`)
- Contact form submissions (`/api/contact/send`)

## 🎨 Design Highlights

### Animations
- 40+ custom CSS keyframe animations
- Staggered element animations for dynamic content
- Continuous animations (float, pulse, heartbeat)
- Loading animations (spin, dots, bars, ripple)
- Background animations (gradient, shimmer, wave)

### Responsive Design
- Mobile-first approach with fluid typography
- Flexible layouts using CSS Grid and Flexbox
- Touch-friendly interactive elements
- Optimized animations for mobile performance

### UI Components
- Glass morphism cards with backdrop blur effects
- Gradient buttons with hover states
- Animated navigation with scroll indicators
- Enhanced form elements with validation feedback

## 📱 Browser Support
- Chrome (latest 2 versions)
- Firefox (latest 2 versions)
- Safari (latest 2 versions)
- Edge (latest 2 versions)

Modern CSS features are progressively enhanced with appropriate fallbacks.

## 🎯 Performance Optimizations
- Lazy loading for non-critical components
- GPU-accelerated animations using transform and opacity
- CSS variables for reduced repetition
- Modular CSS structure for maintainability
- Tree-shaking for minimal bundle size

## 🔮 Future Enhancements
- Dark/light theme toggle
- Advanced WebGL visual effects
- 3D transform animations
- Customizable animation settings
- A/B testing for engagement metrics

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## 📄 License
This project is proprietary and confidential. All rights reserved.

## 👥 Author
Created with passion for modern web experiences.
''',
    ),

    Project(
      id: '12',
      title: 'My Bus',
      description:
          'My Bus App - A bus tracking app with real-time location updates and route information.',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMyBus,
      screenshots: [
        AppAssets.projectMyBus01,
        AppAssets.projectMyBus02,
        AppAssets.projectMyBus03,
        AppAssets.projectMyBus04,
        AppAssets.projectMyBus05,
        AppAssets.projectMyBus06,
        AppAssets.projectMyBus07,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
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
''',
    ),

    Project(
      id: '13',
      title: 'YChat',
      description:
          ' YChat Application for messaging screen mirroring and sharing.',
      technologies: ['Flutter', 'Socket.io', 'flutter webrtc'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [
        AppAssets.projectYchat01,
        AppAssets.projectYchat02,
        AppAssets.projectYchat03,
        AppAssets.projectYchat04,
        AppAssets.projectYchat05,
        // AppAssets.projectYchat06,
        // AppAssets.projectYchat07,
        // AppAssets.projectYchat08,
        // AppAssets.projectYchat09,
        // AppAssets.projectYchat10,
        // AppAssets.projectYchat11,
        // AppAssets.projectYchat12,
        // AppAssets.projectYchat13,
        // AppAssets.projectYchat14,
        // AppAssets.projectYchat15,
        // AppAssets.projectYchat16,
        // AppAssets.projectYchat17,
        // AppAssets.projectYchat18,
        // AppAssets.projectYchat19,
        // AppAssets.projectYchat20,
        // AppAssets.projectYchat21,
        // AppAssets.projectYchat22,
        // AppAssets.projectYchat23,
        // AppAssets.projectYchat24,
        // AppAssets.projectYchat25,
        // AppAssets.projectYchat26,
        // AppAssets.projectYchat27,
        // AppAssets.projectYchat28,
        // AppAssets.projectYchat29,
        // AppAssets.projectYchat30,
        // AppAssets.projectYchat31,
        // AppAssets.projectYchat32,
        // AppAssets.projectYchat33,
        // AppAssets.projectYchat34,
        // AppAssets.projectYchat35,
        // AppAssets.projectYchat36,
        // AppAssets.projectYchat37,
        // AppAssets.projectYchat38,
        // AppAssets.projectYchat39,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
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
''',
    ),

    Project(
      id: '14',
      title: 'YChat Admin',
      description: 'Admin App for YChat App',
      technologies: ['flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [
        AppAssets.projectYchatAdmin01,
        AppAssets.projectYchatAdmin02,
        AppAssets.projectYchatAdmin03,
        AppAssets.projectYchatAdmin04,
        AppAssets.projectYchatAdmin05,
        AppAssets.projectYchatAdmin06,
        AppAssets.projectYchatAdmin07,
        AppAssets.projectYchatAdmin08,
        AppAssets.projectYchatAdmin09,
        AppAssets.projectYchatAdmin10,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.website,
      readmeContent: '''
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
  print('Connection state: \$state');
});

// Listen to messages
SocketManager.instance.messageStream.listen((data) {
  print('Received: \$data');
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
''',
    ),

    // E-commerce Platform Project
    Project(
      id: '15',
      title: 'E-Commerce Platform',
      description:
          'Full-featured e-commerce platform with product catalog, shopping cart, and payment processing',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      imageUrl: AppAssets.projectEcommerce,
      screenshots: [
        AppAssets.projectEcommerce01,
        AppAssets.projectEcommerce02,
        AppAssets.projectEcommerce03,
        AppAssets.projectEcommerce04,
        AppAssets.projectEcommerce05,
        AppAssets.projectEcommerce06,
        AppAssets.projectEcommerce07,
        AppAssets.projectEcommerce08,
        AppAssets.projectEcommerce09,
        AppAssets.projectEcommerce10,
        AppAssets.projectEcommerce11,
        AppAssets.projectEcommerce12,
        AppAssets.projectEcommerce13,
        AppAssets.projectEcommerce14,
        AppAssets.projectEcommerce15,
        AppAssets.projectEcommerce16,
        AppAssets.projectEcommerce17,
        AppAssets.projectEcommerce18,
        AppAssets.projectEcommerce19,
        AppAssets.projectEcommerce20,
        AppAssets.projectEcommerce21,
        AppAssets.projectEcommerce22,
        AppAssets.projectEcommerce23,
        AppAssets.projectEcommerce24,
        AppAssets.projectEcommerce25,
        AppAssets.projectEcommerce26,
        AppAssets.projectEcommerce27,
        AppAssets.projectEcommerce28,
        AppAssets.projectEcommerce29,
        AppAssets.projectEcommerce30,
        AppAssets.projectEcommerce31,
        AppAssets.projectEcommerce32,
        AppAssets.projectEcommerce33,
        AppAssets.projectEcommerce34,
        AppAssets.projectEcommerce35,
        AppAssets.projectEcommerce36,
        AppAssets.projectEcommerce37,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeContent: '''
# E-Commerce Platform

A full-featured e-commerce platform built with Flutter and Firebase, featuring a complete shopping experience with product catalog, shopping cart, user authentication, and payment processing.

## Features

- Product catalog with categories and search functionality
- Shopping cart with quantity adjustment
- User authentication and profile management
- Secure payment processing with Stripe
- Order history and tracking
- Responsive design for all device sizes
- Admin dashboard for product and order management

## Technologies Used

- Flutter for cross-platform mobile development
- Firebase for backend services (Authentication, Firestore, Storage)
- Stripe for payment processing
- Provider for state management
- Custom UI components for a modern shopping experience

## Screenshots

![Product Catalog](assets/projects/ecommerce/ecommerce01.jpeg)
![Product Details](assets/projects/ecommerce/ecommerce02.jpeg)
![Shopping Cart](assets/projects/ecommerce/ecommerce03.jpeg)
![Checkout Process](assets/projects/ecommerce/ecommerce04.jpeg)
![Order Confirmation](assets/projects/ecommerce/ecommerce05.jpeg)

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Firebase project setup
- Stripe account for payment processing

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Set up Firebase configuration files
4. Configure Stripe payment keys
5. Run `flutter run` to start the application

## Project Structure

```
lib/
├── src/
│   ├── models/           # Data models for products, users, orders
│   ├── services/          # Firebase and Stripe service integrations
│   ├── providers/         # State management with Provider
│   ├── ui/                # UI components and screens
│   │   ├── screens/       # Main application screens
│   │   ├── widgets/       # Reusable UI components
│   │   └── themes/        # App themes and styling
│   └── utils/             # Utility functions and helpers
├── main.dart              # Entry point
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a pull request

## License

This project is proprietary and confidential. All rights reserved.
''',
    ),
  ];

  static List<Project> getAllProjects() => List.from(projects.reversed);

  static List<ProjectDesign> getDesigns(bool isDark, bool isMobile) {
    return [
      // Design 1 - Brown/Coral theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF6B6B).withValues(alpha: 0.7)
            : const Color(0xFFE88B8B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF4A4A4A) : const Color(0xFF5A5A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -150.0 : -100.0,
            top: isMobile ? -100.0 : -80.0,
            width: isMobile ? 350.0 : 450.0,
            height: isMobile ? 350.0 : 450.0,
            color: isDark
                ? const Color(0xFF4A3A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B6B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(250),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(300),
            ),
          ),
          BlobShape(
            left: isMobile ? -120.0 : -80.0,
            bottom: isMobile ? -120.0 : -100.0,
            width: isMobile ? 320.0 : 400.0,
            height: isMobile ? 320.0 : 400.0,
            color: isDark
                ? const Color(0xFF5A4A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B7B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200),
              topRight: Radius.circular(280),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ],
      ),
      // Design 2 - Blue/Purple theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6B8BCF).withValues(alpha: 0.7)
            : const Color(0xFF8BA8E8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A4A5A) : const Color(0xFF4A5A6A),
        blobs: [
          BlobShape(
            right: isMobile ? -140.0 : -90.0,
            top: isMobile ? -110.0 : -90.0,
            width: isMobile ? 340.0 : 440.0,
            height: isMobile ? 340.0 : 440.0,
            color: isDark
                ? const Color(0xFF3A4A5A).withValues(alpha: 0.4)
                : const Color(0xFF6B7B8B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(260),
              topRight: Radius.circular(190),
              bottomLeft: Radius.circular(210),
              bottomRight: Radius.circular(290),
            ),
          ),
          BlobShape(
            left: isMobile ? -110.0 : -70.0,
            bottom: isMobile ? -110.0 : -90.0,
            width: isMobile ? 310.0 : 390.0,
            height: isMobile ? 310.0 : 390.0,
            color: isDark
                ? const Color(0xFF4A5A6A).withValues(alpha: 0.3)
                : const Color(0xFF7B8B9B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(210),
              topRight: Radius.circular(270),
              bottomLeft: Radius.circular(230),
              bottomRight: Radius.circular(190),
            ),
          ),
        ],
      ),
      // Design 3 - Green/Teal theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6BCF8B).withValues(alpha: 0.7)
            : const Color(0xFF8BE8A8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A5A4A) : const Color(0xFF4A6A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -130.0 : -85.0,
            top: isMobile ? -105.0 : -85.0,
            width: isMobile ? 330.0 : 430.0,
            height: isMobile ? 330.0 : 430.0,
            color: isDark
                ? const Color(0xFF3A5A4A).withValues(alpha: 0.4)
                : const Color(0xFF6B8B7B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(240),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(280),
            ),
          ),
          BlobShape(
            right: isMobile ? -115.0 : -75.0,
            bottom: isMobile ? -115.0 : -95.0,
            width: isMobile ? 315.0 : 395.0,
            height: isMobile ? 315.0 : 395.0,
            color: isDark
                ? const Color(0xFF4A6A5A).withValues(alpha: 0.3)
                : const Color(0xFF7B9B8B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(195),
              topRight: Radius.circular(265),
              bottomLeft: Radius.circular(225),
              bottomRight: Radius.circular(200),
            ),
          ),
        ],
      ),
      // Design 4 - Orange/Amber theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF8B6B).withValues(alpha: 0.7)
            : const Color(0xFFE8A88B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF5A4A3A) : const Color(0xFF6A5A4A),
        blobs: [
          BlobShape(
            right: isMobile ? -135.0 : -88.0,
            top: isMobile ? -108.0 : -88.0,
            width: isMobile ? 335.0 : 435.0,
            height: isMobile ? 335.0 : 435.0,
            color: isDark
                ? const Color(0xFF5A4A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B7B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(255),
              topRight: Radius.circular(185),
              bottomLeft: Radius.circular(215),
              bottomRight: Radius.circular(295),
            ),
          ),
          BlobShape(
            left: isMobile ? -118.0 : -78.0,
            bottom: isMobile ? -112.0 : -92.0,
            width: isMobile ? 318.0 : 398.0,
            height: isMobile ? 318.0 : 398.0,
            color: isDark
                ? const Color(0xFF6A5A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B8B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(205),
              topRight: Radius.circular(275),
              bottomLeft: Radius.circular(235),
              bottomRight: Radius.circular(185),
            ),
          ),
        ],
      ),
    ];
  }

  static Map<String, IconData> getTechIcons() {
    return {
      'Flutter': Icons.flutter_dash,
      'Dart': Icons.code,
      'React': Icons.web,
      'Firebase': Icons.cloud,
      'JavaScript': Icons.javascript,
      'TypeScript': Icons.code_rounded,
      'Node.js': Icons.dns_rounded,
      'MongoDB': Icons.storage_rounded,
      'Material UI': Icons.palette_outlined,
      'Redux': Icons.settings_suggest_rounded,
      'Stripe': Icons.payment_rounded,
      'Provider': Icons.layers_rounded,
      'Riverpod': Icons.device_hub_rounded,
      'Chart.js': Icons.bar_chart_rounded,
      'OpenWeather API': Icons.wb_sunny_outlined,
      'Google Maps': Icons.map_outlined,
      'Health API': Icons.favorite_outline,
    };
  }
}
