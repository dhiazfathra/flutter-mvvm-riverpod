# Flutter MVVM Riverpod Template

A minimal Flutter foundation with MVVM + Riverpod for building e-commerce superapps. Focuses on least boilerplate while implementing DRY and SOLID principles.

## Features

- **Splash Screen** - Version check, feature flags loading, announcement display
- **Auth** - Login, token storage (flutter_secure_storage), auto-refresh
- **Feature Flags** - Runtime feature toggles
- **Push Notifications** - FCM integration

## Architecture

```
lib/
├── main.dart              # Entry point
├── app.dart               # App widget
├── core/                  # Reusable infrastructure
│   ├── constants/        # App constants
│   ├── errors/           # Error types
│   ├── network/           # Dio HTTP client
│   ├── router/           # go_router
│   └── storage/          # Secure storage wrapper
├── shared/                # Shared widgets
│   └── widgets/
└── features/
    ├── auth/
    ├── splash/
    ├── feature_flag/
    └── push_notification/
```

## Tech Stack

| Component        | Library                |
| ---------------- | ---------------------- |
| State Management | flutter_riverpod       |
| Routing          | go_router              |
| HTTP Client      | dio                    |
| Secure Storage   | flutter_secure_storage |
| Push             | firebase_messaging     |
| Code Gen         | json_serializable      |
| Linter           | dart_code_linter       |

## Getting Started

```bash
# Clone
git clone https://github.com/dhiazfathra/flutter-mvvm-riverpod.git

# Install dependencies
flutter pub get

# Generate code (after modifying .dart files with json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Run
flutter run

# Test
flutter test

# Analyze with dart_code_linter
dart run dart_code_linter:metrics analyze lib

# Check unused code
dart run dart_code_linter:metrics check-unused-code lib

# Check unused files
dart run dart_code_linter:metrics check-unused-files lib

# Build web
flutter build web
```

## CI/CD

GitHub Actions workflow included in `.github/workflows/`:

```bash
# Runs on: push to main, pull requests
# - flutter analyze
# - flutter test
```

## Notes

- Uses **model/view/view_model** pattern (not data/domain/presentation)
- **json_serializable** only - no freezed or riverpod_generator
- Flat routing (go_router) - until 15+ routes
- Pure Riverpod - StateProvider, AsyncNotifier, StateNotifier

## License

MIT
