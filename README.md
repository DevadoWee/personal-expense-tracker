# 📱 Mobile Developer Take-Home Assignment

## 🧩 Overview

You are asked to build a small mobile application based on the following theme:

> **Personal Expense Tracker**

The goal of this assignment is not to build a production-ready app, but to demonstrate how you:

- Structure your code
- Make technical decisions
- Handle real-world constraints
- Communicate your thinking

---

## ⏱️ Time Expectation

Please spend **no more than 4–6 hours** on this assignment.

We value **clarity, simplicity, and decision-making** over completeness or polish.

---

## 🎯 Core Requirements

Your application should:

### Features

- Allow users to:
  - Add a new expense (title, amount, date)
  - View a list of expenses
- Display at least **2 screens** (e.g., list + add/detail)
- Persist data locally so it survives app restarts

---

### Basic UX States

Your app should handle:

- Empty state (no data)
- Basic loading state (if applicable)
- Basic error handling (if applicable)

---

## ⚙️ Technical Expectations

You may use any architecture or libraries you are comfortable with.

### Platform Options

#### 📱 Android (Kotlin)

- Preferred: Jetpack Compose
- Recommended pattern: MVVM or similar
- State: Flow / LiveData / Compose state
- Persistence: Room / DataStore / local DB

#### 🍎 iOS (Swift)

- Preferred: SwiftUI
- Recommended pattern: MVVM or similar
- State: ObservableObject / SwiftUI state
- Persistence: Core Data / UserDefaults / local storage

#### 🔄 Cross-platform (Flutter / React Native)

- Use idiomatic patterns for your framework
- Clear separation between UI and logic
- Local persistence is required

---

## 🟢 Junior-Level Expectations

We are primarily looking for:

- Clean and readable code
- Working core features
- Basic understanding of:
  - State management
  - Navigation
  - Data persistence

It is okay if:

- Architecture is simple
- UI is minimal
- Some edge cases are not handled

---

## 🔵 Mid-Level Expectations

In addition to the above, we expect:

- Thoughtful code organization
- Clear separation of concerns
- Handling of common edge cases (e.g., invalid input)
- Basic error handling and user feedback
- Consideration for scalability and maintainability

Bonus signals:

- Light use of abstraction (e.g., repository pattern)
- Reusable components
- Basic testing

---

## 🌶️ Optional Enhancements (Not Required)

If you have time, you may optionally include:

- Expense categories
- Filtering or search
- Summary (e.g., total expenses)
- Offline-first considerations
- Simple animations or UI improvements

---

## 📦 Submission

Please provide:

- A Git repository (GitHub, GitLab, etc.)
- Your `README.md`

---

## ⚠️ Notes

- You may use any tools or resources (including AI), but you should be able to **explain and justify your code**.
- We may ask you to **extend or modify your solution** in the next stage.

---

## 💡 Final Note

This assignment is intentionally open-ended.

We are more interested in **how you think and communicate** than how many features you implement.

---
