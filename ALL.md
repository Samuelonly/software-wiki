# Stacks + Checklists — 完整版

本文件由 `scripts/build.sh` 自动生成。
请编辑 `stacks/` 和 `checklists/` 下的分文件，然后重新运行本脚本，不要直接改本文件。

---

# 第一部分：stacks/ 技术选型库

<!-- source: stacks/ai-ml.md -->

# ai-ml.md

AI / ML 框架和推理引擎。

**当前状态**：待填。没人真要训模型/部署大模型时不提前挖。

## 待填框架

| 框架/引擎 | 语言 | 何时填 |
|---|---|---|
| PyTorch | Python | 有人真要训模型时填 |
| TensorFlow | Python / C++ | 有人真要训模型时填 |
| ONNX Runtime | C++ / Python | 有人真要模型部署时填 |
| llama.cpp | C++ | 有人真要本地跑大模型时填 |
| HuggingFace Transformers | Python | 有人真要微调模型时填 |
| vLLM | Python | 有人真要高吞吐推理时填 |
| Ollama | Go | 有人真要本地跑模型时填（封装 llama.cpp） |

---

<!-- source: stacks/database.md -->

# database.md

数据库。

**当前状态**：VibeStart 覆盖了 TS 生态下的常用数据库组合（实测）。

## VibeStart 覆盖的数据库（TS 生态，实测）

| 数据库 | ORM | 验证状态 | 来源 |
|---|---|---|---|
| PostgreSQL | Drizzle ORM / Prisma | `实测` | VibeStart commit `8565902d` |
| MySQL | Drizzle ORM / Prisma | `实测` | VibeStart commit `8565902d` |
| SQLite | Drizzle ORM | `实测` | VibeStart commit `8565902d` |
| MongoDB | Mongoose | `实测` | VibeStart commit `8565902d` |

## 不在 VibeStart 覆盖范围内（待填，标 `文档`）

- Redis（KV / 缓存）
- ClickHouse（OLAP）
- DuckDB（嵌入式分析）
- Neo4j（图数据库）
- CouchDB / PouchDB（文档数据库）
- Supabase / Firebase（BaaS）

---

<!-- source: stacks/desktop.md -->

# desktop.md

桌面应用框架。

**当前状态**：Tauri 已按新 schema 填成标杆示例（含 derived_checks），其余框架待填。

## Tauri

**验证状态**：`文档`

**fit**：要极致体积（50~90MB）+ 复用前端技术栈的桌面应用。系统 WebView，不打包浏览器内核。

**gotchas**：
- 高版本系统 API 没做运行时版本判断，在老系统直接崩
- fs / shell 等权限 scope 没收窄，等于开了全盘
- App Store 版没开沙箱，审核直接拒；直接分发版没公证，用户首次打开被 Gatekeeper 拦
- 团队没人会 Rust 不是坑（AI 会写）；真正的坑是 borrow checker 报错、IPC 边界设计、WebView 渲染差异这三类问题 AI 容易改三轮还在原地——而这三类恰好都能用机器信号验

**derived_checks**：
- [ ] 编译零警告 → `cargo clippy -- -D warnings`
- [ ] 前端构建通过 → `npm run build`（或对应包管理器）
- [ ] 无未加版本判断的高版本系统 API 调用 → 静态扫描 Rust 侧调系统 API 的位置，必须带运行时版本判断
- [ ] 文件 / 命令权限只含白名单 → 校验 `src-tauri/capabilities/*.json`（v2）或 allowlist（v1），无 `**` / `all`
- [ ] 签名有效 → `codesign --verify --deep --strict --verbose=2 <App>.app`
- [ ] App Store 版沙箱已开 → `codesign -d --entitlements :- <App>.app` 输出含 `com.apple.security.app-sandbox` = `true`
- [ ] 直接分发版 Gatekeeper 放行 → `spctl -a -vv <App>.app` 返回 `accepted`
- [ ] 直接分发版公证票据已装订 → `xcrun stapler validate <App>.app`
- [ ] 最低支持版本实机跑通 → 在最低版本执行「启动 → 打开文件 → 核心流程 → 退出」
- [ ] 最新版本实机跑通 → 同上
- [ ] 安装包体积达标 → 产物 < 目标上限（如 100MB）

**来源**：
- [Tauri 官方文档](https://v2.tauri.app/)
- [Apple Code Signing Guide](https://developer.apple.com/documentation/security/code_signing_guide)
- 跨版本兼容与沙箱差异由 macOS 14 / 15 / 26 起的版本演进实测结论整理，具体断层以版本矩阵实测为准，不靠记忆

---

## Electron

**验证状态**：`实测`

**fit**：要三端行为完全一致、团队全是前端、能接受 150~300MB 体积的项目。

**gotchas**：
- 打包了完整 Chromium，体积大、内存高
- 主进程 / 渲染进程 / preload 三层边界搞错，会开出安全洞
- 自动更新（electron-updater）签名配置错，用户更新后打不开

**derived_checks**：
- [ ] 无 Node 集成暴露给渲染进程 → 校验 `nodeIntegration: false` + `contextIsolation: true`
- [ ] preload 只暴露白名单 API → 校验 preload 脚本无 `require` 直通
- [ ] 签名有效 → `codesign --verify --deep --strict`
- [ ] 更新包能装 → 跑一遍更新流程，更新后能启动
- [ ] 产物体积达标 → 产物 < 目标上限

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- [Electron 安全清单](https://www.electronjs.org/docs/latest/tutorial/security)

---

## SwiftUI（macOS 原生）

**验证状态**：`文档`

**fit**：只做 macOS、要最原生体验和最小体积（< 20MB）、不介意锁死 Apple 生态。

**gotchas**：
- 复杂表格 / 树 / 富文本编辑器在 SwiftUI 里不完整，要 `NSViewRepresentable` 桥回 AppKit，桥接层的生命周期容易错
- 版本差异大：Observation（`@Observable`）要 macOS 14+，新导航 / 新控件在 15+ 才有，低版本要整套降级分支
- 菜单栏、右键菜单、多窗口这类桌面能力，SwiftUI 覆盖晚于 AppKit，经常要混写
- AI 写 SwiftUI 容易用错 `@State` / `@Binding` / `@Environment` 的所有权，报错信息难读

**derived_checks**：
- [ ] 编译零警告 → `xcodebuild build -scheme <Scheme> -destination 'platform=macOS'` 且 `-warnings-as-errors`
- [ ] 无未加版本判断的新 API → 静态扫描无 `if #available` 包裹的新 API 调用
- [ ] 产物架构完整 → `lipo -info <App>.app/Contents/MacOS/<bin>` 含目标架构
- [ ] 无私有 API（App Store 会拒）→ `nm -u <bin>` 不出现私有符号
- [ ] 签名有效 → `codesign --verify --deep --strict --verbose=2 <App>.app`
- [ ] 沙箱 / 公证按分发方式通过 → App Store 版 `codesign -d --entitlements :-` 含 `app-sandbox=true`；直接分发版 `spctl -a -vv` + `xcrun stapler validate`
- [ ] 最低支持版本实机跑通 → 启动 → 打开文件 → 核心流程 → 退出
- [ ] 体积达标 → 产物 < 目标上限

**来源**：
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI 版本可用性](https://developer.apple.com/documentation/swiftui)

---

## AppKit

**验证状态**：`文档`

**fit**：要完整桌面能力（复杂表格、多窗口、自定义菜单、底层事件）、能接受 Objective-C 时代的老 API 风格。

**gotchas**：
- Delegate / Target-Action / KVO 三套老范式并存，AI 经常混着写，导致回调不触发且不报错
- 内存管理虽有 ARC，但 delegate 强引用循环、`NSWindow` 生命周期错序仍会造成崩溃
- 和 SwiftUI 混写时的线程约束（UI 必须主线程）容易漏，表现为随机卡死

**derived_checks**：
- [ ] 编译零警告 → `xcodebuild build ... -warnings-as-errors`
- [ ] 无循环引用（关键 delegate）→ 静态扫描 `weak var delegate`
- [ ] UI 更新都在主线程 → 静态扫描 `DispatchQueue.main` / `@MainActor`
- [ ] 签名 / 沙箱 / 公证 → 同 SwiftUI 那四项
- [ ] 最低支持版本实机跑通 → 同上

**来源**：
- [Apple AppKit 文档](https://developer.apple.com/documentation/appkit)

---

## 待填框架

| 框架 | 语言 | 引擎 | 何时填 |
|---|---|---|---|
| Qt | C++ / Python / Rust | Qt | 有人真要 Qt 时填 |
| Wails | Go + 前端 | 系统 WebKit | 有人真要 Wails 时填 |
| Avalonia | C# | 自绘引擎 | 有人真要 WPF 跨平台时填 |
| WinUI (Fluent) | C# | DirectX | 有人真要 Windows only 时填 |
| Flutter Desktop | Dart | Skia | 有人真要 Flutter 跨平台时填 |

---

<!-- source: stacks/embedded.md -->

# embedded.md

嵌入式 / 物联网开发。

**当前状态**：待填。没人真要写 ESP32/Arduino 项目时不提前挖。

## 待填框架

| 平台/框架 | 语言 | 何时填 |
|---|---|---|
| Embedded C/C++ | C / C++ | 有人真要写裸机时填 |
| ESP32 | C / MicroPython | 有人真要写 ESP32 时填 |
| Arduino | C++ / MicroPython | 有人真要写 Arduino 时填 |
| Zephyr | C | 有人真要 RTOS 时填 |
| FreeRTOS | C | 有人真要 RTOS 时填 |
| Raspberry Pi | Python / C | 有人真要树莓派时填 |

---

<!-- source: stacks/mobile.md -->

# mobile.md

移动端框架。

**当前状态**：待填。没人真要写 App 时不提前挖。

## VibeStart 覆盖的移动端（TS 生态，实测）

### Expo (React Native)
- 验证状态：`实测`
- fit：跨 iOS/Android 的 React Native 开发工具链
- 来源：[VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）
- 注：VibeStart 选了 Expo，因为它比裸 React Native 少折腾构建工具链

## 不在 VibeStart 覆盖范围内（待填，标 `文档`）

- Swift / SwiftUI（iOS native）
- Kotlin / Jetpack Compose（Android native）
- Flutter (Dart)
- React Native（裸版，非 Expo）
- .NET MAUI (C#)

---

<!-- source: stacks/web-backend.md -->

# web-backend.md

Node / Go / Python / Java / Rust 后端运行时。

**当前状态**：待填。没人真要用 Go/Rust 写后端项目时，不提前挖。

## VibeStart 覆盖的后端（TS 生态，实测）

以下是 VibeStart 支持的后端选项，都有 verification 记录：

### Hono
- 验证状态：`实测`
- fit：轻量 TypeScript 后端，Cloudflare Workers / Node / Bun 均可跑
- 来源：[VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）

### Effect HTTP
- 验证状态：`实测`
- fit：Effect 模式下的后端，带 typed errors 和依赖注入
- 来源：[VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）

### 框架内置 server
- 验证状态：`实测`
- fit：Next.js / TanStack Start 自带的 server，不需要单独后端
- 来源：[VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902d`）

## 不在 VibeStart 覆盖范围内（待填，标 `文档`）

- Node（纯 Express / Fastify / NestJS）
- Go（Gin / Chi / Echo / Fiber）
- Python（FastAPI / Django / Flask）
- Java（Spring Boot / Quarkus / Micronaut）
- Rust（Axum / Actix-web / Rocket / Salvo）

---

<!-- source: stacks/web-frontend.md -->

# web-frontend.md

TypeScript 生态的浏览器端框架。数据来源：VibeStart（commit `8565902d`），verification 分支。

## React SPA + TanStack Router

**验证状态**：`实测`

**fit**：纯前端单页应用（SPA），不需要 SSR/SSG。管理后台、工具网站、交互式仪表板。

**gotchas**：
- React 19 的 Compiler 要求所有组件函数不能返回 JSX 之前有副作用，老项目升级要注意
- TanStack Router 的 file-based routing 和 Vite 的约定式路由不同，路径映射规则要单独学
- shadcn/ui 生成的组件是拷贝进项目的，更新要手动 merge，和 VibeStart 的 upgrade 可能冲突

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- verification fingerprint：每个 VibeStart 生成的项目都有唯一 SHA-256 记录在 [`verification`](https://github.com/VinkyDev/vibestart/tree/verification) 分支，格式 `linux/<fingerprint>.json`
- 生成命令：`npx vibestart-cli` → App 层选 `React SPA (TanStack Router)`

---

## TanStack Start

**验证状态**：`实测`

**fit**：需要 SSR/SSG 的 React 全栈应用。TanStack Router + TanStack Query 的官方后端，不需要 Next.js 的全量框架。

**gotchas**：
- 比 Next.js 生生态小，组件库和教程少，遇到坑基本只能去 TanStack 官方 Discord 问
- 内置了 Vite，和其他 Vite 插件的兼容性要自己测
- 部署选项只有 Void（Cloudflare Workers）和 Docker，没有 Vercel/Netlify 一键

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- 生成命令：`npx vibestart-cli` → App 层选 `TanStack Start`

---

## Next.js

**验证状态**：`实测`

**fit**：需要 SEO、SSG、或 Vercel 生态的 React 应用。最大的 React 全栈框架，教程和组件最多。

**gotchas**：
- Next.js App Router 的 server/client 组件边界是隐式的，新人容易写错
- VibeStart 用的是 Next.js（不是 Next.js 15 的 App Router 模式），生成的结构和官方最新模板有差异
- 部署到非 Vercel 平台（Cloudflare Workers、纯 Docker）比 Vercel 麻烦

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- 生成命令：`npx vibestart-cli` → App 层选 `Next.js`

---

## Vite+（工具链）

**验证状态**：`实测`

**fit**：VibeStart 生成的所有项目统一用 `Vite+`（不是纯 Vite），一个命令管 dev / ready / type-check / lint / unused / test / build。

**gotchas**：
- `vp run ready` 是"最快先报"的执行顺序（lint 快先跑，test 慢后跑），CI 上要注意它不是全量跑完再退出
- Vite+ 是 VitePlus.dev 的商业工具，VibeStart 用了免费版，以后会不会转收费不确定

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- [Vite+ 官网](https://viteplus.dev/)

---

## Tailwind 4 + shadcn/ui（UI 层）

**验证状态**：`实测`

**fit**：VibeStart 所有项目统一用 Tailwind 4（不是 Tailwind 3）+ shadcn/ui（Base UI 变体），AI 写样式不用想，全是 @apply。

**gotchas**：
- Tailwind 4 用了 Vite 插件代替 PostCSS 配置，老项目升级要改 tailwind.config.js 为 CSS-first 配置
- shadcn/ui 组件是拷贝进项目的，AI 改组件容易改乱，upgrade 时要人工 merge

**来源**：
- [VibeStart](https://github.com/VinkyDev/vibestart)（commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`）
- [shadcn/ui](https://ui.shadcn.com/)

---

## 不在 VibeStart 覆盖范围内（待填，标 `文档`）

以下框架目前 VibeStart 不支持，等有人真要用时从官方文档和横评文章里挖，标 `文档`：

- Vue（Vite 支持但 VibeStart 不支持）
- Svelte / SvelteKit
- Solid
- Qwik
- Angular

---

# 第二部分：checklists/ 品类功能清单

<!-- source: checklists/archive-utility.md -->

# 压缩软件（archive-utility）

**当前状态**：待填。第一个要攒的品类——Commander 的 42 条基线就归这里。

**核心问题**：压缩软件用户在哪一下骂娘？把那一骂写成一条验收项。

## 待填条目（等攒）

- 用户拿到手会在哪一下骂娘？写一条
- ...

**来源方向**：自己踩过的坑、竞品对比（7-Zip / Bandizip / WinRAR / Keka）、知乎/小红书吐槽帖

---

<!-- source: checklists/chat-app.md -->

# 即时通讯 App（chat-app）

**当前状态**：待填。有人真要做聊天 App 时再攒。

## 待填条目（等攒）

- 用户拿到手会在哪一下骂娘？写一条
- ...

**来源方向**：竞品对比（微信 / Telegram / Discord / Signal）、自己踩过的坑、iOS/Android 权限坑

---

<!-- source: checklists/password-manager.md -->

# 密码管理器（password-manager）

**当前状态**：待填。有人真要做密码管理器时再攒。

## 待填条目（等攒）

- 用户拿到手会在哪一下骂娘？写一条
- ...

**来源方向**：竞品对比（1Password / Bitwarden / KeePass / Apple Passwords）、自己踩过的坑、安全漏洞榜单

---

