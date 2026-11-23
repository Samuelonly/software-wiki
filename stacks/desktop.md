# desktop.md

桌面应用框架。

**当前状态**：待填。Commander 产品用 Tauri 做客户端时再填第一条。

## 待填框架

| 框架 | 语言 | 引擎 | 何时填 |
|---|---|---|---|
| **Tauri** | Rust + 前端 | 系统 WebKit | Commander 客户端 Phase 4 时填 |
| Electron | Node + 前端 | Chromium | 有人真要 Electron 时填 |
| Qt | C++ / Python / Rust | Qt | 有人真要 Qt 时填 |
| Wails | Go + 前端 | 系统 WebKit | 有人真要 Wails 时填 |
| Avalonia | C# | 自绘引擎 | 有人真要 WPF 跨平台时填 |
| WinUI (Fluent) | C# | DirectX | 有人真要 Windows only 时填 |
| Flutter Desktop | Dart | Skia | 有人真要 Flutter 跨平台时填 |

## VibeStart 覆盖的桌面（TS 生态，实测）

### Electron
- 验证状态：`实测`
- 来源：[VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）
- 注：VibeStart 选了 Electron（不是 Tauri），因为它要跨平台，且 TS 生态集成 Electron 最成熟
