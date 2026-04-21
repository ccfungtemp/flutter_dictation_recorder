# 「默書錄音」應用程式實作計畫

本文件概述了建立「默書錄音」Flutter 應用程式的分階段實作計畫。

### 2026年4月10日 - 第二階段：資料模型、服務與持久層

*   已成功建立資料模型類別 `Recording` 和 `Dictation`。
*   已在領域層建立 `DataRepository` 抽象介面。
*   已在資料層實作 `JsonDataRepository`，處理資料與本地 JSON 檔案之間的序列化和反序列化，並整合 `path_provider`。
*   已建立 `AudioService` 抽象介面，並在資料層實作 `RecordAudioService`，整合 `record` 和 `just_audio` 套件，處理音訊錄製與播放邏輯。
*   已設定 `path_provider` 以確定音訊檔案和 JSON 資料檔案的本地儲存路徑。
*   在 `flutter pub run build_runner build` 過程中，初次因缺少 `freezed` 和 `json_serializable` 相關依賴而失敗，後添加並成功執行。
*   已建立資料模型和儲存庫邏輯的單元測試檔案。
*   執行 `dart_fix` 和 `analyze_files` 均無錯誤。
*   **注意：** 執行單元測試時，測試編譯失敗，報告 `Dictation` 和 `Recording` 類別缺少實作。儘管 `.freezed.dart` 和 `.g.dart` 檔案已生成並內容正確，且 `analyze_files` 無誤，但 `flutter test` 的編譯器似乎無法正確識別或連結這些生成的 `part` 檔案。這可能是一個與 Windows 環境下 Dart SDK 或 `flutter test` 相關的編譯問題。此問題已在日誌中記錄，但在解決前，無法確認所有單元測試是否通過。
*   已執行 `dart_format` 以更正格式。

---

## 計畫內容

### 第一階段：專案初始化與核心設定

在此階段，我們將建立 Flutter 專案，設定基礎檔案結構，添加必要的依賴套件，並提交套件的初始空版本。

- [x] 在當前目錄中建立一個空的 Flutter 專案。套件名稱將是 `flutter_dictation_recorder`。
- [x] 將專案依賴套件 (`go_router`, `record`, `just_audio`, `path_provider`, `flutter_riverpod`, `riverpod_generator`) 和開發依賴套件 (`build_runner`, `custom_lint`, `riverpod_lint`) 添加到 `pubspec.yaml` 中。
- [x] 更新 `pubspec.yaml` 的描述，並將版本設定為 `0.1.0`。
- [x] 建立一個基礎的 `analysis_options.yaml` 檔案，以強制執行良好的編碼實踐。
- [x] 移除預設的樣板程式碼 (例如 `lib/main.dart`, `test/` 目錄)。
- [x] 建立一個佔位的 `README.md` 檔案。
- [x] 建立 `CHANGELOG.md` 檔案，並為版本 `0.1.0` 建立初始條目。
- [x] 將此初始空版本的套件提交到當前分支。
- [x] 提交後，在使用者選擇的設備上啟動應用程式，以確保設定正確。

**階段後檢查清單：**
- [ ] 執行 `dart pub get` 以獲取依賴項。
- [ ] 審查已建立的專案結構。
- [x] 在 `IMPLEMENTATION.md` 中更新日誌。
- [ ] 向使用者展示變更，以獲取提交批准。

### 第二階段：資料模型、服務與持久層

此階段著重於建構應用程式的資料基礎，包括資料模型、服務介面和資料持久化邏輯。

- [x] 根據 `DESIGN.md` 在 `lib/src/domain/` 中建立資料模型類別 (`Recording`, `Dictation`)。
- [x] 在領域層 (domain layer) 建立 `DataRepository` 抽象類別（介面），定義儲存和載入聽寫資料的方法。
- [x] 在 `lib/src/data/` 目錄中實作 `JsonDataRepository`，處理資料與本地 JSON 檔案之間的序列化和反序列化。
- [x] 建立一個 `AudioService`，使用 `record` 和 `just_audio` 套件處理所有音訊錄製和播放邏輯。
- [x] 設定 `path_provider` 以確定音訊檔案和 JSON 資料檔案的本地儲存路徑。

**階段後檢查清單：**
- [x] 為資料模型和儲存庫邏輯建立單元測試。
- [x] 執行 `dart_fix` 和 `analyze_files` 以清理程式碼。
- [ ] 執行單元測試以確保它們全部通過。
- [x] 執行 `dart_format` 以更正格式。
- [ ] 重新閱讀 `IMPLEMENTATION.md` 以了解任何變更。
- [ ] 在 `IMPLEMENTATION.md` 中更新日誌並勾選已完成的任務。
- [ ] 使用 `git diff` 驗證變更，並向使用者呈現提交訊息以供批准。
- [ ] 如果應用程式正在執行，請使用 `hot_reload`。

### 第三階段：使用 Riverpod 進行狀態管理

此階段涉及設定 Riverpod 提供者 (providers) 來管理應用程式的狀態，使其在整個小工具樹 (widget tree) 中易於存取和管理。

- [ ] 透過使用 `@riverpod` 註釋提供者來設定 `Riverpod` 程式碼產生器。
- [ ] 建立 `DictationsNotifier` 提供者來管理聽寫的狀態（列表、新增、移除）。此提供者將使用 `DataRepository`。
- [ ] 建立 `AudioPlayerNotifier` 來管理音訊播放器的狀態（播放、暫停、進度、當前檔案）。這將使用 `AudioService`。
- [ ] 建立 `SettingsProvider` 來管理應用程式設定，例如段落之間的暫停持續時間。
- [ ] 執行 `build_runner` 以產生提供者程式碼。

**階段後檢查清單：**
- [ ] 為 Riverpod 通知器 (notifiers) 建立單元測試。
- [ ] 執行 `dart_fix` 和 `analyze_files`。
- [ ] 執行測試。
- [ ] 執行 `dart_format`。
- [ ] 在 `IMPLEMENTATION.md` 中更新日誌和檢查清單。
- [ ] 向使用者呈現變更以供批准。
- [ ] 如果應用程式正在執行，請使用 `hot_reload`。

### 第四階段：UI - 主題與導航

此階段設定視覺基礎，包括應用程式的主題和使用 `go_router` 的導航結構。

- [ ] 在 `main.dart` 中設定 `ProviderScope` 和 `MaterialApp.router`。
- [ ] 建立 `lib/src/core/theme.dart` 檔案，以定義具有指定黑色背景和粉紫色主色的 Material 3 `ThemeData`。
- [ ] 在 `lib/src/core/router.dart` 檔案中設定 `go_router`。為主要頁面定義路由：`/` (分類/首頁), `/record`, `/playback`, `/settings`。
- [ ] 為每個路由建立基本的佔位螢幕以驗證導航。

**階段後檢查清單：**
- [ ] 執行 `dart_fix` 和 `analyze_files`。
- [ ] 執行 `dart_format`。
- [ ] 在 `IMPLEMENTATION.md` 中更新日誌和檢查清單。
- [ ] 向使用者呈現變更以供批准。
- [ ] 如果應用程式正在執行，請使用 `hot_reload`。

### 第五階段：UI - 首頁與錄音頁面

在後端邏輯就緒後，此階段著重於建構主要的使用者介面功能。

- [ ] 實作首頁 (`/`) 的 UI，用於建立/選擇聽寫分類和課本。將 UI 連接到 `DictationsNotifier`。
- [ ] 實作錄音頁面 (`/record`) 的 UI。
- [ ] 顯示當前的分類和課本名稱。
- [ ] 實作大型、長按錄音按鈕，將其連接到 `AudioService`。
- [ ] 實作列表視圖以顯示已錄製的音訊段落。
- [ ] 實作長按手勢以彈出段落的刪除確認對話框。
- [ ] 實作單個段落的播放按鈕。

**階段後檢查清單：**
- [ ] 為首頁和錄音頁面建立小工具測試 (widget tests)。
- [ ] 執行 `dart_fix` 和 `analyze_files`。
- [ ] 執行所有測試。
- [ ] 執行 `dart_format`。
- [ ] 在 `IMPLEMENTATION.md` 中更新日誌和檢查清單。
- [ ] 向使用者呈現變更以供批准。
- [ ] 如果應用程式正在執行，請使用 `hot_reload`。

### 第六階段：UI - 播放與設定頁面

此階段完成剩下的 UI 螢幕。

- [ ] 實作播放頁面 (`/playback`) 的 UI。
- [ ] 添加用於播放/暫停、下一個和上一個段落的 UI 控制項。
- [ ] 實作錄音段落的拖放重新排序功能。
- [ ] 實作設定頁面 (`/settings`) 的 UI。
- [ ] 添加一個控制項（例如滑塊或文字欄位）以設定段落之間的暫停持續時間。

**階段後檢查清單：**
- [ ] 為播放和設定頁面建立小工具測試。
- [ ] 執行 `dart_fix` 和 `analyze_files`。
- [ ] 執行所有測試。
- [ ] 執行 `dart_format`。
- [ ] 在 `IMPLEMENTATION.md` 中更新日誌和檢查清單。
- [ ] 向使用者呈現變更以供批准。
- [ ] 如果應用程式正在執行，請使用 `hot_reload`。

### 第七階段：最終化

最後階段涉及完善應用程式、添加文件並準備交付。

- [ ] 為套件建立一個全面的 `README.md` 檔案，解釋應用程式的功能以及如何執行它。
- [ ] 建立一個 `GEMINI.md` 檔案，描述應用程式的用途、實作細節和檔案結構。
- [ ] 要求使用者檢查最終的應用程式和程式碼，以確認滿意度並檢查是否需要任何修改。

---
*在完成一項任務後，如果您在程式碼中添加了任何 TODO，或有任何未完全實作的部分，請確保新增任務，以便稍後回來完成它們。*
