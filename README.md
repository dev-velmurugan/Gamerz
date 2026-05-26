# Gamerz Bank - Flutter App

> **Assignment Submission** for Conceps Media Works – Flutter Developer Position

## 📱 App Overview

**Gamerz Bank** is a cross-platform gaming & fantasy sports mobile application built with Flutter. It features a complete user onboarding flow, OTP-based authentication, a rich home dashboard, and dedicated game screens for Cricket, Rummy, Lottery, Casino, and Horse Racing.

---

## 🗂️ Project Structure

```
gamerz_bank/
├── lib/
│   ├── core/
│   │   ├── constants/        # AppColors, AppStrings, AppRoutes
│   │   ├── theme/            # AppTheme (dark theme)
│   │   └── utils/            # Validators
│   ├── data/
│   │   ├── models/           # UserModel, GameModel (json_serializable)
│   │   ├── repositories/     # AuthRepository
│   │   └── services/         # ApiService (Dio)
│   ├── presentation/
│   │   ├── splash/           # SplashScreen (animated)
│   │   ├── onboarding/       # OnboardingScreen (3 slides + PageIndicator)
│   │   ├── auth/             # Login, OTP, EnterName, Congrats screens
│   │   ├── home/             # HomeScreen (full dashboard)
│   │   ├── games/            # Cricket, Rummy, Lottery, Casino, HorseRacing
│   │   └── widgets/          # GradientButton, CustomTextField, WalletBadge
│   ├── providers/            # AuthProvider, GameProvider (Provider)
│   ├── app_router.dart       # GoRouter navigation
│   └── main.dart             # App entry point
├── android/                  # Android configuration
├── ios/                      # iOS configuration
└── assets/
    ├── images/
    └── icons/
```

---

## ✅ Features Implemented

### Screens
- [x] **Splash Screen** – Animated GB logo with scale + fade animation
- [x] **Onboarding** (3 slides) – SmoothPageIndicator, swipeable pages
- [x] **Login** – Mobile number input (+91), age verification checkbox
- [x] **OTP Verification** – 6-digit input, resend countdown timer
- [x] **Enter Name** – Profile setup screen
- [x] **Congratulations** – Animated checkmark badge
- [x] **Home Dashboard** – Categories, IPL banner, game grid, fantasy sports, match card, game center, pure luck games
- [x] **Cricket Screen** – T20 World Cup banner + match cards
- [x] **Rummy Screen** – Game variants with entry ranges
- [x] **Lottery / Casino / Horse Racing** – Individual screens

### Technical
- [x] **State Management** – Provider (AuthProvider, GameProvider)
- [x] **Navigation** – GoRouter with named routes
- [x] **HTTP Client** – Dio with interceptors (auth token, logging, error handling)
- [x] **JSON Serialization** – json_serializable + json_annotation
- [x] **Local Storage** – SharedPreferences (token, onboarding flag, user data)
- [x] **Form Validation** – Mobile (10-digit), OTP (6-digit), Name validators
- [x] **Dark Theme** – Full Material3 dark theme with gold (#BFA45A) primary
- [x] **Responsive UI** – Works across phone screen sizes
- [x] **Animations** – Splash scale/fade, congrats elastic scale, button gradients

---

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code with Flutter extension
- Android emulator / iOS simulator / physical device

### Steps

```bash
# 1. Clone / extract the project
cd gamerz_bank

# 2. Get dependencies
flutter pub get

# 3. Run on Android
flutter run

# 4. Run on iOS (macOS only)
cd ios && pod install && cd ..
flutter run

# 5. Build APK
flutter build apk --release

# 6. Build iOS IPA (macOS + Xcode required)
flutter build ipa
```

---

## 🔧 Third-Party Services Used

| Package | Purpose |
|---|---|
| `provider` | State management |
| `go_router` | Navigation & routing |
| `dio` | HTTP client with interceptors |
| `json_annotation` + `json_serializable` | JSON serialization |
| `shared_preferences` | Local token & session storage |
| `smooth_page_indicator` | Onboarding dots indicator |
| `firebase_core` | Firebase initialization (configured, ready to enable) |
| `firebase_auth` | Firebase phone auth (bonus, configured) |
| `cloud_firestore` | Firestore DB (configured) |
| `firebase_messaging` | FCM push notifications (configured) |
| `flutter_animate` | UI animations |
| `carousel_slider` | Image carousels |
| `cached_network_image` | Network image caching |
| `shimmer` | Loading skeleton UI |

---

## 🔥 Firebase Integration

Firebase is configured and ready. To enable:

1. Add your `google-services.json` to `android/app/`
2. Add your `GoogleService-Info.plist` to `ios/Runner/`
3. Uncomment the Firebase lines in:
   - `main.dart` – `Firebase.initializeApp()`
   - `android/app/build.gradle` – `com.google.gms.google-services`
   - `android/build.gradle` – `com.google.gms:google-services`

---

## 📲 App Publishing Readiness

### Android (Google Play Console)
- `applicationId`: `com.conceptsmediaworks.gamerzbank`
- `minSdkVersion`: 21 (Android 5.0+)
- `targetSdkVersion`: Flutter default
- Internet permission declared
- `multiDexEnabled`: true
- Release build type configured

### iOS (App Store Connect)
- `CFBundleIdentifier`: `com.conceptsmediaworks.gamerzbank`
- Deployment target: iOS 12.0+
- Portrait orientation locked
- NSAppTransportSecurity configured
- Usage descriptions for camera/photo

---

## 🏗️ Architecture Explanation

The app follows a **layered architecture**:

```
Presentation Layer  →  Providers (State)  →  Repositories  →  Services (API)
```

- **Presentation**: Screens and widgets, purely UI
- **Providers**: Business logic, holds state, notifies UI
- **Repositories**: Data access abstraction layer
- **Services**: Raw API calls via Dio

This makes the code testable, maintainable, and scalable.

---

## 📝 Assumptions Made

1. The API base URL is mocked locally — replace `_baseUrl` in `api_service.dart` with the real endpoint
2. OTP verification is simulated with a 1-second delay — connect to real SMS gateway
3. Firebase is configured but not activated (requires real `google-services.json`)
4. Wallet balance defaults to ₹200 as shown in the design
5. Images for game banners use gradient + emoji placeholders (real assets would replace these)

---

## 👨‍💻 Developer

Submitted by: **Velmurugan**  
Assignment: Flutter Developer – Conceps Media Works  
Timeline: Within 24 hours
