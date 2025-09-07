# 📱 Flutter Resume Generator App

A customizable text resume generator Android app built with Flutter that allows users to view and customize resume data with real-time API integration, GPS location tracking, and persistent local storage.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

## 🎯 Features

### 📋 Core Functionality
- **Resume Data Display**: View resume information in clean, formatted text
- **API Integration**: Fetch resume data from REST API endpoint
- **Real-time Customization**: Dynamic font size, font color, and background color adjustment
- **GPS Location**: Display current latitude & longitude in app bar
- **Offline Support**: Local storage with Hive database for settings and resume data
- **Responsive Design**: Material Design UI with smooth interactions

### 🎨 Customization Options
- **Font Size Slider**: Adjustable from 12px to 24px
- **Font Color Picker**: Full color customization with preview
- **Background Color Picker**: Dynamic background color changes
- **Settings Persistence**: All customizations saved locally

### 🔧 Technical Features
- **State Management**: Riverpod for reactive state management
- **Local Database**: Hive for efficient local data storage
- **Location Services**: GPS coordinate tracking with permission handling
- **Network Calls**: HTTP client with error handling and fallback data
- **Cross-platform**: Built with Flutter for Android deployment

## 📸 Screenshots

```
┌─────────────────────┐
│  Resume Generator   │ GPS: 21.23, 72.85
├─────────────────────┤
│ Font Size: 18 ████  │
│ [Font Color] [Bg]   │
├─────────────────────┤
│                     │
│  JOHN DOE           │
│  ═══════════════    │
│                     │
│  SKILLS             │
│  ───                │
│  • Flutter, Dart    │
│  • REST APIs        │
│                     │
│  PROJECTS           │
│  ───                │
│  • Resume App       │
│                     │
└─────────────────────┘
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio or VS Code
- Android emulator or physical device
- Node.js (for backend API)

### 📦 Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.4.9    # State management
  hive: ^2.2.3                # Local database
  hive_flutter: ^1.1.0        # Hive Flutter integration
  http: ^1.1.0                # API calls
  geolocator: ^10.1.0         # GPS location
  permission_handler: ^11.1.0  # Permissions
  flutter_colorpicker: ^1.0.3 # Color picker widget

dev_dependencies:
  hive_generator: ^2.0.1      # Code generation
  build_runner: ^2.4.7        # Build tools
```

## 🛠️ Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/flutter-resume-generator.git
cd flutter-resume-generator
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Generate Hive Adapters
```bash
flutter packages pub run build_runner build
```

### 4. Setup Backend API (Node.js)

#### Create API Server:
```bash
mkdir resume-api && cd resume-api
npm init -y
npm install express cors dotenv
```

#### Create `server.js`:
```javascript
const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

const sampleResumes = [
  {
    name: "John Doe",
    skills: ["Flutter", "Dart", "Mobile Development"],
    projects: ["Resume Generator App", "E-commerce App"],
    email: "john.doe@email.com",
    phone: "+1234567890",
    experience: "2+ years"
  }
];

app.get('/resume', (req, res) => {
  const { name } = req.query;
  let resume = sampleResumes[0];
  if (name) resume.name = name;
  res.json(resume);
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
```

#### Run API Server:
```bash
node server.js
```

### 5. Configure API Endpoint

Update `lib/services/api_service.dart`:
```dart
class ApiService {
  // For emulator
  static const String baseUrl = 'http://10.0.2.2:3000';
  
  // For real device (replace with your IP)
  // static const String baseUrl = 'http://192.168.1.35:3000';
}
```

### 6. Add Android Permissions

In `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### 7. Run the App
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── resume_model.dart        # Resume data model
│   └── settings_model.dart      # User settings model
├── providers/
│   ├── resume_provider.dart     # Resume state management
│   ├── settings_provider.dart   # Settings state management
│   └── location_provider.dart   # GPS location provider
├── services/
│   └── api_service.dart         # HTTP API client
├── screens/
│   └── home_screen.dart         # Main app screen
└── widgets/
    ├── resume_display.dart      # Resume display widget
    └── customization_panel.dart # Settings panel widget
```

## 🔧 Configuration

### API Configuration
The app fetches resume data from a REST API. Configure the endpoint in `api_service.dart`:

```dart
// For different environments:
static const String baseUrl = 'http://10.0.2.2:3000';      // Emulator
static const String baseUrl = 'http://192.168.1.35:3000';  // Local network
static const String baseUrl = 'https://your-api.com';      // Production
```

### Default Data
If the API is unavailable, the app falls back to default resume data:
- Name: Raj Parihar
- Email: pariharraj401@gmail.com
- Phone: 9987357067
- Skills: Flutter, Dart, Mobile Development
- Experience: 1+ years in mobile app development

## 🌐 API Endpoints

The backend API should provide:

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/resume` | Get random resume data |
| GET | `/resume?name=John` | Get resume with custom name |
| GET | `/health` | Health check endpoint |

### API Response Format:
```json
{
  "name": "John Doe",
  "skills": ["Flutter", "Dart", "Mobile Development"],
  "projects": ["Resume Generator", "E-commerce App"],
  "email": "john@email.com",
  "phone": "+1234567890",
  "experience": "2+ years",
  "timestamp": "2023-09-07T12:00:00.000Z"
}
```

## 📱 Usage

### 1. Launch App
- App automatically fetches resume data on startup
- GPS coordinates appear in top-right corner
- Default customization settings are loaded

### 2. Customize Appearance
- **Font Size**: Use slider to adjust text size (12-24px)
- **Font Color**: Tap font color button to open color picker
- **Background**: Tap background color button to change backdrop
- All settings are automatically saved

### 3. Refresh Data
- Tap floating action button (🔄) to fetch new resume data
- App shows loading indicator during API calls
- Falls back to cached/default data if API fails

### 4. GPS Location
- Location permissions are requested on first launch
- Current coordinates displayed in app bar
- Shows "GPS: N/A" if location unavailable

## 🛡️ Permissions

### Android Permissions Required:
- `INTERNET` - API calls and data fetching
- `ACCESS_FINE_LOCATION` - GPS coordinate tracking
- `ACCESS_COARSE_LOCATION` - Approximate location (fallback)

Permissions are requested automatically on app launch.

## 🔍 Troubleshooting

### Common Issues:

#### **API Connection Failed**
```
Error: API Connection failed
```
**Solutions:**
- Verify Node.js server is running: `node server.js`
- Check IP address configuration in `api_service.dart`
- For emulator: Use `http://10.0.2.2:3000`
- For device: Use your computer's IP `http://192.168.1.X:3000`
- Test API in browser: `http://your-ip:3000/resume`

#### **Hive Generation Errors**
```
Error: Target of URI hasn't been generated
```
**Solutions:**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### **Location Permission Denied**
```
GPS: N/A
```
**Solutions:**
- Grant location permissions in device settings
- Restart the app after granting permissions
- Check if location services are enabled on device

#### **Build Errors**
```
Error: Gradle build failed
```
**Solutions:**
- Clean and rebuild: `flutter clean && flutter pub get`
- Update Flutter: `flutter upgrade`
- Check Android SDK configuration

## 🚀 Deployment

### Android APK Build:
```bash
# Debug APK
flutter build apk --debug

# Release APK  
flutter build apk --release

# Split APKs by architecture
flutter build apk --split-per-abi
```

### Android App Bundle (Recommended):
```bash
flutter build appbundle --release
```

## 🌟 Future Enhancements

- [ ] **PDF Export**: Generate downloadable PDF resumes
- [ ] **Multiple Templates**: Different resume layouts and styles
- [ ] **Cloud Sync**: Firebase integration for cross-device sync
- [ ] **Dark Mode**: Theme switching support
- [ ] **Share Feature**: Share resume via social media/email
- [ ] **Profile Pictures**: Image upload and display
- [ ] **Advanced Formatting**: Rich text editing capabilities
- [ ] **Analytics**: Usage tracking and insights

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines:
- Follow Flutter/Dart style guidelines
- Add unit tests for new features
- Update documentation for API changes
- Test on multiple devices/screen sizes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Raj Parihar**
- Email: pariharraj401@gmail.com
- Phone: 9987357067

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- Hive for local storage solution
- Material Design for UI guidelines
- Open source community for inspiration

---

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Search existing [Issues](https://github.com/yourusername/flutter-resume-generator/issues)
3. Create a new issue with detailed description
4. Contact: pariharraj401@gmail.com

---

**⭐ Star this repository if you found it helpful!**