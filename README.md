# Ledger 📱

A modern, lightweight Flutter expense tracker designed for fast entry, clear financial insights, and secure local-first data storage. Built with a focus on simplicity, performance, and user-centric design.

## ✨ Features

### 📋 Records Management
- **Fast Entry**: Quick expense/income logging with intuitive form
- **Smart Organization**: Date grouping, customizable sorting, and keyword search
- **Edit & Delete**: Easy modification and removal of existing records
- **Visual Timeline**: Clean, chronological view with collapsible date sections

### 🔍 Advanced Filtering
- **Multi-dimensional Filters**: Filter by date range, transaction type, and category
- **Visible Filter Chips**: Clear indication of active filters with one-click removal
- **Saved Views**: Quick access to frequently used filter combinations

### 📊 Comprehensive Statistics
- **Monthly Overview**: Total income/expenses with savings calculation
- **Category Breakdown**: Pie chart visualization of spending by category
- **Budget Tracker**: Monthly budget gauge with progress indicators
- **Trend Analysis**: Historical data comparison across months

### 🏷️ Category Management
- **Flexible Categories**: Add, rename, or disable custom categories
- **System Defaults**: Pre-configured categories for common expenses
- **Visual Organization**: Color-coded categories for easy identification

### 📤 Data Import/Export
- **CSV Support**: Tab-separated values for universal compatibility
- **Legacy Format Support**: Import from older versions seamlessly
- **Data Portability**: Export your data anytime, anywhere

### 🎨 Customization
- **Theme Support**: System, Light, and Dark modes
- **Personalized Experience**: Customizable currency format
- **Responsive Design**: Optimized for phones and tablets

### 💾 Local-First Architecture
- **SQLite Storage**: Secure, reliable local data storage
- **No Cloud Dependency**: Full functionality without internet connection
- **Privacy Focused**: Your financial data stays on your device

## 📁 Project Structure

```
lib/
├── core/                     # Core application infrastructure
│   ├── theme/              # App theme, colors, and styling
│   ├── utils/              # Formatters, helpers, and utilities
│   └── widgets/            # Reusable UI components
├── data/                     # Data layer implementation
│   ├── database/           # SQLite helper and migration scripts
│   ├── models/             # Data models and entities
│   └── repositories/       # Data access abstraction layer
├── state/                    # State management with Riverpod
│   ├── providers/          # State providers and notifiers
│   └── services/           # Business logic services
└── ui/                       # User interface components
    ├── screens/             # Application pages and navigation
    └── widgets/             # Feature-specific UI components
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.10.7)
- Dart SDK (>= 3.0.0)
- Android Studio / Xcode (for native builds)
- Git (for version control)

### Installation

1. **Clone the repository**:

```bash
git clone https://github.com/yourusername/ledger.git
cd ledger
```

2. **Install dependencies**:

```bash
flutter pub get
```

3. **Run the app**:

```bash
# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run on web
flutter run -d web
```

### Building for Production

```bash
# Build APK for Android
flutter build apk --release

# Build IPA for iOS
flutter build ios --release

# Build for web
flutter build web
```

## 📱 Supported Platforms

- ✅ Android (minimum API level 21)
- ✅ iOS (minimum iOS 14.0)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🛠️ Tech Stack

- **Framework**: Flutter 3.10.7+
- **Language**: Dart 3.0.0+
- **State Management**: Riverpod 2.0+
- **Database**: SQLite (sqflite)
- **UI Components**: Custom widgets + Material 3 design
- **Build Tool**: Flutter SDK

## 📝 CSV Import/Export Format

### File Specification
- **Extension**: `.csv`
- **Separator**: Tab (`\t`)
- **Encoding**: UTF-8

### Supported Headers
```
Date\tType\tCategory\tAmount\tNote
```

### Supported Date Formats
- `yyyy-MM-dd` (e.g., 2023-12-31)
- `yyyy/MM/dd` (e.g., 2023/12/31)
- `yyyy-MM-dd HH:mm:ss` (e.g., 2023-12-31 23:59:59)

### Example CSV Content
```csv
Date	Type	Category	Amount	Note
2023-12-31	Income	Salary	5000	Monthly salary
2023-12-30	Expense	Food	150	Grocery shopping
2023-12-29	Expense	Transport	50	Bus fare
```

## 🔮 Future Enhancements

### Short-term Goals
- [ ] Recurring transactions (daily/weekly/monthly templates)
- [ ] Category-level budgets with alerts
- [ ] Enhanced data visualization
- [ ] Multi-device sync via cloud backup

### Long-term Vision
- [ ] Multi-currency support with exchange rates
- [ ] Financial goal tracking
- [ ] Receipt scanning integration
- [ ] Advanced analytics and insights

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines
1. Follow the existing code style
2. Write tests for new features
3. Update documentation accordingly
4. Create a descriptive Pull Request

## 🔧 Troubleshooting

### Common Issues

**Q: App crashes on startup**
A: Try clearing the app data and restarting, or reinstalling the app.

**Q: CSV import fails**
A: Ensure your CSV file uses tab separators and follows the supported format.

**Q: Data not saving**
A: Check if you have sufficient storage space on your device.

## 📞 Support

If you encounter any issues or have questions, please:
- Check the [FAQ](FAQ.md) (coming soon)
- Open an [issue](https://github.com/yourusername/ledger/issues) on GitHub
- Contact the maintainers

---

**Built with ❤️ using Flutter**

*Last updated: January 2026*