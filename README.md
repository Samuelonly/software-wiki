# Software Wiki（软件 Wiki）

一个给 AI 和人都可读的技术知识库，分两半：

- **`stacks/` 技术选型库** —— 做这个项目该用什么技术
- **`checklists/` 品类功能清单** —— 这类软件该有哪些本事

## 为什么需要这个库

AI 做软件有个天生缺陷：它只会干它"知道"的事。你没说、它经验里也没有的那些点——比如"改了原文件但忘了改 backup"——根本不会进它的计划。它再认真检查，也只能检查出计划里那几件事。

这个库就是那层"外挂知识"：把隐藏项提前写下来，让 AI 能看到、能照着做。

## 两半，别混

| | `stacks/` | `checklists/` |
|---|---|---|
| 回答的问题 | 用什么技术搭 | 该有哪些功能 |
| 一条长什么样 | 一个技术块的组合与坑 | 一句人话，能一句话验完 |
| 谁提供的 | 现成素材抽取（VibeStart 等） | 自己攒，从被坑过的经验里挖 |
| 谁会问 | 想选栈的人 | 不懂技术的人 |

## 目录结构

```
/
├── README.md               ← 你在这
├── stacks/                 ← 第一半：技术选型库
│   ├── _SCHEMA.md          ← 字段定义（填之前先读）
│   ├── web-frontend.md     ← V1：VibeStart 抽出的第一批
│   ├── web-backend.md      ← 待填：Node(Hono/Express) / Go / Python / Java / Rust
│   ├── desktop.md          ← 待填：Tauri / Electron / Qt / Wails / Avalonia / WinUI(Fluent) / Flutter Desktop
│   ├── mobile.md           ← 待填：Swift / SwiftUI / Kotlin / Flutter / React Native / Expo
│   ├── embedded.md         ← 待填：Embedded C/C++ / ESP32 / Arduino / Zephyr / FreeRTOS
│   ├── database.md         ← 待填：PostgreSQL / SQLite / MongoDB / Redis / ClickHouse
│   ├── game.md             ← 待填：Unity / Unreal / Godot / Bevy
│   └── ai-ml.md            ← 待填：PyTorch / TensorFlow / ONNX / llama.cpp
└── checklists/             ← 第二半：品类功能清单
    ├── _SCHEMA.md          ← 字段定义（填之前先读）
    └── archive-utility.md  ← 示例：压缩软件（待填）
```

## 怎么填 `stacks/`（技术选型库）

每条技术块一个文件，用统一字段（详见 `stacks/_SCHEMA.md`）。核心字段：

- **fit**：适合什么场景
- **gotchas**：坑在哪
- **验证状态**：`实测`（组合被真装真测过） / `文档`（只是文档这么写）
- **来源**：从哪抽的，锁 commit

铁律：

1. VibeStart 是唯一"实测"级别的素材——它的所有支持组合在 CI 里真装、真测、真构建过。抽它时把验证结果留下来，这是它比所有横评强的地方。
2. 找不到实测来源就标 `文档`，**别冒充 `实测`**。
3. 标 `实测` 必须有来源链接或 commit，空口无凭。
4. 先有字段格式，再填第二条；不按格式的条目不收。
5. 一个技术块一个文件，别把不同平台/语言混进一条。

## 怎么填 `checklists/`（品类功能清单）

一个软件品类一份文件。每条验收项是一句人话。

一条合格的验收项，三条标准：

1. **说"该有什么本事"，不说"怎么实现"** —— 写"原文件不能被删"，不写"用 copy-then-delete 模式"。
2. **一句话能验完，不用看代码** —— 外行照着念就能判。
3. **用户真在乎，但买家想不到要问** —— 这是清单的价值。谁都能想到"能打开压缩文件"，想不到"改了 backup 没"。

写的时候只问自己一句：**用户拿到手会在哪一下骂娘？** 把那一骂写成一条。

铁律：

1. 条数因品类而异，**别凑数**。压缩软件可能很多，别的可能就五条。
2. 不确定的条目宁可不写；写了就得能验。
3. 每条标注来源——从哪次真实的坑里来的。

## 怎么用这个库

1. 确定要做什么软件 → 找到对应品类的 `checklists/xxx.md`
2. 把清单喂给 AI 的计划生成 → 原本不会出现在计划里的隐藏项被逼进去
3. 计划跑完 → 拿同一份清单逐条验；不过的原句就是驳回意见（不用组织语言，照念给 Agent 听）
4. `stacks/` 在生成项目地基时参考，在技术选型那一步提示坑

## 这个库不装什么

- 不装代码（脚手架、状态机、MCP server 都不在这）
- 不装产品逻辑（任何工具的实现都不在这层）
- 只装"知识"——能被直接读进上下文的 markdown / yaml 条目

## 来源与致谢

本库的 V1 内容取自以下开源项目，按 MIT 许可引用，并锁死 commit 不跟上游：

| 来源 | 用途 | 许可 | 锁定 commit |
|---|---|---|---|
| [VibeStart](https://github.com/VinkyDev/vibestart)（作者 Vinky） | `stacks/web-frontend.md` 的全部技术选型事实与实测依据 | MIT | `8565902dfdd3d1d2530a46f8051cd038bfba7d04` |

原项目官网：https://vibestart.net —— 「3489 种组合全部通过完整验证」。那些验证结果是它的作者做的，不是本库做的；本库只做抽取和转述，引用时请保留来源。

## 当前状态

| 半边 | 状态 |
|---|---|
| `stacks/` web-frontend（VibeStart） | **V1 已填**（2026-11-24，锁 commit `8565902d`） |
| `stacks/` 其余八个技术块 | 待填 |
| `checklists/` 各品类 | 待填 |
