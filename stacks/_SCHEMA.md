# stacks/ 字段格式定义

每个技术块一个文件（如 `web-frontend.md`），文件内每一条技术栈一个条目。

## 条目格式

```markdown
## [技术栈名称]（如 React SPA + TanStack Router）

**验证状态**：`实测` / `文档`

**fit**：适合什么场景，一句话。

**gotchas**：坑在哪，最多 3 条，每条一句。

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）
- verification fingerprint：`linux/<sha256>.json`（CI 通过记录）

---
```

## 验证状态取值

| 值 | 含义 | 铁律 |
|---|---|---|
| `实测` | 组合被某来源在 CI 里真装、真测、真构建过 | 必须附 verification 记录链接或 fingerprint，空口无凭一律标 `文档` |
| `文档` | 只是官方文档或横评文章这么写 | 必须附来源链接，别冒充 `实测` |

## 铁律

1. 找不到实测来源就标 `文档`，**别冒充 `实测`**。
2. 先有字段格式，再填第二条；不按格式的条目不收。
3. 一个技术块一个文件，别把不同平台/语言混进一条。
4. 来源锁 commit，不跟上游漂移。
5. 每条条目写人话，不说术语。

## 文件命名

`stacks/` 下每个技术领域一个文件：

| 文件 | 覆盖范围 |
|---|---|
| `web-frontend.md` | React / Vue / Svelte / Next.js / TanStack 等浏览器端框架 |
| `web-backend.md` | Node / Go / Python / Java / Rust 等后端运行时 |
| `desktop.md` | Tauri / Electron / Qt / Wails / Avalonia / WinUI / Flutter Desktop |
| `mobile.md` | Swift / SwiftUI / Kotlin / Flutter / React Native / Expo |
| `embedded.md` | Embedded C / ESP32 / Arduino / Zephyr / FreeRTOS |
| `database.md` | PostgreSQL / SQLite / MongoDB / Redis / ClickHouse |
| `game.md` | Unity / Unreal / Godot / Bevy |
| `ai-ml.md` | PyTorch / TensorFlow / ONNX / llama.cpp |
