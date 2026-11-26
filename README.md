# Software Wiki

一个供人和 AI 共同使用的软件开发知识库。它把"容易被遗漏的要点"预先写下来——例如修改原文件时忘记同步备份——让 AI 在制定计划和验收时能照着核对，而不是只处理它已经知道的内容。

## 它能做什么

- **技术选型**：查某类项目适合用什么技术、有哪些已知问题、哪些组合经过实测验证。
- **功能验收**：查某类软件应当具备哪些功能，逐条确认做没做全。

使用时把相关条目交给 AI 作为输入，使原本不会出现在其计划中的要点进入计划；完成后再用同一份条目逐条验收。

## 收录内容

库分两个部分，各按主题分文件：

**`stacks/` 技术选型库**

- [web-frontend.md](stacks/web-frontend.md) —— TypeScript 全栈技术选型，取自 VibeStart，含各层级可选项、明确不覆盖的平台、已知问题与 CI 实测依据。

**`checklists/` 品类功能清单**

- [app-store-compliance.md](checklists/app-store-compliance.md) —— 应用上架合规清单，124 条，覆盖 Apple App Store、Google Play 与 Web，每条附官方条款出处。

## 使用示例

要开发一个准备上架的应用：打开 `checklists/app-store-compliance.md`，在规划和提交前逐条核对，命中问题的按条目给出的"修法"处理，每条的"出处"可回溯到官方条款。

做 TypeScript 全栈项目时：参考 `stacks/web-frontend.md`，先看"不覆盖"一节确认技术边界，再避开已知问题一节列出的内容。

## 参与维护

新增或修订条目前请先阅读对应目录的字段规范：

- `stacks/_SCHEMA.md` —— 技术选型库的字段定义与填写规则
- `checklists/_SCHEMA.md` —— 品类功能清单的字段定义与验收项标准

## 来源与致谢

本库的知识条目整理自以下开源项目。此表同时作为来源台账：记录每个条目取自哪里、锁定在哪个版本，上游更新时可据此核对并同步。

| 来源 | 用途 | 许可 | 锁定版本 | 上游地址 |
|---|---|---|---|---|
| VibeStart（作者 Vinky） | `stacks/web-frontend.md` 的技术选型事实与实测依据 | MIT | commit `8565902d`（2026-11-23） | https://github.com/VinkyDev/vibestart |
| app-store-compliance（作者 mjmirza） | `checklists/app-store-compliance.md` 的 124 条规则事实（中文重写，非原文复制） | 原项目 ORA 2.3；本库为独立重述 | commit `6257b0fd`（2026-11-25） | https://github.com/mjmirza/app-store-compliance |
| awesome-design-md（作者 VoltAgent） | 待评估来源：评估后未采用，当前无内容取自该项目。保留记录以便跟进其更新，日后若决定采用再据此同步 | MIT | commit `fcc70284`（2026-10-28） | https://github.com/VoltAgent/awesome-design-md |

VibeStart 官网：https://vibestart.net —— "3489 种组合全部通过完整验证"。相关验证由其作者完成，本库仅作抽取和转述。
