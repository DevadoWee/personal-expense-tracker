# Personal Expense Tracker

A small Flutter expense tracker focused on the real assignment first:

- add an expense
- view an expense list
- persist data locally after app restart
- handle empty state and basic validation

This project uses `GetX` for navigation/state management and `sqflite` for local persistence.

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
- Offline-first

Partially completed:

- Daily grouped totals are shown per date section

Not completed:

- Search
- Filtering
- Dedicated total expense summary feature
- Meaningful automated test coverage

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

## Explanations

- Priority is given to the structure of the project.
    - Core functions are completed, with the little things like 'double tap prevention', 'automatic dispose of controller via binding', 'proper fetching query'.
    - As well as the seperation of folders.

- Local data persistence
    - This project unfortunately does not include fetching or posting via API. As all the data is stored and fetched directly from sqlite.
    - If API were to be included, depending on severity several actions may be necessary
        - Local queue system. (stores when offline, push when online)
        - Delta sync for normal and full sync if that fails.
        - Proper versioning.

- Possible enhancement for the cores
    - App refresh (scroll down to refresh)
    - Sync function
    - 
