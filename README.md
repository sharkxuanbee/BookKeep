<div align="center">
  <h1>Ledger 📱</h1>
  <p><a href="#chinese">简体中文</a> | <a href="#english">English</a></p>
</div>

<a name="chinese"></a>
<details open>
<summary><strong>简体中文</strong></summary>

# Ledger 📱

一个现代、轻量的 Flutter  expense 跟踪器，专为快速录入、清晰的财务洞察和安全的本地优先数据存储而设计。构建时专注于简单性、性能和以用户为中心的设计。

## ✨ 功能特性

### 📋 记录管理
- **快速录入**: 直观表单实现快速支出/收入记录
- **智能组织**: 按日期分组、可自定义排序和关键字搜索
- **编辑与删除**: 轻松修改和删除现有记录
- **可视化时间线**: 清晰的时间顺序视图，带有可折叠的日期部分

### 🔍 高级筛选
- **多维筛选**: 按日期范围、交易类型和类别进行筛选
- **可见筛选芯片**: 清晰显示活动筛选器，一键移除
- **保存视图**: 快速访问常用筛选组合

### 📊 全面统计
- **月度概览**: 总收入/支出及储蓄计算
- **类别细分**: 按类别划分支出的饼图可视化
- **预算跟踪器**: 带有进度指示器的月度预算仪表
- **趋势分析**: 跨月份历史数据比较

### 🏷️ 类别管理
- **灵活类别**: 添加、重命名或禁用自定义类别
- **系统默认值**: 针对常见支出的预配置类别
- **可视化组织**: 颜色编码类别，便于识别

### 📤 数据导入/导出
- **CSV 支持**: 制表符分隔值，实现通用兼容性
- **旧版格式支持**: 从旧版本无缝导入
- **数据可移植性**: 随时随地导出数据

### 🎨 自定义
- **主题支持**: 系统、浅色和深色模式
- **个性化体验**: 可自定义货币格式
- **响应式设计**: 针对手机和平板电脑优化

### 💾 本地优先架构
- **SQLite 存储**: 安全可靠的本地数据存储
- **无云依赖**: 无需互联网连接即可完整功能
- **隐私优先**: 您的财务数据留在您的设备上

## 📁 项目结构

```
lib/
├── core/                     # 核心应用基础设施
│   ├── theme/              # 应用主题、颜色和样式
│   ├── utils/              # 格式化器、帮助程序和实用工具
│   └── widgets/            # 可重用 UI 组件
├── data/                     # 数据层实现
│   ├── database/           # SQLite 助手和迁移脚本
│   ├── models/             # 数据模型和实体
│   └── repositories/       # 数据访问抽象层
├── state/                    # 使用 Riverpod 的状态管理
│   ├── providers/          # 状态提供器和通知器
│   └── services/           # 业务逻辑服务
└── ui/                       # 用户界面组件
    ├── screens/             # 应用页面和导航
    └── widgets/             # 特定功能 UI 组件
```

## 🚀 快速开始

### 先决条件

- Flutter SDK (>= 3.10.7)
- Dart SDK (>= 3.0.0)
- Android Studio / Xcode (用于原生构建)
- Git (用于版本控制)

### 安装

1. **克隆仓库**:

```bash
git clone https://github.com/yourusername/ledger.git
cd ledger
```

2. **安装依赖**:

```bash
flutter pub get
```

3. **运行应用**:

```bash
# 在 Android 上运行
flutter run -d android

# 在 iOS 上运行
flutter run -d ios

# 在 web 上运行
flutter run -d web
```

### 构建生产版本

```bash
# 构建 Android APK
flutter build apk --release

# 构建 iOS IPA
flutter build ios --release

# 构建 web 版本
flutter build web
```

## 📱 支持平台

- ✅ Android (最低 API 级别 21)
- ✅ iOS (最低 iOS 14.0)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🛠️ 技术栈

- **框架**: Flutter 3.10.7+
- **语言**: Dart 3.0.0+
- **状态管理**: Riverpod 2.0+
- **数据库**: SQLite (sqflite)
- **UI 组件**: 自定义组件 + Material 3 设计
- **构建工具**: Flutter SDK

## 📝 CSV 导入/导出格式

### 文件规范
- **扩展名**: `.csv`
- **分隔符**: 制表符 (`\t`)
- **编码**: UTF-8

### 支持的标题
```
Date\tType\tCategory\tAmount\tNote
```

### 支持的日期格式
- `yyyy-MM-dd` (例如：2023-12-31)
- `yyyy/MM/dd` (例如：2023/12/31)
- `yyyy-MM-dd HH:mm:ss` (例如：2023-12-31 23:59:59)

### 示例 CSV 内容
```csv
Date\tType\tCategory\tAmount\tNote
2023-12-31\tIncome\tSalary\t5000\tMonthly salary
2023-12-30\tExpense\tFood\t150\tGrocery shopping
2023-12-29\tExpense\tTransport\t50\tBus fare
```

## 🔮 未来增强

### 短期目标
- [ ] 定期交易（每日/每周/每月模板）
- [ ] 带警报的类别级预算
- [ ] 增强的数据可视化
- [ ] 通过云备份实现多设备同步

### 长期愿景
- [ ] 支持多种货币及汇率
- [ ] 财务目标跟踪
- [ ] 收据扫描集成
- [ ] 高级分析和洞察

## 📄 许可证

本项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

## 🤝 贡献

欢迎贡献！请随时提交 Pull Request。

### 开发指南
1. 遵循现有代码风格
2. 为新功能编写测试
3. 相应更新文档
4. 创建描述性的 Pull Request

## 🔧 故障排除

### 常见问题

**问：应用启动时崩溃**
答：尝试清除应用数据并重启，或重新安装应用。

**问：CSV 导入失败**
答：确保您的 CSV 文件使用制表符分隔，并遵循支持的格式。

**问：数据未保存**
答：检查您的设备是否有足够的存储空间。

## 📞 支持

如果您遇到任何问题或有疑问，请：
- 查看 [FAQ](FAQ.md)（即将推出）
- 在 GitHub 上打开 [issue](https://github.com/yourusername/ledger/issues)
- 联系维护者

---

**使用 Flutter 构建 ❤️**

*最后更新：2026年1月*

</details>

<a name="english"></a>
<details>
<summary><strong>English</strong></summary>

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
Date\tType\tCategory\tAmount\tNote
2023-12-31\tIncome\tSalary\t5000\tMonthly salary
2023-12-30\tExpense\tFood\t150\tGrocery shopping
2023-12-29\tExpense\tTransport\t50\tBus fare
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

</details>