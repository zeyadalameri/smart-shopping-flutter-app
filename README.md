# Smart Shopping App

Smart Shopping is a Flutter graduation project that helps users discover nearby markets and browse available offers through a location-aware mobile interface. The project received **94/100** in both graduation-project evaluations at Sana'a University.

## Overview

This repository contains the Flutter client. It connects to an external REST API for authentication, market, product, offer, and location data; the backend source is not included here.

## Key Features

- Account registration and authentication
- Nearby-market discovery using the device location and API radius queries
- Market, category, product, and offer browsing
- Google Maps integration and location permissions
- Local favourites stored with SharedPreferences
- Arabic and English interfaces
- Light and dark themes
- Firebase Cloud Messaging and local-notification integration
- GetX-based navigation, dependency injection, and state management

## Tech Stack

- Flutter and Dart
- GetX
- REST APIs with the `http` package
- Geolocator and Google Maps
- Firebase Messaging and Flutter Local Notifications
- SharedPreferences

## Architecture

The code is grouped into reusable core services and feature modules containing controllers, data sources, models, bindings, and views. The Flutter client sends the user's coordinates and search radius to the external API; distance calculation and market selection are not implemented locally in this repository.

## Getting Started

1. Install a compatible Flutter SDK.
2. Install packages:

```bash
flutter pub get
```

3. Create `android/local.properties` and add a restricted Google Maps key:

```properties
GOOGLE_MAPS_API_KEY=your_restricted_key
```

4. Review the tracked `lib/firebase_options.dart` FlutterFire configuration. These values are standard public client identifiers, not server credentials, but their API keys should still be restricted to the intended Firebase services and application identifiers.
5. Start the application:

```bash
flutter run
```

The Google Maps credential in `android/local.properties` must remain untracked and restricted to the Android application. The public API endpoint is configured in the application constants and may require replacement if the original service is unavailable.

## My Role

I developed the cross-platform mobile client as part of my Information Technology graduation project, covering application structure, REST integration, location features, maps, notifications, localisation, themes, and local persistence.

## Skills Demonstrated

Flutter application architecture, REST API integration, state management, geolocation, map integration, push notifications, localisation, and mobile UI development.

## Project Status and Limitations

- Academic graduation project; not a production service
- Backend implementation and deployment are outside this repository
- The configured external API may not remain publicly available
- Maps and Firebase require developer-owned, restricted credentials
- No checkout or payment workflow is implemented in this client

## License

No open-source license has been declared.
