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
| `/dashboard` | Dashboard | Admin dashboard (admin access only)

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