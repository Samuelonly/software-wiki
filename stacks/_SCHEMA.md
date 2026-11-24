# stacks/ 字段格式定义

每个技术块一个文件（如 `web-frontend.md`），文件内每一条技术栈一个条目。

## 条目格式

```markdown
## [技术栈名称]（如 Tauri）

**验证状态**：`实测` / `文档`

**fit**：适合什么场景，一句话。

**gotchas**（每条都必须能转成下面的 derived_checks，转不出来的不收）：
- 高版本 API 未做降级，在老系统直接崩
- fs 权限 scope 没收窄，等于开了全盘

**derived_checks**（每条必须能跑出绿/红，落不成命令的坑不收）：
- [ ] 编译零警告 → `cargo clippy -D warnings`
- [ ] fs scope 只含用户选定目录 → 校验权限配置只白名单目标目录
- [ ] 最低支持版本实机启动成功 → 在最低版本跑启动 → 打开文件 → 核心流程 → 退出

**来源**：
- [官方文档](https://example.com)（commit / 版本号）
```

## 核心规则：坑必须能变成机器能跑的检查

**这是本库最重要的一条。**

写坑的时候只问一句：**这条坑，能不能变成一个跑得出绿勾/红叉的检查？**

- 能 → 写进 `gotchas`，并在 `derived_checks` 里给出可执行的判定方式
- 不能 → 不进库。它要么还没想清楚，要么是废话

为什么这么严：Commander 的用户是不懂代码的人。他不读代码、不读文档，他只看得懂"18 绿 2 红"。**红叉时他做决策（换栈 / 接受风险 / 让 AI 再试一轮），而不是去读源码。**

所以 `derived_checks` 里的每条，必须满足：

1. **能跑出布尔值**——命令退出码、测试通过与否、配置项存在与否、字符串是否匹配
2. **外行能看懂描述**——描述那半是人话，命令那半是给机器和 AI 看的
3. **不含"要专家判断"**——出现"评估一下""看看合不合理"这类，说明这条还没想清楚

## AI 时代的判据

写坑时，**不写"团队有没有人会 X"，写"AI 会不会在这里打转 + 能不能机器验出来"**。

| 废掉的旧判据 | 现在的判据 |
|---|---|
| 团队有没有会 Rust 的人 | AI 写出来能过 clippy 吗？报错时 AI 会不会改三轮还在原地？ |
| 招不招得到 Qt 工程师 | AI 生成的 Qt 代码，出问题时有没有机器信号能定位？ |
| 团队维护不维护得动 C++ | 内存泄漏、未定义行为有没有 sanitizer 能兜？ |

**AI 时代编码成本降了，排查成本没降。** 坑的价值从"人够不够"转移到"机器能不能验"。

## 验证状态取值

| 值 | 含义 | 铁律 |
|---|---|---|
| `实测` | 组合被某来源在 CI 里真装、真测、真构建过 | 必须附 verification 记录链接或 fingerprint，空口无凭一律标 `文档` |
| `文档` | 只是官方文档或横评文章这么写 | 必须附来源链接，别冒充 `实测` |

## 铁律

1. 找不到实测来源就标 `文档`，**别冒充 `实测`**。
2. **落不成可执行检查的坑，不收。**
3. **不许写"需要专家审"——要写"用什么命令验"。**
4. 先有字段格式，再填第二条；不按格式的条目不收。
5. 一个技术块一个文件，别把不同平台/语言混进一条。
6. 来源锁 commit，不跟上游漂移。
7. 每条写人话，不说术语。

## 举一反三：各类技术块的 derived_checks 长什么样

同一条逻辑——**坑 → 机器可验**——在每个技术块都适用，只是命令不同：

| 技术块 | gotcha 例子 | derived_check 例子 |
|---|---|---|
| `web-frontend` | 首屏慢、图片没压缩 | Lighthouse 性能分 ≥ 80 → `lighthouse --only-categories=performance` |
| `web-frontend` | 色盲用户点不到按钮 | 无 a11y 违规 → `axe-core` 零 critical |
| `web-backend` | 出错时把堆栈吐给用户 | 错误响应不含 `stack` / `trace` → 打一遍错误接口抓响应体 |
| `web-backend` | 数据库连接被打爆 | 连接池上限已配 → 校验配置项 + 压测不超限 |
| `desktop` | 高版本 API 未降级 | 静态扫描无未包 `#available` 的调用 |
| `desktop` | App Store 版没开沙箱 | `codesign -d --entitlements :-` 含 `app-sandbox=true` |
| `desktop` | 直接分发版被 Gatekeeper 拦 | `spctl -a -vv` + `xcrun stapler validate` 通过 |
| `desktop` | 老系统启动崩 | 最低支持版本实机跑通启动 |
| `mobile` | 权限被拒后白屏 | 拒绝相机/通知权限后不崩不白屏 |
| `mobile` | 应用商店隐私清单缺失 | `PrivacyInfo.xcprivacy` 存在且字段完整 |
| `mobile` | 新 Android 版本装不上 | `targetSdk` 达到上架最低要求 |
| `database` | 迁移失败无法回滚 | 迁移脚本可 down → 跑 up 再 down 回原状 |
| `database` | 备份恢复不回来 | 备份 → 重建 → 恢复 → 数据一致 |
| `embedded` | 固件超出 flash | 产物大小 < flash 容量 → 编译后读 size |
| `embedded` | 断电后不恢复 | 断复位测试 → 状态一致 |
| `ai-ml` | 显存峰值超限 | 推理显存峰值 < 卡上限 → 跑一遍读峰值 |
| `ai-ml` | 断网直接崩 | 断网后降级而不是崩溃 |

**注意这张表里没有一条是"XX 需要专家"。全是命令、判定、阈值。**

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
| `ai-ml.md` | PyTorch / TensorFlow / ONNX / llama.cpp |

**不收游戏引擎**：游戏涉及引擎授权费、后台权限分级、省电与硬件优化，超出「software / application」的 scope。
