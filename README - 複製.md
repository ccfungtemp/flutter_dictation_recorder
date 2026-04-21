# 🚀 Flutter 專案開發協定 (AI Agent Protocol)

**本文件為 Gemini CLI / AI Agent 的執行規範。在生成本專案的程式碼、架構或進行技術選型時，必須優先讀取並嚴格遵守以下準則。**

## 🛠 技術規格 (Technical Specification)
## 🤖 AI 代理在生成代碼時，必須嚴格遵守以下技術選型：

**當涉及以下功能開發時，必需直接使用指定套件，無需詢問：**

* **狀態管理 (State)** -> `riverpod` (搭配 `riverpod_annotation`)
* **資料建模 (Model)** -> `freezed` + `json_serializable`
* **網路請求 (Network)** -> `dio`
* **本地資料庫 (DB)** -> `drift`
<!-- * **簡易儲存 (Storage)** -> `shared_preferences` -->
* **路由導航 (Route)** -> `go_router`
* **圖片快取 (Image)** -> `cached_network_image`
<!-- * **適配佈局 (Layout)** -> `flutter_screenutil`
* **動畫效果 (Anim)** -> `flutter_animate` -->

---

### 🛠 核心開發原則
1. **邏輯抽離**：UI 層僅負責畫面呈現，所有業務邏輯必須實作於 Provider 或 Repository 中。
2. **自動生成**：使用 `freezed` 或 `riverpod` 時，自動補全 `part 'filename.g.dart';`。
3. **優先 const**：所有 Widget 優先使用 `const` 構造函數以優化性能。
4. **命名規範**：嚴格遵循 `analysis_options.yaml` 與 Dart 官方命名慣例。

## 🤖 AI 開發規範 (AI Instruction Rules)
### 2. 開發實作準則 (Implementation Guidelines)
* **語言規範** -> **註解、Log 輸出及 UI 文字必須統一使用「繁體中文」**。
* **安全性限制** -> 嚴禁將 API Key 或敏感資訊寫死在程式碼中，必須透過 `.env` 或 `lib/src/core/constants/` 讀取。
* **異步處理** -> 所有 `Future` 操作必須包裹 `try-catch`。
* **要求**：錯誤捕獲後必須轉換為友好的中文提示，並與 `core/error/` 的 Failure 類別對接。
* **資產優先** -> 在生成新元件前，**必須先檢索** `lib/src/core/components/` 是否已有可複用組件。
* **狀態監控** -> 修改 Model 或 Provider 代碼後，必須主動提醒使用者執行：
    `dart run build_runner build --delete-conflicting-outputs`

### 3. 程式碼品質要求
* **優先 const**：所有 Widget 構造函數若無動態變數，必須加上 `const`。
* **型別安全**：嚴禁使用 `dynamic`，所有變數與函式回傳值必須明確宣告型別。
* **註解標準**：複雜邏輯必須附上「繁體中文」註解，說明業務邏輯與預期結果。

---

## 🏗 資料夾架構 (Folder Structure)
所有原始碼位於 `lib/src`。請嚴格遵守以下路徑：

### 1. 核心層 (Core Layer) - 基礎設施與通用標準
* **`lib/src/core/constants/`**: 全局數值常數 (API Endpoints, App Config)。
* **`lib/src/core/network/`**: 網路底層封裝 (DioClient 單例、攔截器)。
* **`lib/src/core/theme/`**: 主題配置 (AppTheme、AppColors、字體樣式)。
* **`lib/src/core/error/`**: 統一的異常與錯誤類型定義 (Failure 類別)。
* **`lib/src/core/utils/`**: 全專案通用的邏輯工具 (DateHelper, Formatters)。
* **`lib/src/core/widgets/`**: **【標準組件庫】** 存放跨專案通用的基礎 UI 元件。

### 2. 數據與邏輯層 (Data & Logic Layer)
* **`lib/src/models/`**: 資料實體類 (Data Classes)，須包含 JSON 序列化。
* **`lib/src/services/`**: 具體業務 API 請求邏輯。**禁止在此層維護狀態**。
* **`lib/src/providers/`**: 狀態管理 (Riverpod)。負責業務邏輯與數據供應。

### 3. 呈現層 (Presentation Layer)
* **`lib/src/screens/`**: 完整 UI 頁面 (具備 Scaffold 的路由分頁)。
* **`lib/src/widgets/`**: **【客製化組件】** 存放專為本專案設計的 UI 元件。

---

## 🤖 AI 開發規範 (AI Instruction Rules)

### 1. 命名規範 (Naming Convention)

#### 基本規則
- 檔案名稱：`snake_case.dart`
- 類別名稱：`PascalCase`
- 變數 / 函式：`camelCase`

#### 類型後綴（強制）
- 頁面：`xxx_screen.dart`
- 模型：`xxx_model.dart`
- Provider：`xxx_provider.dart`
- Service：`xxx_service.dart`
- Repository：`xxx_repository.dart`

### 2. 開發準則
* **語言限制**: 註解、Log 及 UI 文字統一使用 **「繁體中文」**。
* **安全性**: API Key 嚴禁寫死，須從 `.env` 或 `core/constants` 讀取。
* **自動化生成**: 修改 Model/Provider 後，提醒使用者執行 `dart run build_runner build`。
* **錯誤處理**: 非同步操作必須包裹 `try-catch`，並回傳友好的中文錯誤提示。
* **資產複用**: 優先使用 `core/widgets/` 與 `core/utils/` 下的現有資源。

---

## 📦 現有資產庫 (Existing Library)
* **通用按鈕**: `AppPrimaryButton` -> `lib/src/core/widgets/common/button.dart`
* **加載動畫**: `AppLoadingIndicator` -> `lib/src/core/widgets/feedback/loading.dart`
* **工具函數**: `DateHelper.formatDate()` -> `lib/src/core/utils/date_helper.dart`

---

## 🚀 待執行任務 (Current Roadmap)
- [ ] 1. 初始化 `pubspec.yaml` 並加入必要套件。
- [ ] 2. 建立 OpenWeatherMap 的資料模型 (Model)。
- [ ] 3. 實作定位 Provider 獲取目前經緯度。
- [ ] 4. 建立首頁 UI (顯示氣溫、體感溫度、天氣圖標)。