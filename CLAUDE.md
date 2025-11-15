# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Vectorify** is a Flutter mobile application for creating vector art/graphics. The app features a dark theme with glassmorphism design, credit-based system, and network operations with isolate-based JSON parsing for performance.

A complete plan of this project is written to @plan.md

## Development Commands

### Setup
```bash
flutter pub get                    # Install dependencies
```

### Running the App
```bash
flutter run                        # Run on connected device/simulator
flutter run -d <device_id>         # Run on specific device
flutter run --release              # Run in release mode
```

### Building
```bash
flutter build apk                  # Build Android APK
flutter build ios                  # Build iOS app
flutter build appbundle            # Build Android App Bundle
```

### Code Quality
```bash
flutter analyze                    # Run static analysis
flutter format lib/                # Format Dart code
```

### Testing
```bash
flutter test                       # Run all tests
flutter test test/path/to/test.dart  # Run specific test
```

### Cleaning
```bash
flutter clean                      # Clean build artifacts
flutter pub get                    # Reinstall dependencies after clean
```

## Architecture

### Project Structure

The project follows a **feature-first architecture** with shared common utilities:

```
lib/
├── main.dart                     # App entry point
├── core/                         # Core functionality and services
│   └── services/
│       └── network_service/      # Isolate-based networking
├── features/                     # Feature modules
│   ├── splash/                   # Splash screen feature
│   ├── home/                     # Home screen and creation flow
│   │   ├── presentation/         # UI layer
│   │   ├── view_model/           # State management (to be implemented)
│   │   └── create_art/           # Art creation sub-feature
│   └── [other features]/
└── common/                       # Shared utilities
    ├── theme/                    # Design system (colors, text styles, etc.)
    └── widget/                   # Reusable widgets
```

### Key Architectural Patterns

1. **Feature-First Organization**: Each feature is self-contained with its own presentation, view_model, and domain layers (when applicable).

2. **Presentation-ViewModel Separation**: Features are structured with:
   - `presentation/` - UI components (views, widgets)
   - `view_model/` - Business logic and state management (directories exist but implementation pending)

3. **Part Files Pattern**: Related widgets are organized using Dart's `part` directive (e.g., `home_view.dart` has `part './widgets/_create_card.dart'`). Private widgets start with underscore.

### Network Service Architecture

**Critical**: The app uses a custom `NetworkService` with **persistent isolate-based JSON parsing**:

- **Single Worker Isolate**: One isolate handles all JSON parsing to avoid spawning overhead
- **Must Initialize**: Call `await NetworkService().initialize()` at app startup before any network requests
- **Type-Safe API**: All methods require a `fromJson` factory function for type safety
- **Result Pattern**: Returns `NetworkResult<T>` with `isSuccess`, `data`, `error`, and `statusCode`

#### NetworkService Methods
- `get<T>()`, `getList<T>()` - GET requests
- `post<T>()`, `postList<T>()` - POST requests
- `put<T>()`, `putList<T>()` - PUT requests
- `delete<T>()`, `deleteList<T>()` - DELETE requests
- `uploadFile<T>()` - File uploads with progress
- `downloadFile()` - File downloads with progress
- `setAuthToken()`, `clearAuthToken()` - Authentication
- `updateBaseUrl()` - Dynamic base URL changes

**Example Usage**: See `lib/core/services/network_service_example.dart` for comprehensive examples.

### Design System

All theme-related constants are centralized in `lib/common/theme/`:

- `d_colors.dart` - Color palette with primary (#C6F54C lime) and secondary (#00FFC3 cyan)
- `d_text_styles.dart` - Typography system
- `d_dimens.dart` - Spacing and sizing constants
- `d_decorations.dart` - Reusable box decorations (glassmorphism, gradients)
- `d_shadows.dart` - Shadow definitions
- `d_constants.dart` - Miscellaneous constants

**Naming Convention**: All theme classes/constants are prefixed with `D` (Design).

**Visual Style**: Dark theme with glassmorphism effects, radial gradients, and neon accent colors.

### Common Widgets

Reusable components in `lib/common/widget/`:
- `app_button.dart` - Custom button components
- `credit_chip.dart` - Credit balance display widget
- `theme.dart` - Theme configuration helpers

## Key Implementation Details

1. **App Initialization**: The app title is "Vectorify" with dark theme and `scaffoldBackgroundColor: Color(0xFF0A0A0A)`.

2. **Asset Management**: Assets are defined in `pubspec.yaml`. Currently includes `assets/logo.svg`.

3. **Dependencies**:
   - `dio` (^5.7.0) - HTTP client used by NetworkService
   - `flutter_svg` (^2.2.2) - SVG rendering
   - `image_picker` - Image selection (version not pinned)

4. **Widget Naming**: Private widgets (used via `part` files) start with underscore (e.g., `_CreateCard`, `_CategoriesSection`).

5. **Navigation**: Currently uses basic `Navigator.push` with `MaterialPageRoute`. No routing package configured yet.

6. **State Management**: View model directories exist but implementation is pending. No state management package is currently configured.

## Important Notes

- **No Tests**: The `test/` directory doesn't exist yet. Tests should be created following Flutter's standard testing structure.
- **Network Service Initialization**: Always initialize `NetworkService().initialize()` in `main()` before `runApp()` to ensure the isolate worker is ready.
- **Assets in Git**: HTML files in `assets/screen_uis/` are currently staged but not committed - these appear to be screen mockups/references.
- **Linting**: Uses standard `flutter_lints` package (^5.0.0) with default configuration.
