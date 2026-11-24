# 技术知识库

一个给 AI 和人都可读的知识库，分两半：

- **`stacks/` 技术选型库** —— 做这个项目该用什么技术，选了之后必须避哪些坑
- **`checklists/` 品类功能清单** —— 这类软件该有哪些本事

## 为什么需要这个库

AI 做软件有个天生缺陷：它只会干它"知道"的事。你没说、它经验里也没有的那些点——比如"改了原文件但忘了改 backup"——根本不会进它的计划。它再认真检查，也只能检查出计划里那几件事。

这个库就是那层"外挂知识"：把隐藏项提前写下来，让 AI 能看到、能照着做。

## 两半，别混

| | `stacks/` | `checklists/` |
|---|---|---|
| 回答的问题 | 用什么技术搭、选了之后避什么坑 | 这类软件该有哪些功能 |
| 一条长什么样 | 一个技术块的 fit / gotchas / derived_checks | 一句人话，能一句话验完 |
| 谁提供的 | 现成素材抽取（VibeStart 等） | 自己攒，从被坑过的经验里挖 |
| 谁会问 | 想选栈的人 | 不懂技术的人 |

**判定口诀：换掉技术栈后这条还成立吗？成立 → 进 `checklists/`；不成立 → 进 `stacks/` 的 `derived_checks`。**

## 两条核心铁律

1. **坑必须能变成机器能跑的检查。** 转不出绿勾/红叉的坑，不进 `stacks/`。
2. **不许出现"需要专家判断"。** 外行不读代码，只看绿勾/红叉，红叉时做决策（换栈 / 接受 / 让 AI 再试）。

详见 [`stacks/_SCHEMA.md`](stacks/_SCHEMA.md) 和 [`checklists/_SCHEMA.md`](checklists/_SCHEMA.md)。

## Scope

只收 **software / application**：桌面、Web、移动、后端、数据库、嵌入式、AI 推理。

**不收游戏引擎**：游戏涉及引擎授权费、后台权限分级、省电与硬件优化，超出本库范围。

## 目录结构

```
/
├── README.md               ← 你在这
├── ALL.md                  ← 全部内容拼接版（scripts/build.sh 生成）
├── scripts/
│   └── build.sh            ← 把分文件拼成 ALL.md
├── stacks/                 ← 第一半：技术选型库
│   ├── _SCHEMA.md          ← 字段定义（填之前先读）
│   ├── web-frontend.md     ← React SPA / TanStack Start / Next.js / Vite+ / Tailwind
│   ├── web-backend.md      ← Hono / Effect HTTP + 待填
│   ├── desktop.md          ← Tauri / Electron / SwiftUI / AppKit + 待填
│   ├── mobile.md           ← Expo + 待填
│   ├── embedded.md         ← 待填
│   ├── database.md         ← Postgres / MySQL / SQLite / MongoDB + 待填
│   └── ai-ml.md            ← 待填
└── checklists/             ← 第二半：品类功能清单
    ├── _SCHEMA.md          ← 字段定义（填之前先读）
    ├── archive-utility.md  ← 待填
    ├── chat-app.md         ← 待填
    └── password-manager.md ← 待填
```

## 给下一个 AI Agent 的接手指南

切换对话窗口后，按这个顺序读：

1. 本文件（README.md）——知道库是干什么的
2. `stacks/_SCHEMA.md` 或 `checklists/_SCHEMA.md`——知道一条该长什么样
3. `ALL.md`——一次拿到全部内容，不用逐个文件读

**动手前必须确认的三件事：**

- 你要写的东西属于 `stacks/` 还是 `checklists/`？用上面的口诀判。
- `stacks/` 里每一条有没有 `derived_checks`？没有就是不合格。
- 有没有写"需要专家审"？有就改写成可执行命令。

**不许做的事：** 凑数、冒充 `实测`、把技术栈信息塞进 `checklists/`、给没人用的技术栈提前填内容。

## 致谢与外部工具

### VibeStart（`stacks/` 实测数据来源）

https://github.com/VinkyDev/vibestart

3489 种 TypeScript 组合每一种都在 CI 里真装、真测、真构建。本库 `stacks/` 中所有标 `实测` 的 TypeScript 类条目都来自它，抽取时锁定 commit `8565902dfdd3d1d2530a46f8051cd038bfba7d04`。

### prodcheck（上线前检查，可直接 MCP 调用）

https://github.com/FarzamHabibi/pre-production-checklist

4,685 条 / 101 个 checklist / 6 个域的上线前检查清单（安全、性能、规模、集成、上线后、人员）。本库借鉴了它的仓库结构（分文件 + 脚本拼总）和「按栈过滤」的思路。

**它自带 MCP server，可以直接调，不用扒内容：**

```json
{
  "mcpServers": {
    "prodcheck": {
      "command": "npx",
      "args": ["-y", "--package=prodcheck", "prodcheck-mcp"]
    }
  }
}
```

CLI 用法（按技术栈出检查项）：

```bash
npx prodcheck security --stack django -o SECURITY.md
npx prodcheck performance --stack nextjs -o PERF.md
```

**分工**：prodcheck 管"上线前的工程安全/性能"；本库 `checklists/` 管"用户会不会骂娘的功能验收"。两者不重叠。

## 当前状态

| 半边 | 状态 |
|---|---|
| `stacks/` web-frontend | 已填（VibeStart 实测 5 条） |
| `stacks/` desktop | 已填 Tauri / Electron / SwiftUI / AppKit，其余待填 |
| `stacks/` web-backend / mobile / embedded / database / ai-ml | 部分待填 |
| `checklists/` 全部品类 | 待填（尚未攒出第一批） |
