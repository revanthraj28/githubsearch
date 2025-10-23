# GitHub Repository Search App

A Flutter application for searching GitHub repositories using the GitHub API.

## 🎯 Features

- ✅ Search GitHub repositories by keyword
- ✅ Display search results in a list
- ✅ View detailed repository information
- ✅ Material Design 3 compliance
- ✅ Dark mode support
- ✅ Multi-language support (English/Japanese)
- ✅ Responsive design for various screen sizes
- ✅ Error handling with retry functionality
- ✅ Loading states with animations
- ✅ Clean Architecture implementation
- ✅ Comprehensive testing

## 📱 Screenshots

[Add screenshots here]

## 🏗 Architecture

This app follows Clean Architecture principles with the following layers:

### Domain Layer
- **Entities**: Core business objects
- **Repositories**: Abstract definitions
- **Use Cases**: Business logic

### Data Layer
- **Models**: Data transfer objects
- **Data Sources**: API communication
- **Repositories Implementation**: Concrete implementations

### Presentation Layer
- **Screens**: UI pages
- **Widgets**: Reusable components
- **Providers**: State management (Riverpod)

## 🛠 Technology Stack

- **Flutter**: 3.16.0 (stable)
- **Dart**: 3.2.0
- **State Management**: Riverpod 2.4.0
- **Network**: Dio 5.3.2
- **Code Generation**: Freezed, JSON Serializable
- **Testing**: Flutter Test, Mockito

## 📋 Requirements

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
- iOS: 9.0+
- Android: 4.1+

## 🚀 Getting Started

### Prerequisites
```bash
# Check Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App
```bash
# Development
flutter run

# Production
flutter run --release
```

### Running Tests
```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/unit/datasource_test.dart
```

## 🎨 Design Decisions

### State Management: Riverpod
- Type-safe
- Compile-time error detection
- Better testability
- No context dependency

### Architecture: Clean Architecture
- Separation of concerns
- Testability
- Scalability
- Maintainability

### API Implementation
- Custom Dio implementation for HTTP requests
- Proper error handling
- Timeout configuration
- Rate limiting awareness

## ✨ Key Features Implementation

### Search Functionality
- Debounced search to reduce API calls
- Empty state handling
- Loading indicators
- Error recovery

### Repository Details
- Hero animations for smooth transitions
- Comprehensive information display
- Responsive layout
- Cached network images

### Theme Support
- Material Design 3
- Dynamic color schemes
- Dark mode support
- Consistent styling

### Internationalization
- Japanese and English support
- RTL ready
- Proper date/number formatting

### Error Handling
- Network error detection
- API rate limit handling
- User-friendly error messages
- Retry mechanisms

## 🧪 Testing Strategy

### Unit Tests
- Data source testing
- Model serialization
- Business logic validation

### Widget Tests
- UI component testing
- User interaction simulation
- State management testing

### Integration Tests
- Full flow testing
- Performance testing

## 📊 CI/CD

### GitHub Actions Workflow
```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk
      - run: flutter build ios --no-codesign
```

## 🔒 Security Considerations

- No API keys stored in code
- Secure network communication
- Input validation
- Rate limit handling

## 🎯 Performance Optimizations

- Lazy loading of images
- List virtualization
- Efficient state management
- Minimal rebuilds

## 📝 Code Quality

- Linting with flutter_lints
- Code formatting
- Comprehensive documentation
- Meaningful commit messages

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open pull request

## 📄 License

This project is created for the Yumemi Inc. recruitment process.

## 👨‍💻 Author

Revanth G

## 🙏 Acknowledgments

- Yumemi Inc. for the opportunity
- Flutter team for the amazing framework
- Open source community