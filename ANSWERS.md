# IT 120 - Integrative Programming and Technologies 2
## Laboratory Manual: Flutter Architecture, Widgets and Basic UI (Weeks 10–11)
**Student Name:** ILDV3_MULATO_JAMESTER  
**Student ID:** 241-00315  
**Assigned Theme Color:** Deep Orange  

---

## 1. GitHub Repository Link
- **Repository URL:** `https://github.com/YOUR_USERNAME/flutter_basics_lab.git`  
  *(Replace `YOUR_USERNAME` with your GitHub username once pushed)*

---

## 2. Activity 2 Debug Console Output
Below are the last three `build() called` lines captured from the VS Code Debug Console when incrementing the water tracker up to the goal of 6 glasses:

```text
build() called: 4 glasses
build() called: 5 glasses
build() called: 6 glasses
```

---

## 3. Experiment Observations

### Activity 2 Experiment: Moving `_glasses++` Outside `setState()`
- **Action Taken:** Inside the `_addGlass()` method, `_glasses++` was moved outside of `setState(() { ... })`:
  ```dart
  void _addGlass() {
    if (_glasses < _goal) _glasses++;
    setState(() {}); // Or without setState
  }
  ```
  Specifically, when `_glasses++` was executed completely without notifying Flutter via `setState()`:
  ```dart
  void _addGlass() {
    if (_glasses < _goal) _glasses++;
  }
  ```
- **Observation:** When tapping the `+` button, the variable `_glasses` incremented internally in memory, but **the user interface on screen did not update at all**. The text remained at `0 / 6 glasses`, the icon color stayed default, and the progress indicator stayed empty.
- **Why this happens:** In Flutter, changing a member variable of a State object does not automatically trigger a re-render. `setState()` tells the Flutter framework that the internal state of the widget has changed and schedules a call to the `build()` method. Without `setState()`, Flutter does not know it needs to repaint the widget. When `_glasses++` was placed back inside `setState(() { ... })`, tapping `+` immediately re-triggered `build()` and updated the UI in real time.

---

### Activity 3 Experiment: Removing `Expanded` from a `StatBox`
- **Action Taken:** Removed the `Expanded` widget wrapping one of the `StatBox` widgets in the stat row:
  ```dart
  // Before:
  Expanded(child: StatBox(icon: Icons.air, label: 'Wind', value: '12 km/h')),

  // During Experiment:
  StatBox(icon: Icons.air, label: 'Wind', value: '12 km/h'),
  ```
- **Observation:** The un-wrapped `StatBox` collapsed to its own intrinsic width (only as wide as its inner contents and padding require), while the remaining `Expanded` boxes expanded to consume the remaining horizontal space. The boxes were no longer equally distributed across the screen. On narrow screens or if multiple boxes lose their `Expanded` wrapper, the row no longer divides space proportionally and can lead to uneven alignment or horizontal overflow errors (`RenderFlex overflowed`).
- **Why this happens:** `Expanded` enforces that its child widget fills the available flex space along the main axis of a `Row` or `Column`. Putting it back ensures all four stat boxes share the screen width equally regardless of device size.

---

### Activity 4 Experiment: Changing `crossAxisCount` to 3
- **Action Taken:** In `GridView.builder`, changed `crossAxisCount: 2` to `crossAxisCount: 3`, observed the display, then reverted it to `2`.
- **Observation:** When set to 3 columns, the grid split the screen width into three narrower columns. While more items became visible simultaneously, each menu card became much narrower and vertically compressed. The text, price labels, and icon containers felt crowded, and on smaller phone screens this can cause text truncation or vertical overflow. Keeping `crossAxisCount: 2` provided the optimal balance of readability, touch targets, and visual aesthetic.

---

### Activity 5 Experiment: Changing a Theme Setting in `buildTheme()`
- **Action Taken:** In `buildTheme()`, modified the button corner radius from `8` to `20` inside `elevatedButtonTheme`, `filledButtonTheme`, and `outlinedButtonTheme`:
  ```dart
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ```
- **Observation:** Immediately after saving (hot reload), all three buttons (`ElevatedButton`, `OutlinedButton`, and `FilledButton`) across the settings screen changed from slightly rounded rectangles to modern, pill-shaped rounded buttons.
- **Why this happens:** `ThemeData` provides a centralized configuration for the application. Any widget that inherits its styling from the ambient `Theme.of(context)` automatically adopts the updated theme properties throughout the entire app without requiring manual changes on individual widgets.

---

## 4. Review Questions & Answers

### 1. What is the difference between a `StatelessWidget` and a `StatefulWidget`? Give one example of each from this lab.
- **Answer:**
  - A **`StatelessWidget`** is immutable. Its configuration and visual representation are fixed once built; it cannot change its own state over time based on user interaction or internal events.
    - *Example from lab:* `ProfileCard` (Activity 1) or `StatBox` (Activity 3), which simply receive data through their constructors and render it statically.
  - A **`StatefulWidget`** is dynamic. It maintains a separate mutable `State` object that persists across frames and can change during the lifetime of the widget. When its internal state changes (via `setState()`), it triggers a rebuild of its UI.
    - *Example from lab:* `WaterTrackerPage` (Activity 2), where tapping `+` or `-` alters the `_glasses` count and redraws the progress and icons.

---

### 2. Why is a `StatefulWidget` written as two classes? What does each class do?
- **Answer:**
  Flutter separates a `StatefulWidget` into two distinct classes for architectural efficiency and performance:
  1. **The Widget class (e.g., `WaterTrackerPage extends StatefulWidget`):**
     - This class is immutable and lightweight. It represents the widget's configuration in the widget tree.
     - Because widgets in Flutter are frequently created and destroyed during re-renders, making this class immutable ensures low memory allocation overhead.
     - Its sole responsibility is to create and attach its companion State object using `createState()`.
  2. **The State class (e.g., `_WaterTrackerPageState extends State<WaterTrackerPage>`):**
     - This class is long-lived and persists in memory even when the parent widget configuration rebuilds.
     - It stores the mutable data (e.g., `_glasses`, `_goal`) and contains the `build()` method that constructs the widget subtree based on the current state.

---

### 3. In Activity 2, what happened when you changed `_glasses` outside `setState()`? Why?
- **Answer:**
  When `_glasses++` was placed outside `setState()`, the variable's value increased in memory, but **the visual screen did not update**.
  - **Reason:** Flutter uses a reactive rendering model. The framework does not watch plain Dart variable mutations. The `setState()` function acts as an explicit signal notifying the Flutter pipeline that internal state has changed, marking the widget dirty and scheduling a call to `build()` on the next frame. Without `setState()`, the framework is unaware of the mutation and does not repaint the screen.

---

### 4. Looking at the Debug Console in Activity 2, when is `build()` called?
- **Answer:**
  `build()` is called:
  1. When the widget is first inserted into the widget tree upon application startup.
  2. Every time `setState()` is executed (e.g., each time the user taps `+`, `-`, or `Reset`).
  3. Whenever a parent widget rebuilds or triggers a hot reload (`Ctrl+S`) or hot restart.

---

### 5. Explain the main axis and the cross axis of a `Row` and of a `Column`.
- **Answer:**
  - **In a `Row`:**
    - **Main Axis:** Horizontal (left to right / reading direction). `mainAxisAlignment` controls horizontal spacing (e.g., `MainAxisAlignment.spaceBetween`).
    - **Cross Axis:** Vertical (top to bottom). `crossAxisAlignment` controls vertical alignment (e.g., `CrossAxisAlignment.center`).
  - **In a `Column`:**
    - **Main Axis:** Vertical (top to bottom). `mainAxisAlignment` controls vertical spacing.
    - **Cross Axis:** Horizontal (left to right). `crossAxisAlignment` controls horizontal alignment (e.g., `CrossAxisAlignment.stretch` to make children match the full screen width).

---

### 6. In Activity 3, what happened when you removed `Expanded` from a `StatBox`? What does `Expanded` do?
- **Answer:**
  - **What happened:** The `StatBox` without `Expanded` shrank to its intrinsic content width, while the other boxes with `Expanded` stretched to share the remaining space, resulting in unequal box sizes and an unbalanced layout.
  - **What `Expanded` does:** `Expanded` is a widget that forces a child of a `Row`, `Column`, or `Flex` to expand along the main axis to fill the available flex space. When multiple children are wrapped in `Expanded`, they divide the remaining free space equally (or proportional to their `flex` factors), ensuring responsive, overflow-free layouts across all screen resolutions.

---

### 7. Why do we use `GridView.builder` for the menu instead of a `Column` with many children?
- **Answer:**
  1. **Lazy / On-Demand Rendering:** `GridView.builder` only instantiates and renders the cards currently visible within the viewport (plus a small cache extent). As the user scrolls, off-screen items are recycled. In contrast, a standard `Column` builds every single child at once, which consumes excessive memory and causes frame drops on long lists.
  2. **Multi-Column Grid Mathematics:** `GridView` automatically calculates 2D rows, columns, aspect ratios, and scroll physics. Implementing a two-column responsive grid inside a `Column` would require manual nested `Row` layouts and index calculations.

---

### 8. How do `Stack` and `Positioned` create the Best seller badge in Activity 4?
- **Answer:**
  - A **`Stack`** allows widgets to be layered on top of each other along the Z-axis (overlapping from back to front), rather than linearly in a row or column.
  - The **`Positioned`** widget is placed inside the `Stack` and pins a child widget to exact coordinates relative to the stack's edges using properties like `top: 8`, `left: 8`.
  - In `MenuCard`, the main content (icon, title, price) is centered in the base layer, while `Positioned(top: 8, left: 8)` places the "Best seller" badge cleanly in the top-left corner without affecting the centering or layout of the other widgets.

---

### 9. What is the difference between customizing with `ThemeData` and with a style on one widget? Give one example of each from Activity 5.
- **Answer:**
  - **Customizing with `ThemeData`:** Establishes a global design system for the entire application. Any widget that uses theme attributes automatically inherits this styling, promoting consistency and maintainability.
    - *Example from Activity 5:* Setting `elevatedButtonTheme: ElevatedButtonThemeData(...)` inside `buildTheme()` ensures that all elevated buttons across the entire app share the same corner radius, elevation, and padding.
  - **Customizing with a Style on One Widget:** Applies a local, explicit style to that single widget instance only, overriding any global theme values.
    - *Example from Activity 5:* Applying `color: Colors.white` directly in the `TextStyle` of a single label or manually setting `margin: EdgeInsets.all(...)` on a specific `Card`.

---

### 10. When you flip the dark-mode switch in Activity 5, which widget holds the state, and how does the change reach `MaterialApp`?
- **Answer:**
  - **Which widget holds the state:** The root widget `ThemeDemoApp` (specifically its state class `_ThemeDemoAppState`) holds the boolean state variable `_isDark`.
  - **How the change reaches `MaterialApp` (Lifting State Up pattern):**
    1. `ThemeDemoApp` passes the current `_isDark` value and a callback function `_setDark` down to the child `SettingsPage` via its constructor (`onDarkChanged: _setDark`).
    2. When the user flips the `SwitchListTile` in `SettingsPage`, its `onChanged` triggers `onDarkChanged(value)`.
    3. This invokes `_setDark(value)` in `_ThemeDemoAppState`, which executes `setState(() { _isDark = value; })`.
    4. `ThemeDemoApp` rebuilds, updating `themeMode: _isDark ? ThemeMode.dark : ThemeMode.light` on `MaterialApp`, which instantly updates the entire app's brightness and color scheme.

