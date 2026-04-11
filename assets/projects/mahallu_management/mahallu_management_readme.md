# Mahallu Management System (MMS)

A comprehensive, multi-tenant digital platform designed for mosques and community committees to manage their operations, finances, and community services efficiently.

## 🌟 Overview

The Mahallu Management System (MMS) provides a robust and scalable solution for mosque committees to digitize their traditional record-keeping. It streamlines family management, automates financial collections, and provides a digital workflow for community services like certificate issuance.

## 🚀 Key Features

### 🏢 Multi-Tenant Architecture
- **Isolated Data**: Each Mahallu (mosque committee) operates in its own secure data space.
- **Super Admin Control**: Global management of Mahallus and system-wide configurations.

### 👥 Role-Based Access Control (RBAC)
- **Super Admin**: System-wide management, creating new Mahallus, and global analytics.
- **Mahallu Admin**: Local committee management, family registration, agent assignment, and certificate approval.
- **Collection Agent**: Mobile-friendly interface for on-field payment collection and real-time receipting.
- **Family User**: Personal dashboard to view payment history, family details, and request certificates.

### 💰 Financial Management
- **Real-time Collections**: Record payments on the go with instant digital receipts.
- **Automated Receipting**: Unique receipt numbers and professional PDF generation.
- **Collection Tracking**: Monitor agent performance and monthly collection targets.

### 📜 Community Services
- **Digital Certificates**: Request and approve Marriage, Membership, and Death certificates digitally.
- **Announcements**: Broadcast important updates and news to the entire community.

### 🌍 Localization (i18n)
- **Multi-language Support**: Full application localization in:
  - 🇺🇸 **English**
  - 🇮🇳 **Malayalam**
  - 🇮🇳 **Tamil**
- **Dynamic Switching**: Seamlessly switch languages from the dashboard header.

## 🛠️ Technologies Used

- **Frontend**: [React 19](https://react.dev/), [TypeScript](https://www.typescriptlang.org/), [Vite](https://vitejs.dev/)
- **State Management**: [Zustand](https://zustand-demo.pmnd.rs/)
- **Database & Auth**: [Firebase](https://firebase.google.com/) (Firestore, Authentication)
- **Internationalization**: [i18next](https://www.i18next.com/), [react-i18next](https://react.i18next.com/)
- **Styling**: [Tailwind CSS 4](https://tailwindcss.com/)
- **Icons**: [Lucide React](https://lucide.dev/)
- **Animations**: [Motion](https://motion.dev/)
- **Reporting**: [Recharts](https://recharts.org/), [jsPDF](https://parall.ax/products/jspdf), [XLSX](https://sheetjs.com/)

## 📁 Project Structure

```text
src/
├── components/     # Reusable UI components (Card, Button, Input, etc.)
├── i18n/           # Localization configuration and locale files (en, ml, ta)
├── lib/            # Utility functions and error handlers
├── pages/          # Page components organized by role (SuperAdmin, Admin, Agent, User)
├── services/       # Firebase and other external service integrations
├── store/          # Zustand state stores
└── types/          # TypeScript interfaces and types
```

## 🚦 Getting Started

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   npm install
   ```
3. **Configure Firebase**:
   - Create a Firebase project.
   - Enable Firestore and Authentication (Google & Email/Password).
   - Add your configuration to `firebase-applet-config.json`.
4. **Run the development server**:
   ```bash
   npm run dev
   ```

## 🔒 Security

- **Firestore Rules**: Granular security rules ensuring data isolation and role-based access.
- **PII Protection**: Sensitive family data is restricted to authorized personnel only.

## 📄 License

This project is licensed under the MIT License.
