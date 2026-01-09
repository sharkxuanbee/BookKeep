# Ledger

A lightweight Flutter expense tracker focused on fast entry, clear summaries, and local-first data storage.

## Highlights

- Records list with edit/delete, date grouping, sorting, and keyword search.
- Filters by date range, type, and category with visible filter chips.
- Statistics page with monthly totals, category breakdowns, and a monthly budget gauge.
- Category management (add/rename/disable) with system defaults.
- CSV import/export (tab-separated) with legacy header compatibility.
- Theme mode selection (system/light/dark).
- Local persistence with SQLite (sqflite).

## Project Structure

```
lib/
������ core/
��   ������ theme/              # App theme and styling
��   ������ utils/              # Formatters and helpers
��   ������ widgets/            # Shared UI components
������ data/
��   ������ database/           # SQLite helper + migrations
��   ������ models/             # Data models
��   ������ repositories/       # Data access layer
������ state/                  # Riverpod state and providers
������ ui/
    ������ screens/             # Pages and navigation shell
    ������ widgets/             # Feature widgets
```

## Running the App

1. Install Flutter (>= 3.10.7)
2. Fetch dependencies:

```bash
flutter pub get
```

3. Run:

```bash
flutter run
```

## CSV Import/Export

- File extension: `.csv`
- Field separator: `TAB` (`\t`)
- Supported headers:
  - English: `Date	Type	Category	Amount	Note`
- Supported date formats: `yyyy-MM-dd`, `yyyy/MM/dd`, `yyyy-MM-dd HH:mm:ss`

## Extensibility Ideas

1. Recurring transactions (daily/weekly/monthly templates).
2. Category-level budgets and alerts.
3. Data backup/export to cloud storage.
4. Multi-currency support with exchange rates.

## Notes

- Data is stored locally in SQLite. No account system is required.
- CSV export uses the legacy format for compatibility with existing files.
