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
