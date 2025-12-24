# Pomodoro Circle (Flutter)

A learning-first Flutter project: a single-screen Pomodoro timer with a circular progress ring and a Start/Stop control.

The goal is not only to “make it work”, but to build Flutter fundamentals gradually and consciously:

- Widget composition
- Stateful UI with `setState`
- Timer lifecycle (`Timer.periodic`, cancel on `dispose`)
- Custom drawing with `CustomPainter`

## Current Scope (MVP)

**One main screen**

- Circular ring in the center
- Label inside circle: `IDLE` / `RUN`
- Time inside circle: `25:00` down to `00:00`
- Single button:
  - `Start` → starts countdown
  - `Stop` → stops + resets to `25:00`

## Milestones

1. **Empty initial app**

- App launches; minimal scaffold.

2. **Render-only UI**

- Circle + button render (no interactions).

3. **Basic interaction**

- Button toggles label (`Start` ↔ `Stop`) and circle text (`IDLE` ↔ `RUN`).

4. **Working timer**

- Circle shows `mm:ss`
- Timer counts down from 25:00
- Start/Stop manages timer correctly
- Timer is canceled in `dispose()`

## Tech Decisions (for learning)

- **State management:** `StatefulWidget` + `setState` (no Provider/Riverpod yet)
- **Drawing:** `CustomPainter` for the circular ring
- **Dependencies:** keep minimal; prefer Flutter SDK only until we hit a real need

## Getting Started

### Prerequisites

- Flutter SDK installed
- Android Studio / VS Code with Flutter plugin
- An emulator or a physical Android device

### Create and run

```bash
flutter create pomodoro_circle
cd pomodoro_circle
flutter run
```
