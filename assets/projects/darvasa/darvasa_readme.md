# Darvasa

**Darvasa** is India's #1 food delivery application website. This platform allows users to seamlessly discover restaurants, order food online, and have it delivered directly to their doorstep. 

This repository contains the web front-end for the Darvasa platform, built emphasizing a highly responsive, modern user experience and robust architecture.

## 🚀 Tech Stack

The project is built using modern web development technologies to ensure performance, scalability, and developer experience:

- **Framework**: [Next.js](https://nextjs.org/) (App Router, Version 16+)
- **UI Library**: [React 19](https://react.dev/)
- **Styling**: [Tailwind CSS v4](https://tailwindcss.com/) with utility libraries (`clsx`, `tailwind-merge`, `tailwindcss-animate`)
- **Icons**: [Lucide React](https://lucide.dev/)
- **Typing**: [TypeScript](https://www.typescriptlang.org/)
- **Fonts**: Custom optimized Google Fonts (`Lexend`, `Playfair Display`, `PT Sans Narrow`) via `next/font/google`.

## 📁 Project Structure

The project relies on the Next.js App Router paradigm, housed inside the `src/` directory.

```text
src/app/
├── components/     # Reusable UI components (Navbar, Hero, Features, Footer, etc.)
├── context/        # React Context providers (e.g., CartProvider for global cart state)
├── hooks/          # Custom React hooks for business logic
├── lib/            # Utility functions and shared library configurations
├── shop/           # Routes and pages specific to the shopping/restaurant browsing experience
├── summary/        # Routes for order summaries and checkout
├── layout.tsx      # Root application layout inclusive of fonts, metadata, and core providers
├── page.tsx        # Homepage (Landing page) with promotional and feature sections
└── globals.css     # Global stylesheets and Tailwind CSS directives
```

## 🛠️ Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Ensure you have Node.js (v20+ recommended) and `npm` installed on your development machine.

### Installation

1. **Clone the repository** (if not already local):
   ```bash
   git clone <repository-url>
   cd darvasa
   ```

2. **Install the dependencies**:
   ```bash
   npm install
   ```

### Running the Development Server

Start the application in development mode with Hot-Module Replacement (HMR):

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your web browser to view the application.

### Building for Production

To create an optimized production build, run:

```bash
npm run build
```

You can then start the production server:

```bash
npm run start
```

## 🧩 Key Features (Homepage)
Based on the component structure, the landing page includes:
- **Hero Section**: High-impact introduction.
- **Better Food**: Highlighting food quality and variety.
- **App Features**: Demonstrating the benefits of ordering via Darvasa.
- **Download CTA**: Prompts to download the mobile application.

## 🛒 State Management
The application utilizes React Context (`CartProvider`) to manage shopping cart state across the platform seamlessly, ensuring items added in the shop are accurately reflected in the summary and checkout tiers.