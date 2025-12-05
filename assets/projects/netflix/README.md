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