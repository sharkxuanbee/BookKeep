<div align="center">
  <img src="assets/images/app_icon.png" alt="BookKeep Logo" width="200" height="200">
  <h1>BookKeep 📒</h1>
  <p><a href="#chinese">简体中文</a> | <a href="#english">English</a></p>
  <p>一款高效、易用的开源记账软件，帮助用户轻松管理个人财务，实现财富增长</p>
</div>

<a name="chinese"></a>
<details open>
<summary><strong>简体中文</strong></summary>

# BookKeep 📒

BookKeep 是一款现代、轻量的 Flutter 记账软件，提供快速录入、清晰洞察、严格日历校验和安全的本地优先存储。

## 🌟 核心功能
- **记账管理**: 3 秒内完成一笔收支，时间线视图与快捷编辑
- **智能筛选**: 日期/类型/金额多维筛选，筛选条件芯片可一键清除
- **统计与分析**: 月/年视图，日/月份序列趋势，饼图/柱状图/折线图切换，支出/收入/全部任意切换
- **支出排行榜**: Top 10/全部，点击可查看类别明细与备注排行，并筛选对应账目
- **预算追踪**: 月度预算进度与超额提示
- **导入/导出**: 默认英文 UTF-8 Bookkeeping.csv（ISO 日期，Expense/Income，标准 CSV 转义）
- **多语言**: 内置 10 种语言，设置页可切换并持久化

## 📸 截图（占位）
![Analytics](assets/images/analytics_placeholder.svg)
![Ranking](assets/images/ranking_placeholder.svg)
![Localization](assets/images/localization_placeholder.svg)

## 🚀 快速开始
```bash
# 克隆仓库
git clone https://github.com/sharkxuanbee/BookKeep.git
cd BookKeep

# 安装依赖
flutter pub get

# 运行应用（示例）
flutter run -d android
```

## 🧾 导入/导出格式
- 默认文件名: Bookkeeping.csv，编码 UTF-8（无 BOM），逗号分隔，表头 `Date,Type,Category,Amount,Note`
- 日期: yyyy-MM-dd，严格校验闰年与每月天数
- 类型: Expense / Income（首字母大写）
- 金额: 最多两位小数，无千分位

## 🧭 支持与技术
- 平台: Android 21+ / iOS 14+ / Web / Windows / macOS / Linux
- 技术栈: Flutter 3.10.7+ · Dart 3.0+ · Riverpod 2.x · sqflite · fl_chart

</details>

<a name="english"></a>
<details>
<summary><strong>English</strong></summary>

# BookKeep 📒

BookKeep is a modern, lightweight Flutter bookkeeping app with fast entry, clear insights, strict calendar handling, and secure local-first storage.

## 🌟 Key Features
- **Records**: Finish an expense/income in seconds with a timeline view and quick edits
- **Smart Filters**: Filter by date/type/amount with chips that clear in one tap
- **Analytics**: Month/year views with real calendar days, pie/bar/line charts, and Expense/Income/All toggles
- **Expense Ranking**: Top 10 or full list with drill-down, note ranking, and transaction filtering
- **Budget Tracking**: Monthly budget progress with overrun warning
- **Import/Export**: Default English UTF-8 Bookkeeping.csv (ISO date, Expense/Income, proper CSV quoting)
- **Localization**: 10 languages with a settings toggle and persistence

## 📸 Screenshots (placeholders)
![Analytics](assets/images/analytics_placeholder.svg)
![Ranking](assets/images/ranking_placeholder.svg)
![Localization](assets/images/localization_placeholder.svg)

## 🚀 Getting Started
```bash
# Clone
git clone https://github.com/sharkxuanbee/BookKeep.git
cd BookKeep

# Install deps
flutter pub get

# Run (example)
flutter run -d android
```

## 🧾 Import/Export Format
- Default file: Bookkeeping.csv, UTF-8 (no BOM), comma separated, header `Date,Type,Category,Amount,Note`
- Date: yyyy-MM-dd with strict calendar validation (leap years, real month days)
- Type: Expense / Income (capitalized)
- Amount: Up to two decimals, no thousand separators

## 🧭 Support & Tech
- Platforms: Android 21+ / iOS 14+ / Web / Windows / macOS / Linux
- Stack: Flutter 3.10.7+ · Dart 3.0+ · Riverpod 2.x · sqflite · fl_chart

</details>
