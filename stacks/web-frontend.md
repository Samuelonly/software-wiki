---
block: web-frontend
version: V1
updated: 2026-11-24
source:
  - name: VibeStart
    repo: https://github.com/VinkyDev/vibestart
    site: https://vibestart.net
    commit: 8565902dfdd3d1d2530a46f8051cd038bfba7d04
    commit_date: 2026-11-23
    license: MIT
verification: 实测
---

# Web 前端 / 全栈 TypeScript（VibeStart）

## 一句话定位

逐层组合 TypeScript 全栈技术栈，生成带类型、lint、测试、AGENTS.md 的项目骨架；**每一种支持的组合都在 CI 里真装、真测、真构建过**——这是它区别于所有"选型横评"的地方。

## fit —— 适合什么场景

- 全栈 TypeScript：从数据库到页面一种语言，类型从表结构传到接口再到页面，不用代码生成
- 给 AI Agent 写代码用：项目自带 `AGENTS.md`（写明每类改动放哪、怎么做），类型/lint/测试几秒内报错，Agent 能自己修正
- 想要"组合可控"的人：每项技术是一个带文件、依赖、约束的 integration，项目由选中的组合拼出来；不能工作的组合会被**拒绝**并给出最少改动的修正方式
- 需要长期维护：生成的是普通代码仓库，运行时不依赖 VibeStart；`upgrade` 三方合并升级模板、保留业务代码

不适合：要用非 TypeScript 后端（Go/Python/Java/Rust）、桌面端要 QT/Tauri、移动端要原生 Swift/Kotlin——见「不覆盖」。

## 覆盖清单 —— 有哪些选项

官网首页标注：**3489 种组合 · 11 个层级 · 26 项技术，全部通过完整验证**（vibestart.net，与截图一致）。下表按 GitHub README「支持的技术栈」表原文列出，表格里是 14 行——官网的"11 层级"和 README 的 14 行口径不同（README 把模式、工具链等也算进表里），两个数都按来源原样记，不替它们调和。

| 层级 | 选项 |
|---|---|
| 模式 | Standard（默认） / Effect（`--mode effect`） |
| 应用 | React SPA（TanStack Router） / TanStack Start / Next.js |
| 桌面端 | Electron |
| 移动端 | Expo（React Native），iOS 与 Android |
| 后端 | Hono / Effect HTTP / 框架自带服务 |
| API | oRPC / Effect RPC / OpenAPI / 不选 |
| 数据库 | PostgreSQL / MySQL / SQLite / MongoDB / 不选 |
| ORM | Drizzle；PostgreSQL 与 MySQL 也可选 Prisma；MongoDB 用 Mongoose |
| Auth | Better Auth |
| 部署 | Docker / Void on Cloudflare Workers（预览） |
| UI | shadcn（Base UI）与 Tailwind 4 |
| 单元和集成测试 | Vitest |
| 端到端测试 | Playwright / TesterArmy e2e |
| 工具链 | Vite+、Oxlint、Knip、`AGENTS.md` |

技术取向（原文）：TypeScript 7、React 19 + React Compiler、Drizzle ORM 1.0、Oxlint + Oxfmt、Vite+。原则：开源、不绑定厂商、每种能力只用一个库。

生成项目后的校验命令（原文）：
- `vp run dev` —— 启动本地开发
- `vp run ready` —— **依次执行类型、lint、死代码、测试、构建**五项检查（从快到慢）。注意：这是 **VibeStart 自己**的检查流程，不是所有项目都该这样——别的项目跑什么检查，由它自己的工具链决定。
- `npx vibestart-cli doctor` —— 检查项目状态与可用模板更新
- `npx vibestart-cli upgrade` —— 三方合并升级底层模板，保留业务代码

搭建方式：
- 网页工作台逐层选，复制命令；或终端 `npx vibestart-cli` 按提示回答
- 给 AI 用：`npx skills add VinkyDev/vibestart --skill vibestart`（装 vibestart skill）

## 不覆盖 —— 明确没有什么

**这一节是这个库最该记住的**——VibeStart 只覆盖 TypeScript 全栈这一块：

| 维度 | 它有的 | 它**没有**的 |
|---|---|---|
| 桌面端 | Electron | **QT、Tauri、Wails、Avalonia、WinUI(Fluent)、Flutter Desktop** |
| 移动端 | Expo（React Native） | **原生 Swift/SwiftUI、Kotlin、Flutter** |
| 后端 | Hono、Effect HTTP、框架自带 | **Go、Python、Java、Rust、C/C++** |
| 嵌入式 | 无 | **ESP32、Arduino、Zephyr、FreeRTOS、Embedded C/C++** |
| 游戏 | 无 | **Unity、Unreal、Godot、Bevy** |
| 数据库 | PostgreSQL/MySQL/SQLite/MongoDB | Redis、ClickHouse 等 |

这些空位正是 `stacks/` 里其他文件等着填的。**「它没做」≠「它做得差」**——别拿 VibeStart 的缺口说它不完整，它压根不干那些。

## gotchas —— 坑在哪

**来源明说的：**
1. 不能工作的组合会被拒绝——选栈时会出现"这个组合不行"，并给出改动最少的修正方式。这是特性，不是 bug，但意味着**不是任意组合都能生成**。
2. `upgrade` 是三方合并（原始模板 / 你的项目 / 新模板）——写入前会预览，但升级模板这件事本身需要人看着。
3. 技术取向偏激进：TypeScript 7、React 19 + React Compiler、Oxlint/Oxfmt、Drizzle 1.0 都是"正在成为新标准"的东西。原文明确说只提供"已经成为当前标准、或正在成为新标准"的技术。
4. VibeStart 不托管应用、不迁移生产数据、不隐藏代码。生成后运行时与它无关——**别指望它帮你运维**。

**推断的（标注，别当事实）：**
5. （推断）只覆盖 TypeScript 全栈，意味着项目一旦引入非 TS 组件（比如 Rust 写的性能模块），这套工程规范管不到那部分。
6. （推断）`vp` 是 Vite+ 统一工具链，团队需要接受这套工具链；跟已有 Vite 工作流可能有迁移成本。

## 验证依据

这是 VibeStart 最强的一点，原文说法：

> **每个组合都经过验证。** 每次发布前，所有支持的组合都会被覆盖：`vp run ready` 读取的每个文件、它的任意三项选择的搭配，都已在 CI 实际运行的某个组合中通过安装、类型检查、lint、测试、浏览器测试和生产构建。通过结果连同指纹记录在 [`verification`](https://github.com/VinkyDev/vibestart/tree/verification) 分支上，CLI 在创建项目时展示其中一条代表性验证。

- 官网首页：https://vibestart.net —— 「3489 种组合全部通过完整验证」
- CI badge：https://github.com/VinkyDev/vibestart/actions/workflows/ci.yml
- verification 分支：https://github.com/VinkyDev/vibestart/tree/verification
- 锁死 commit：`8565902dfdd3d1d2530a46f8051cd038bfba7d04`（2026-11-23，PGP 已验证）

**结论：标 `实测` 有据。** 这是目前 `stacks/` 里唯一有公开 CI 实测记录、能标"实测"的来源。

## 待核实

无。
