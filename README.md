# Flutter Portfolio

A production-style personal portfolio built with Flutter, featuring responsive layouts, localization, animated UI, and clean navigation.

## Features

- Responsive experience for mobile, tablet, and desktop
- Dark/light theme toggle with persisted preference
- Arabic and English localization support
- Project listing with detail pages and hero transitions
- Contact section with direct email draft creation
- Clean route architecture using `go_router`

## Tech Stack

- Flutter + Dart
- `go_router` for routing
- `provider` for state management
- `flutter_animate` for micro-interactions
- `shared_preferences` for local persistence
- `url_launcher` for external links and email

## Project Structure

```text
lib/
  data/         # profile + portfolio content
  l10n/         # localization files
  models/       # strongly typed entities
  providers/    # theme/locale state
  router/       # route definitions
  screens/      # app screens
  theme/        # color and text theming
  utils/        # reusable helpers
  widgets/      # shared UI components
```

## Run Locally

1. Install Flutter SDK.
2. Run:

```bash
flutter pub get
flutter run
```

## Personalization

Update identity and links in `lib/data/profile_data.dart`:

- `fullName`
- `email`
- `linkedInUrl`
- `githubUrl`
- `cvUrl`
- `avatarUrl`

Then replace portfolio entries in `lib/data/portfolio_data.dart` with your real project data.
