# Implementation Plan for 默書錄音 App

This document outlines the phased implementation plan for building the "默書錄音" (Dictation Recorder) Flutter application.

## Journal

*This section will be updated chronologically after each phase to log actions, learnings, surprises, and deviations from the plan.*

---

## The Plan

### Phase 1: Project Initialization & Core Setup

In this phase, we will create the Flutter project, set up the basic file structure, add necessary dependencies, and commit the initial empty version of the package.

- [ ] Create an empty Flutter project in the current directory. The package name will be `flutter_dictation_recorder`.
- [ ] Add project dependencies (`go_router`, `record`, `just_audio`, `path_provider`, `flutter_riverpod`, `riverpod_generator`) and dev dependencies (`build_runner`, `custom_lint`, `riverpod_lint`) to `pubspec.yaml`.
- [ ] Update the `pubspec.yaml` description and set the version to `0.1.0`.
- [ ] Create a basic `analysis_options.yaml` file to enforce good coding practices.
- [ ] Remove the default boilerplate code (e.g., `lib/main.dart`, `test/` directory).
- [ ] Create a placeholder `README.md` file.
- [ ] Create the `CHANGELOG.md` file with an initial entry for version `0.1.0`.
- [ ] Commit this initial empty version of the package to the current branch.
- [ ] After committing, launch the app on a user-selected device to ensure the setup is correct.

**Post-Phase Checklist:**
- [ ] Run `dart pub get` to fetch dependencies.
- [ ] Review the created project structure.
- [ ] Update the Journal in `IMPLEMENTATION.md`.
- [ ] Present changes to the user for commit approval.

### Phase 2: Data Models, Services & Persistence Layer

This phase focuses on building the data foundation of the app, including the data models, service interfaces, and data persistence logic.

- [ ] Create the data model classes (`Recording`, `Dictation`) based on the `DESIGN.md` in `lib/src/domain/`.
- [ ] Create the `DataRepository` abstract class (interface) in the domain layer to define methods for saving and loading dictation data.
- [ ] Implement a `JsonDataRepository` in the `lib/src/data/` directory that handles the serialization/deserialization of data to a local JSON file.
- [ ] Create an `AudioService` that uses the `record` and `just_audio` packages to handle all audio recording and playback logic.
- [ ] Set up `path_provider` to determine the local storage path for audio files and the JSON data file.

**Post-Phase Checklist:**
- [ ] Create unit tests for the data models and repository logic.
- [ ] Run `dart_fix` and `analyze_files` to clean up the code.
- [ ] Run unit tests to ensure they all pass.
- [ ] Run `dart_format` to correct formatting.
- [ ] Re-read `IMPLEMENTATION.md` for any changes.
- [ ] Update the Journal and check off completed tasks in `IMPLEMENTATION.md`.
- [ ] Use `git diff` to verify changes and present a commit message to the user for approval.
- [ ] If the app is running, use `hot_reload`.

### Phase 3: State Management with Riverpod

This phase involves setting up Riverpod providers to manage the application's state, making it accessible and manageable throughout the widget tree.

- [ ] Set up the `Riverpod` code generator by annotating providers with `@riverpod`.
- [ ] Create a `DictationsNotifier` provider to manage the state of dictations (list, adding, removing). This provider will use the `DataRepository`.
- [ ] Create an `AudioPlayerNotifier` to manage the state of the audio player (playing, paused, progress, current file). This will use the `AudioService`.
- [ ] Create a `SettingsProvider` to manage application settings, such as the pause duration between segments.
- [ ] Run `build_runner` to generate the provider code.

**Post-Phase Checklist:**
- [ ] Create unit tests for the Riverpod notifiers.
- [ ] Run `dart_fix` and `analyze_files`.
- [ ] Run tests.
- [ ] Run `dart_format`.
- [ ] Update the Journal and checklist in `IMPLEMENTATION.md`.
- [ ] Present changes to the user for commit approval.
- [ ] If the app is running, use `hot_reload`.

### Phase 4: UI - Theme and Navigation

This phase sets up the visual foundation, including the app's theme and navigation structure using `go_router`.

- [ ] Configure `main.dart` with the `ProviderScope` and `MaterialApp.router`.
- [ ] Create a `lib/src/core/theme.dart` file to define the Material 3 `ThemeData` with the specified black background and pink/purple primary color.
- [ ] Set up `go_router` in a `lib/src/core/router.dart` file. Define routes for the main pages: `/` (Category/Home), `/record`, `/playback`, `/settings`.
- [ ] Create basic placeholder screens for each route to verify navigation.

**Post-Phase Checklist:**
- [ ] Run `dart_fix` and `analyze_files`.
- [ ] Run `dart_format`.
- [ ] Update the Journal and checklist in `IMPLEMENTATION.md`.
- [ ] Present changes to the user for commit approval.
- [ ] If the app is running, use `hot_reload`.

### Phase 5: UI - Home & Recording Pages

With the backend logic in place, this phase focuses on building the main user-facing features.

- [ ] Implement the Home Page (`/`) UI for creating/selecting a dictation category and textbook. Connect the UI to the `DictationsNotifier`.
- [ ] Implement the Recording Page (`/record`) UI.
- [ ] Display the current category and textbook name.
- [ ] Implement the large, press-and-hold record button, connecting it to the `AudioService`.
- [ ] Implement the list view to display recorded audio segments.
- [ ] Implement the long-press gesture to bring up a delete confirmation dialog for a segment.
- [ ] Implement the play button for individual segments.

**Post-Phase Checklist:**
- [ ] Create widget tests for the Home and Recording pages.
- [ ] Run `dart_fix` and `analyze_files`.
- [ ] Run all tests.
- [ ] Run `dart_format`.
- [ ] Update the Journal and checklist in `IMPLEMENTATION.md`.
- [ ] Present changes to the user for commit approval.
- [ ] If the app is running, use `hot_reload`.

### Phase 6: UI - Playback & Settings Pages

This phase completes the remaining UI screens.

- [ ] Implement the Playback Page (`/playback`) UI.
- [ ] Add UI controls for play/pause, next, and previous segments.
- [ ] Implement the drag-and-drop reordering of recording segments.
- [ ] Implement the Settings Page (`/settings`) UI.
- [ ] Add a control (e.g., a slider or text field) to set the pause duration between segments.

**Post-Phase Checklist:**
- [ ] Create widget tests for the Playback and Settings pages.
- [ ] Run `dart_fix` and `analyze_files`.
- [ ] Run all tests.
- [ ] Run `dart_format`.
- [ ] Update the Journal and checklist in `IMPLEMENTATION.md`.
- [ ] Present changes to the user for commit approval.
- [ ] If the app is running, use `hot_reload`.

### Phase 7: Finalization

This final phase involves polishing the app, adding documentation, and preparing for hand-off.

- [ ] Create a comprehensive `README.md` file for the package, explaining what the app does and how to run it.
- [ ] Create a `GEMINI.md` file that describes the app's purpose, implementation details, and file structure.
- [ ] Ask the user to inspect the final app and code to confirm satisfaction and check if any modifications are needed.

---
*After completing a task, if you added any TODOs to the code or didn't fully implement anything, make sure to add new tasks so that you can come back and complete them later.*
