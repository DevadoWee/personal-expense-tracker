# Personal Expense Tracker

A small Flutter expense tracker focused on the real assignment first:

- add an expense
- view an expense list
- persist data locally after app restart
- handle empty state and basic validation

This project uses `GetX` for navigation/state flow and `sqflite` for local persistence.

## What Was Completed

### Core

Completed:

- Add expense with `title`, `amount`, `date`
- View expense list on the home screen
- 2 screens: expense list + create expense
- Local persistence after app restart
- Empty state for no transactions
- Basic validation and basic error/snackbar handling

### Sub-core

Completed:

- Clean folder structure
- Separation between UI / controller / repository / local database
- State management with `GetX`
- Navigation with named routes
- Invalid input handling
- Reusable widgets/components

Completed now:

- README explaining implementation decisions and current scope

### Bonus

Completed:

- Categories
- Some UI polish

Partially completed:

- Daily grouped totals are shown per date section

Not completed:

- Search
- Filtering
- Dedicated total expense summary feature
- Offline-first write-up beyond local SQLite persistence
- Meaningful automated test coverage

## What Was Intentionally Not Finished

These parts are still light or incomplete:

- No dedicated expense detail screen
- No search/filter flow
- No full testing strategy yet
- No advanced migration/versioning strategy for the local database yet

The current `widget_test.dart` is only a placeholder so the test target is not broken. It is not being presented as real coverage.

## Architecture

The project is currently organized like this:

```text
lib/
  controllers/
  helpers/
  models/
  repository/
  screens/
  services/
  shared/
  widgets/
```

Responsibilities:

- `screens/`: UI composition
- `controllers/`: screen logic, validation, state orchestration
- `services/`: app-facing operations and shaping data for UI needs
- `repository/`: SQLite query access
- `services/local_database_service.dart`: database bootstrap/opening
- `models/`: transaction and grouped-by-day models
- `widgets/`: reusable UI pieces
- `shared/`: routes, theme, palette, spacing, typography, extensions
- `helpers/`: bottom sheet and snackbar helpers

## Main Decisions

### Why SQLite instead of Hive

SQLite was chosen because the assignment data is table-shaped and behaves more like backend records than simple local key-value objects.

Why it fits better here:

- easier to model rows/columns cleanly
- better for ordered querying
- closer to how a real backend database would behave
- easier to extend later if relationships or migrations are needed

Hive would have been fine for lightweight local storage, but SQLite was the better fit for this assignment’s structure.

### Why `TransactionModelByDay`

The home screen is rendered by date groups, so the app shapes flat transactions into a day-based UI model:

- `TransactionModel`: one expense row
- `TransactionModelByDay`: one date section containing transactions and daily total

This keeps the home screen simpler because it reads already-shaped data instead of rebuilding sections in the UI layer.

### Why `GetX`

`GetX` was used because it keeps this assessment lightweight:

- simple controller setup
- straightforward route handling
- low boilerplate for reactive updates

## Current Data Flow

Create expense flow:

1. User fills the form on the create screen
2. Controller validates inputs
3. Controller calls the SQLite service
4. Service calls the repository
5. Repository writes to SQLite
6. Home controller refreshes grouped transactions

List flow:

1. Home controller requests grouped transactions
2. SQLite repository returns rows ordered by date descending
3. SQLite service shapes them into `TransactionModelByDay`
4. Home screen renders sections and transaction tiles

## Local Persistence

Persistence is handled with `sqflite`.

Current table:

- `id`
- `title`
- `amount`
- `date`
- `category`

Database initialization happens before `runApp()` so the app starts with the local DB ready.

## Current UI Scope

Implemented:

- branded transaction history home screen
- create expense screen
- empty state
- grouped transaction cards
- category picker bottom sheet
- snackbar helper
- inline submit loading state

Not implemented:

- advanced search/filter controls
- full dashboard/analytics experience
- detail/edit/delete flows

## Validation and Error Handling

Current validation:

- title cannot be empty
- amount cannot be empty
- amount must be numeric
- amount must be greater than zero

Current error handling:

- form validation messages on fields
- snackbar for create/save errors
- snackbar for home refresh errors

## Testing

Current state:

- a placeholder widget test exists and passes

Limitations:

- no real widget coverage yet
- no repository/service tests
- no controller behavior tests

## How To Run

```bash
flutter pub get
flutter run
```

To run the placeholder test:

```bash
flutter test test/widget_test.dart
```

## Honest Status Summary

If judged against the assignment:

- Core: completed
- Sub-core structure: completed
- Bonus: partial

The biggest remaining gaps are:

- real README-quality assessment notes are now present, but can still be expanded further if needed
- real test coverage
- optional search/filter/summary enhancements
