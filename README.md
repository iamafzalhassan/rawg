# RAWG

A feature-rich Flutter mobile application demonstrating modern development practices, clean architecture, and seamless third-party integrations for an immersive gaming discovery experience.

## Key Features

**Game Discovery & Search**
- Browse thousands of games with real-time RAWG API integration
- Intelligent debounced search with instant results
- Dynamic platform filtering (PlayStation, Xbox, PC)
- Pagination with infinite scroll and "Load More" functionality
- Comprehensive game details with metacritic scores, publishers, and descriptions

**Offline-First Architecture**
- Smart caching system using Hive for persistent local storage
- Automatic cache fallback when network unavailable
- Time-based cache invalidation (24-hour TTL)
- Real-time connection monitoring with graceful degradation

**Authentication & Security**
- Supabase-powered user authentication
- Secure email/password registration and login
- Real-time form validation with dynamic states
- Session management with automatic route protection

**Push Notifications**
- OneSignal integration with user-specific targeting
- Customizable notification preferences with persistent storage
- Deep linking to game content from notifications
- External user ID mapping for cross-platform tracking

**Internationalization**
- Multi-language support (English, Sinhala)
- Easy Localization integration throughout the app
- Dynamic language switching with persistent preferences

**Technical Excellence**
- Clean Architecture with separation of concerns (data, domain, presentation layers)
- BLoC/Cubit state management for predictable state handling
- Dependency injection using GetIt for modular, testable code
- Repository pattern with abstract data sources
- Comprehensive error handling with localized messages
- Custom reusable UI components (buttons, form fields, app bars)

## Architecture Highlights

- Clean Architecture with SOLID principles
- BLoC pattern for state management
- Repository pattern for data abstraction
- Use case pattern for business logic encapsulation
- Dependency injection for loose coupling
- Feature-based modular structure

## Technical Stack

**Frontend:** Flutter 3.8+, Dart 3.0+
**State Management:** flutter_bloc, Equatable
**Navigation:** GoRouter
**Networking:** Dio with interceptors and logging
**Local Storage:** Hive with custom adapters
**Backend:** Supabase (authentication & database)
**Push Notifications:** OneSignal
**Localization:** Easy Localization
**Image Caching:** cached_network_image

## Core Screens

1. **Authentication** - Sign up/Sign in with validation
2. **Dashboard** - Game grid with search, filters, and infinite scroll
3. **Game Overview** - Detailed game information with rich content
4. **Settings** - Language, notifications, and account management
