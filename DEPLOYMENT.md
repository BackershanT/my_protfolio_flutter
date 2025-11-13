# 🚀 Deployment Instructions

## Build for Production

### 1. Build Flutter Web App
```bash
flutter build web --release
```

This creates optimized production files in `build/web/`

---

## 🔥 Deploy to Firebase Hosting

### Prerequisites
- Install Firebase CLI: `npm install -g firebase-tools`
- Login to Firebase: `firebase login`

### Steps

1. **Initialize Firebase in your project**
```bash
firebase init hosting
```

2. **Configure firebase.json**
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

3. **Deploy**
```bash
firebase deploy --only hosting
```

Your site will be live at: `https://your-project-id.web.app`

---

## 📦 Deploy to GitHub Pages

### Steps

1. **Build the app**
```bash
flutter build web --release --base-href "/repository-name/"
```

2. **Push to gh-pages branch**
```bash
cd build/web
git init
git add .
git commit -m "Deploy to GitHub Pages"
git branch -M gh-pages
git remote add origin https://github.com/username/repository-name.git
git push -f origin gh-pages
```

3. **Enable GitHub Pages**
- Go to Settings > Pages
- Source: Deploy from branch
- Branch: gh-pages / root
- Save

Your site will be live at: `https://username.github.io/repository-name/`

---

## 🌐 Deploy to Vercel

### Steps

1. **Install Vercel CLI**
```bash
npm i -g vercel
```

2. **Create vercel.json**
```json
{
  "version": 2,
  "routes": [
    {
      "handle": "filesystem"
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

3. **Deploy**
```bash
flutter build web --release
vercel --prod
```

---

## 🔧 Optimization Tips

### 1. Enable Web Renderer
For better performance on web:
```bash
flutter build web --web-renderer canvaskit --release
```

### 2. Add SEO Meta Tags
Edit `web/index.html`:
```html
<head>
  <meta name="description" content="Flutter Developer Portfolio - Showcasing mobile and web applications">
  <meta name="keywords" content="Flutter, Developer, Portfolio, Mobile Apps">
  <meta property="og:title" content="Your Name - Flutter Developer">
  <meta property="og:description" content="Professional Flutter Developer Portfolio">
  <meta property="og:image" content="url-to-your-image.png">
</head>
```

### 3. Add Favicon
Place your favicon in `web/` directory and reference in `index.html`:
```html
<link rel="icon" type="image/png" href="favicon.png"/>
```

---

## 📱 Custom Domain Setup

### Firebase Hosting
1. Go to Firebase Console > Hosting
2. Click "Add custom domain"
3. Follow DNS configuration steps

### GitHub Pages
1. Add a `CNAME` file in `build/web/`:
```
yourdomain.com
```
2. Configure DNS:
   - Type: A Record
   - Host: @
   - Points to: 185.199.108.153 (GitHub IP)

---

## ✅ Post-Deployment Checklist

- [ ] Test on multiple browsers (Chrome, Firefox, Safari)
- [ ] Test on mobile devices
- [ ] Verify all links work
- [ ] Check image loading
- [ ] Test contact form
- [ ] Verify light/dark mode toggle
- [ ] Check SEO meta tags
- [ ] Test scroll animations
- [ ] Verify responsive design

---

## 🐛 Troubleshooting

### Issue: Blank page after deployment
**Solution**: Check base-href matches your hosting path

### Issue: Assets not loading
**Solution**: Ensure `pubspec.yaml` has correct asset paths:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/lottie/
```

### Issue: Routing doesn't work
**Solution**: Add URL rewrite rules (see Firebase/Vercel configs above)

---

## 📊 Analytics Setup (Optional)

Add Google Analytics to `web/index.html`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

---

## 🎉 You're Live!

Your Flutter portfolio is now deployed and accessible worldwide!
