# NUPI AI Assistant App Icon

## Icon Design Specifications

The NUPI AI Assistant uses a brain/AI-themed icon with vibrant gradient colors matching the app's theme.

### Design Concept
- **Symbol**: Brain or AI chip icon
- **Colors**: Blue → Purple gradient (matching app theme)
- **Style**: Modern, minimalist, professional
- **Background**: Solid gradient or white with shadow

### Required Sizes

For public App Store release, you need to provide:

#### iOS
- **1024x1024px** - App Store and iOS devices (all sizes)
  - File: `AppIcon-1024.png`
  - Format: PNG without transparency
  - Color space: sRGB or Display P3

#### macOS
- **512x512px** (@1x) - Mac App Store
  - File: `AppIcon-Mac-512.png`
- **1024x1024px** (@2x) - Mac App Store
  - File: `AppIcon-Mac-1024.png`

### How to Create Your Icon

#### Option 1: Use an Icon Generator
1. Visit [appicon.co](https://appicon.co) or [makeappicon.com](https://makeappicon.com)
2. Upload a 1024x1024px source image
3. Generate all sizes automatically
4. Download and add to Assets.xcassets/AppIcon.appiconset/

#### Option 2: Design in Figma/Sketch/Illustrator
1. Create a 1024x1024px canvas
2. Design your icon with the brain/AI theme
3. Use gradient: Blue (#007AFF) → Purple (#AF52DE)
4. Export as PNG files at the required sizes
5. Add to Assets.xcassets/AppIcon.appiconset/

#### Option 3: Use SF Symbols
1. Open SF Symbols app on Mac
2. Search for "brain.head.profile" or similar
3. Export at high resolution
4. Add gradient overlay in image editor
5. Export at required sizes

### Design Guidelines

**Do:**
- Use simple, recognizable shapes
- Ensure icon is visible at small sizes
- Use high contrast
- Follow iOS/macOS design guidelines
- Test on actual devices

**Don't:**
- Use transparency (not allowed for iOS icons)
- Include text (hard to read at small sizes)
- Use photos (should be illustrative)
- Copy copyrighted designs

### Current Placeholder

The app currently uses a placeholder configuration. To add your custom icon:

1. Create or obtain your icon images
2. Add them to `NUPIApp/NUPIApp/Assets.xcassets/AppIcon.appiconset/`
3. Name them exactly as specified above
4. Build and run to test

### Icon Testing Checklist

Before App Store submission, verify:
- [ ] 1024x1024px iOS icon added
- [ ] Icon displays correctly in Xcode
- [ ] Icon visible on Home Screen (test device)
- [ ] Icon visible in Settings
- [ ] Icon visible in App Store listing
- [ ] macOS icons added (if distributing on Mac)
- [ ] All icons use correct color space (sRGB/P3)
- [ ] No transparency in icons
- [ ] Icons look good in dark mode

### Recommended Tools

- **Figma** (free, web-based)
- **Sketch** (Mac, paid)
- **Adobe Illustrator** (paid)
- **AppIconBuilder** (Mac, free)
- **Icon Slate** (Mac, paid)
