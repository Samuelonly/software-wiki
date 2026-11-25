---
category: app-store-compliance
version: V1
updated: 2026-11-25
items: 124
status: 草稿
reviewers: []
---

# 应用上架合规清单（Apple App Store / Google Play / Web）

## 这是什么

一份"提交前会被拒在哪"的检查单。跟本库其他清单的视角不同：

- 其他清单检查的是"用户使用时会遇到哪些问题"（功能完整性）
- 本清单检查的是"提交审核是否会被拒、上线后是否会被下架"（应用商店合规与法规）

两者都属于"交付前应检查什么"，并列收录于 `checklists/`，需标明各自视角，不得混用。

## 怎么用

提交商店前逐条过一遍：这条我们踩了吗？踩了就按"修法"改。每条的"出处"指向官方条款或法规，可核查。

## 事实来源

规则事实整理自公开项目 mjmirza/app-store-compliance（数据版本 2.5.1，更新于 2026-11-21），本文件用中文重新表述，不是原文复制。每条的官方条款/日期保留，方便核对。官方出处入口：

- Apple 审核指南：https://developer.apple.com/app-store/review/guidelines/
- Apple 审核说明：https://developer.apple.com/app-store/review/
- Google Play 内容政策：https://play.google/developer-content-policy/
- Google Play 开发者政策：https://support.google.com/googleplay/android-developer/answer/9899234

`验证状态`：全部标 `文档`（规则来自官方指南和法规，不是我们拿真项目实测过的）。级别：**致命**=直接拒或封号，**高**=高频拒因，**中**=中风险。

---

## 一、Apple App Store（62 条）

### 内容与安全

- [ ] **有用户生成内容却没有内容审核机制**（APPLE-1.2-UGC-24H-ACTION · 致命）
  - 验法：有 UGC 就必须有内容过滤、举报入口并及时处理、能拉黑骚扰者、公开联系方式；留意 1.2 已点名社交/UGC/AI 生成类 App 和非自愿亲密影像，反复违规可立即下架并清退开发者。
  - 修法：补零容忍 EULA、过滤、应用内举报、拉黑、公开联系方式，并对苹果的通知及时处置。
  - 出处：Apple 1.2

- [ ] **中国区出现外部 AI 服务字样**（CHINA-AI-REFERENCES · 致命）
  - 验法：在中国区分发的应用里提到 ChatGPT、Gemini、OpenAI 等外部 AI 服务，可能触发地区性拒绝。
  - 修法：中国区移除或本地化这些外部 AI 服务引用。
  - 出处：Apple 5

- [ ] **用了隐藏、休眠或未说明的功能，审核后变卦**（APPLE-2.5.19-HIDDEN-OR-DORMANT-FEATURE · 致命）
  - 验法：二进制里带着审核看不到的功能——审核通过后靠服务器开关切换成另一个 App、暗藏手势或菜单、用混淆藏功能。2026-10-16 新增的 2.5.19 专门针对"挂羊头卖狗肉"。注意：单纯有远程开关不算违规。
  - 修法：所有功能都让审核看得到、写进审核说明；远程配置只用于调参和已审功能的灰度；绝不混淆代码藏功能。
  - 出处：Apple 2.5.19

- [ ] **助长人口贩运或儿童剥削的应用**（APPLE-5-TRAFFICKING-CHILD-EXPLOITATION · 致命）
  - 验法：市场、分类信息、陪护/陪见、匿名联系，以及任何成年人能接触未成年人的场景，2026-10-16 起法律条款明确规定会被上报当局、下架并禁止其他分发。
  - 修法：审核信息和消息中的贩运/剥削信号，成人可接触未成年人的地方做年龄核验，按美国法律向 NCMEC 上报 CSAM。
  - 出处：Apple 5

- [ ] **创作素材带价格、无法证实的宣称或误导引用**（APPLE-2.3.14-CREATIVE-ASSET-CONTENT · 高）
  - 验法：产品页头部图或搜索结果图（2026-10-16 新增的 2.3.14）出现具体/折扣价、无法核实的宣称、误导性的他家 App 引用、不适合全年龄的内容、与内容功能品牌无关的图。人工查，在 App Store Connect 里。
  - 修法：素材只讲本 App 和品牌，全年龄适宜，不写价格、折扣、排名、无法证实的宣称，不提别家 App。
  - 出处：Apple 2.3.14

### 提交流程与元数据

- [ ] **iCloud/CloudKit 结构没部署到生产**（APPLE-2.1-CLOUD-NOT-IN-PRODUCTION · 致命）
  - 验法：用了 CloudKit/iCloud 但结构和容器只在开发环境，审核员跑生产包时功能直接失效。
  - 修法：提交前把 CloudKit 结构和容器部署到生产。
  - 出处：Apple 2.1

- [ ] **生产包里留着调试/测试功能**（APPLE-2.1-DEBUG-FEATURES · 致命）
  - 验法：发布版里还能看到调试菜单、测试登录、开发者后门，没用编译开关藏起来。
  - 修法：用仅 debug 生效的编译标记隔离，确保绝不进生产包。
  - 出处：Apple 2.1

- [ ] **需要登录却没给演示账号**（APPLE-2.1-MISSING-DEMO-ACCOUNT · 致命）
  - 验法：有登录/鉴权代码（Sign in with Apple、OAuth、登录页），但审核备注或 fastlane review_information 里没有可用演示账号。
  - 修法：在"审核备注"里放一个能用的演示账号和实测路径。
  - 出处：Apple 2.1

- [ ] **包里还留着占位内容**（APPLE-2.1-PLACEHOLDER-CONTENT · 高）
  - 验法：发布资源里搜得到 lorem ipsum、TODO、FIXME、placeholder、dummy、test data、example.com。
  - 修法：提交前把占位文字和素材全换成真实内容。
  - 出处：Apple 2.1

- [ ] **审核备注缺必填项**（APPLE-2.1-REVIEW-NOTES-INCOMPLETE · 高）
  - 验法：新提交的审核备注少了六项之一——真机录屏、App 用途、进入方式和测试账号、外部服务清单、地区差异、受监管行业材料。
  - 修法：按六项模板把审核备注填全。
  - 出处：Apple 2.1

- [ ] **后端指向 staging 或 localhost**（APPLE-2.1-STAGING-BACKEND · 致命）
  - 验法：发布配置的 API 地址里含 localhost、127.0.0.1、staging、dev、ngrok。
  - 修法：发布包指向正式生产后端，并确认审核期间不宕机。
  - 出处：Apple 2.1

- [ ] **没答 2026 新版年龄分级问卷**（APPLE-2.3-AGE-RATING-2026 · 高）
  - 验法：人工核对。2026-01-31 前必须答完新的年龄分级问题（13+/16+/18+）才能提交更新。
  - 修法：在 App Store Connect 里为每个 App 答完。
  - 出处：Apple 2.3.6

- [ ] **文案里提到其他平台或市场**（APPLE-2.3-CROSS-PLATFORM-REFERENCE · 高）
  - 验法：面向用户的文案或元数据里出现 Android、Google Play 或其他应用市场名。
  - 修法：从 App 和元数据里去掉其他平台、市场的引用。
  - 出处：Apple 2.3.10

- [ ] **元数据承诺了这版没有的功能**（APPLE-2.3-FUTURE-FUNCTIONALITY · 高）
  - 验法：商店介绍或应用内文案写了"即将推出"、beta，或承诺了这版根本没有的功能。
  - 修法：只描述这版实际能做的，去掉未来功能承诺。
  - 出处：Apple 2.3.1

- [ ] **元数据说苹果坏话或提 iOS bug**（APPLE-2.3-NEGATIVE-APPLE-SENTIMENT · 中）
  - 验法：商店文案提到 iOS 的 bug，或对苹果有负面、不恰当的引用。
  - 修法：从文案里去掉对苹果和 iOS bug 的负面引用。
  - 出处：Apple 2.3.1

- [ ] **预览视频套了设备边框**（APPLE-2.3.4-DEVICE-FRAMES-PREVIEW · 高）
  - 验法：人工查元数据。预览视频把 App 套在设备边框里，而不是全屏展示。
  - 修法：从设备全屏录制，不要设备边框叠加。
  - 出处：Apple 2.3.4

- [ ] **声明了能力权却没用到**（APPLE-2.4.5-UNUSED-ENTITLEMENTS · 高）
  - 验法：entitlements 文件声明了 App 并不用的能力，苹果会要求说明，说不清就卡审核；临时例外权会被额外盯。
  - 修法：删掉没实际使用的每个 entitlement，逐项和真实代码核对。
  - 出处：Apple 2.4.5(i)

- [ ] **用了外购支付而不是内购**（APPLE-3.1.1-EXTERNAL-PAYMENT · 致命）
  - 验法：数字内容走网页结账或第三方支付 SDK，而不是 StoreKit，且不属于明文豁免品类。
  - 修法：数字商品一律走 StoreKit 内购，除非属有记录的豁免品类。
  - 出处：Apple 3.1.1

- [ ] **订阅价格把"每月"写得比实付金额显眼**（APPLE-3.1.2-MISLEADING-PRICING · 高）
  - 验法：人工看付费页。年订阅把每月折算价放得很大、实际扣款总额放得很小。
  - 修法：用户实际被扣的金额，至少和任何"每月"数字一样显眼。
  - 出处：Apple 3.1.2

- [ ] **预览里出现苹果设备图或商标**（APPLE-5.2.5-APPLE-DEVICE-IMAGE · 高）
  - 验法：人工查元数据。图标或截图出现苹果设备、苹果 logo，或暗示苹果背书。
  - 修法：从图标和截图里去掉苹果设备图和苹果标识。
  - 出处：Apple 5.2.5

- [ ] **社交能力没提前申报**（APPLE-2.3.6-SOCIAL-MEDIA-DECLARATION · 高）
  - 验法：2026-09 起每个新版本/更新、以及替代市场的每次公证，都要回答是否含社交能力。有信息流、关注、聊天室、私信、直播却没答，无法提交。申报社交会进"社交时间额度"类、最低 13+，服务 13 岁以下还需 Declared Age Range API。
  - 修法：在 App Store Connect（或 API 的 socialMedia / socialMediaAgeRestricted）回答该问题，接受 13+ 下限，需要低龄用户就接入年龄声明 API。
  - 出处：Apple 2.3.6（Apple 开发者新闻 0d2gpmml，2026-06-08）

- [ ] **外部购买链接对所有地区都显示**（APPLE-3.1.1-EXTERNAL-LINK-REGION-GATING · 致命）
  - 验法：外部购买链接/按钮/CTA 发到了所有地区。免权限的例外只适用于美国区；同样的 UI 在日本、加拿大、澳洲、英国等多数地区仍是 3.1.1 违规，审核按地区判定。2026-10-16 起音乐流媒体权限并入该条款，链接必须指向允许的目的地（因地区而异）。
  - 修法：按当前商店地区（StoreKit Storefront.current / countryCode）控制外部链接的显示，只在有权限或适用美国例外时展示；美国以外走权限路径和披露页。
  - 出处：Apple 3.1.1 / 3.1.3，仅美国区例外

- [ ] **实时活动用来发促销或骚扰消息**（APPLE-4.5.3-LIVE-ACTIVITY-SPAM · 高）
  - 验法：4.5.3 已把 Live Activities 和 Game Center、推送并列为不得用来刷屏、钓鱼、发未经请求消息的界面。带营销、加购或与进行中活动无关内容的实时活动会被拒。
  - 修法：每个实时活动都绑定真实、用户发起、有时限的活动；灵动岛和锁屏不放促销、诱导互动或无关内容。
  - 出处：Apple 4.5.3（2026-06-08 修订）

- [ ] **还在用按需资源（On-Demand Resources）**（APPLE-ODR-DEPRECATED-27 · 中）
  - 验法：苹果从 iOS/iPadOS/tvOS/visionOS 27 起弃用 ODR，靠 NSBundleResourceRequest 标签的 App 会失去下载通道。2027 年初起 App Store Connect 不再接收含 ODR 的新 App 或从未用过该功能的 App 的上传。
  - 修法：在 iOS 27 成为提交下限前，把带标签的资源迁到 Background Assets。
  - 出处：WWDC26 App Store 指南，ODR 弃用

- [ ] **CI 还在调已删除的年龄分级接口**（APPLE-ASCAPI-AGERATING-ENDPOINT-REMOVED · 高）
  - 验法：App Store Connect API 删掉了 GET /v1/appStoreVersions/{id}/relationships/ageRatingDeclaration 和 GET /v1/appStoreVersions/{id}/ageRatingDeclaration，fastlane/脚本/CI 还在调就会失败、发布流水线停摆。替代接口还带新的 socialMedia、socialMediaAgeRestricted 字段。
  - 修法：改用现行的年龄分级读取/更新接口，有社交功能的把两个字段设好；下个版本前用 TestFlight 包跑一遍流水线。
  - 出处：App Store Connect API 4.3 / 4.4 发布说明

- [ ] **纯 Intel 的 macOS 包，Rosetta 将终止**（APPLE-MACOS-ROSETTA-SUNSET · 高）
  - 验法：人工查构建架构和纯 x86_64 依赖。苹果两份通知不一致——9/1 说 macOS 27 是最后支持 Rosetta 的版本，9/9 说 macOS 26 是最后支持 Intel Mac 和 Rosetta 的版本。按更早的读法准备。
  - 修法：出通用版或 arm64 包，替换纯 x86_64 依赖，在没有 Rosetta 的 Apple 芯片机上测试。
  - 出处：Apple 开发者新闻 w5ngl9k2 / k1mtkt1k（2026-09）

- [ ] **账号还没生效就计划上线**（APPLE-ENROLLMENT-VERIFICATION-PENDING · 致命）
  - 验法：这不是审核拒绝，是审核之前的发布阻断。开发者反馈付款后注册卡在 Pending 两到六周、身份验证上传链接报访问错误、支持数周不回、个人转组织迁移开了 61 天。假设账号第一天就生效的排期会滑好几周。人工查会员状态、协议接受状态、未完成的迁移。
  - 修法：至少提前六周注册并完成身份验证，备好证件，接受每一份 ADPLA 更新和附件（附件12巴西 7/6 前、附件14欧盟 10/1 前），个人转组织提前一个季度启动；记下工单号并用支持电话升级。
  - 出处：Apple 开发者论坛 817247 等（2026 年 1–9 月）

### 权限、隐私与数据

- [ ] **缺隐私政策**（APPLE-5.1.1-MISSING-PRIVACY-POLICY · 致命）
  - 验法：App Store Connect 元数据里没有隐私政策 URL，代码里也没有应用内隐私链接。
  - 修法：发布隐私政策，在 App Store Connect 里链接，并让应用内能点开。
  - 出处：Apple 5.1.1(i)

- [ ] **用了敏感框架却没写用途说明**（APPLE-5.1.1-MISSING-USAGE-DESCRIPTION · 致命）
  - 验法：代码引用了敏感框架/API，但 Info.plist 里缺对应的 NS…UsageDescription 键。
  - 修法：每个用到的敏感框架都补上用途说明键，写清楚具体理由。
  - 出处：Apple 5.1.1(ii)

- [ ] **能注册却不能在应用内删号**（APPLE-5.1.1-NO-ACCOUNT-DELETION · 致命）
  - 验法：有注册/建号代码，但找不到删除账号的流程。
  - 修法：任何支持建号的 App 都要提供应用内删号。
  - 出处：Apple 5.1.1(v)

- [ ] **删号只是一个 mailto 链接或"停用"**（APPLE-ACCOUNT-DELETION-WEAK · 致命）
  - 验法：唯一的删号途径是发邮件、要离开 App 去填网页表单，或"停用"但并不真删数据。
  - 修法：在应用内真正删除账号及其数据，不是停用、也不是外部表单。
  - 出处：Apple 5.1.1(v)

- [ ] **强制索要跟核心功能无关的个人资料**（APPLE-5.1.1-UNNECESSARY-DATA · 高）
  - 验法：注册或引导页强制要手机号、性别、婚姻状况、生日、家庭住址，但对核心功能并非必需（相关性视场景而定）。
  - 修法：非必需字段改为可选，只要求与核心功能直接相关的数据。
  - 出处：Apple 5.1.1

- [ ] **权限用途说明写成空话**（APPLE-5.1.1-VAGUE-PURPOSE-STRING · 高）
  - 验法：Info.plist 里的 NS…UsageDescription 是空的，或写着"需要访问""必需"这类笼统话。
  - 修法：写明真正用到这个权限的具体功能。
  - 出处：Apple 5.1.1(ii)

- [ ] **个人信息发给第三方 AI 却没有同意弹窗**（APPLE-5.1.2-AI-NO-CONSENT-MODAL · 致命）
  - 验法：接了第三方 AI/LLM SDK，个人信息可能外发，但没有点名该 AI 提供商的同意弹窗。
  - 修法：任何个人信息离开 App 前，弹出同意框写明 AI 提供商和数据类型。
  - 出处：Apple 5.1.2(i)

- [ ] **有追踪 SDK 却没做 ATT**（APPLE-5.1.2-MISSING-ATT · 致命）
  - 验法：有追踪/广告 SDK，但没调 ATTrackingManager 授权，也没有 NSUserTrackingUsageDescription。
  - 修法：任何跨 App 追踪前先弹 ATT，并补追踪用途说明。
  - 出处：Apple 5.1.2(i)

- [ ] **缺隐私清单（Privacy Manifest）**（APPLE-PRIVACY-MANIFEST-MISSING · 致命）
  - 验法：用了"需要说明原因"的 API 或常见第三方 SDK，却没有打包 PrivacyInfo.xcprivacy，或某 SDK 没带签名清单。苹果自 2024 起在上传时强制检查。
  - 修法：加 PrivacyInfo.xcprivacy，写明 NSPrivacyAccessedAPITypes 和批准的原因码、列出 NSPrivacyTrackingDomains，并确认每个 SDK 都带签名清单。
  - 出处：Privacy Manifest

- [ ] **Flutter 插件碰了需要说明的 API 却没清单**（FLUTTER-PRIVACY-MANIFEST-MISSING · 致命）
  - 验法：有 pubspec.yaml，依赖了会碰"需要说明原因"API 的插件（permission_handler、image_picker、geolocator、device_info_plus、package_info_plus、shared_preferences、sqflite、firebase_* 等），项目里却找不到 PrivacyInfo.xcprivacy。
  - 修法：加应用级 PrivacyInfo.xcprivacy，并确认每个 Flutter 插件也带自己的（Flutter 3.19+ 大多带）；插件级清单若缺失，除非应用级也声明了该插件的原因码，否则苹果看不到。
  - 出处：Apple 5.1.1

- [ ] **Capacitor/Cordova 插件包着原生 SDK 却没清单**（IONIC-PRIVACY-MANIFEST-MISSING · 致命）
  - 验法：有 Capacitor/Cordova 插件，项目里没有 PrivacyInfo.xcprivacy。Capacitor 的清单支持不如 Flutter 规范。
  - 修法：逐个确认包了原生 SDK 的插件（相机、定位、广告）带 PrivacyInfo.xcprivacy，并补应用级清单。
  - 出处：Apple 5.1.1

- [ ] **React Native 原生模块碰了需说明 API 却没清单**（RN-PRIVACY-MANIFEST-MISSING · 致命）
  - 验法：package.json 依赖 react-native/expo，有会碰"需要说明原因"API 的原生模块（Firebase、AsyncStorage、expo-file-system），却没有 PrivacyInfo.xcprivacy。
  - 修法：加应用级清单；通过 JS 依赖间接打进来的原生模块，各自也要带清单并汇总进最终 IPA。
  - 出处：Apple 5.1.1

- [ ] **隐私营养标签没报数据类型**（APPLE-PRIVACY-NUTRITION-LABELS · 致命）
  - 验法：收集邮件、电话、姓名、坐标等敏感数据，却没做 privacyNutritionLabels 声明或对应的披露引用。
  - 修法：在 PrivacyInfo.xcprivacy 里写 NSPrivacyCollectedDataTypes，并在 App Store Connect 填完对应的营养标签。
  - 出处：Apple 5.1.1

- [ ] **健康数据可能进了 iCloud**（APPLE-5.1.3-HEALTH-DATA-ICLOUD · 致命）
  - 验法：5.1.3(ii) 禁止把个人健康信息存进 iCloud。App 读了 HealthKit 又写 CloudKit / NSUbiquitousKeyValueStore / NSPersistentCloudKitContainer，就要确认没有健康数据走这条路。
  - 修法：健康数据留在设备或自己掌控的后端，从任何 CloudKit/iCloud 键值同步里排除。
  - 出处：Apple 5.1.3(ii)

- [ ] **未申报社交后又没处理撤回同意**（APPLE-5.1.1-RESCIND-CONSENT-UNHANDLED · 致命）
  - 验法：App 读了 Declared Age Range，却从不处理 RESCIND_CONSENT 通知。家长撤回同意后苹果会禁止 App 启动，而服务端基于该同意的未成年人数据或权限还活着。
  - 修法：订阅 App Store Server 通知，收到 RESCIND_CONSENT 就注销未成年会话、删除该同意范围内的数据；用 Xcode 26.2（17C52）或更高、iOS 26.2 SDK 构建（苹果对所有年龄保证技术要求）。
  - 出处：Apple 5.1.1 与年龄保证框架

- [ ] **用 Sign in with Apple 却要用户再填姓名邮箱**（APPLE-4.0-SIWA-UX · 高）
  - 验法：苹果凭证已经给了姓名邮箱还要再问、按钮不是标准样式、把 SIWA 藏在其他社交登录下面、拒绝私有中继邮箱。
  - 修法：直接用苹果凭证里的姓名邮箱，别再问；用标准按钮；SIWA 至少和其他登录一样显眼；接受私有中继邮箱。
  - 出处：Apple 4.0

- [ ] **只给第三方社交登录，没有等价替代**（APPLE-4.8-SOCIAL-LOGIN-ONLY · 致命）
  - 验法：只有 Facebook/Google 等社交登录，没有 Sign in with Apple 或同等的隐私保护选项。
  - 修法：加 Sign in with Apple，或一个只收姓名邮箱、允许私有邮箱的等价登录。
  - 出处：Apple 4.8

- [ ] **隐藏邮箱中继域名被邮箱校验拒掉**（APPLE-4.0-SIWA-RELAY-DOMAIN · 高）
  - 验法：账号系统、邮箱校验或白名单只认 privaterelay.appleid.com。苹果现在也会发 private.icloud.com 的隐藏邮箱，导致新域名注册静默失败，按 4.0/4.8 以 SIWA 流程损坏被拒。
  - 修法：所有校验、白名单、匹配邮箱的地方（服务端和客户端）同时接受 privaterelay.appleid.com 和 private.icloud.com。
  - 出处：Apple 4.0（Apple 开发者新闻 1ptvdtcm，2026-06-15，08-24 更正）

- [ ] **权限弹窗前自己做了个写着"允许"的诱导页**（APPLE-5.1.1-PRE-PROMPT-ALLOW-BUTTON · 高）
  - 验法：预提示页上有"允许"或"允许+名词"的按钮（SwiftUI Button、UIKit setTitle、React Native Button），同一文件里又在申请权限。苹果人机指南认为自定义页面借快速点击影响用户选择会导致拒绝。注意：自动检测只看同文件证据，跨文件的权限申请和用单独 Text 做标签的 SwiftUI 按钮看不到；预提示页上的"关闭/取消"、利益诱导、系统弹窗截图也算问题。
  - 修法：预提示页只留一个"继续/下一步"按钮打开系统弹窗，不放诱导、不放系统弹窗图；除非该页还收集法律要求的同意，否则不放"关闭/取消"；尽量提供不用该权限也能用 App 的方式。
  - 出处：Apple 5.1.1(iv)

- [ ] **缺加密声明让包卡在 Missing Compliance**（APPLE-EXPORT-COMPLIANCE-MISSING · 高）
  - 验法：Info.plist 没设 ITSAppUsesNonExemptEncryption，每次提交都卡在 Missing Compliance，根本到不了审核。
  - 修法：设上该键。只用标准 HTTPS 的 App 可填豁免答案。
  - 出处：Export compliance

- [ ] **巴西区赌博 App 没有赌牌牌照**（APPLE-GAMBLING-BRAZIL-LICENSE · 致命）
  - 验法：在巴西区分发、有赌博/投注功能，却在 App Review Information 里没有有效的固定赔率投注牌照（SPA 颁发）。
  - 修法：年龄问卷的赌博问题选"是"（巴西自动定为 A18），在审核信息里放有效牌照，并提交新版本启动核验——只改审核信息不会触发核验。
  - 出处：Apple 3.1.1（Apple 开发者新闻 x4eyetnp，2026-05-08）

### 功能与购买

- [ ] **纯网页套壳没有附加价值**（APPLE-4.2-WEB-WRAPPER · 致命）
  - 验法：App 基本是一个 webview 加载网站，几乎没有原生代码。
  - 修法：加原生能力、离线价值、设备集成或网页版没有的内容。
  - 出处：Apple 4.2

- [ ] **Ionic 套壳原生功能太少**（IONIC-4.2-THIN-WRAPPER · 致命）
  - 验法：有 Capacitor/Cordova/WKWebView 标记，但少于 2 个有原生感的插件（状态栏、启动屏、推送、触感、分享、相机、本地通知）。这是 4.2 的启发式判断，当拒绝依据前要人工确认。Apple 4.2 最低功能是 Ionic 最常见的拒因。
  - 修法：补状态栏、启动过渡、推送、触感等原生插件；或者做成可安装的 PWA 跳过审核。
  - 出处：Apple 4.2

- [ ] **静态链了已弃用的 UIWebView**（IONIC-UIWEBVIEW-DEPRECATED · 致命）
  - 验法：构建源码里出现 UIWebView 字样，通常是过时的 Capacitor/Cordova 插件间接带进来的。苹果会以 ITMS-90809 自动拒绝。
  - 修法：把所有插件升到基于 WKWebView 的版本。
  - 出处：Apple 2.5.1

- [ ] **用了私有 API 或已弃用框架**（APPLE-2.5.1-PRIVATE-API · 致命）
  - 验法：二进制或代码里出现已知私有 API 的选择器，或引用了已弃用框架。
  - 修法：只用有文档的公开 API 和现行框架。
  - 出处：Apple 2.5.1

- [ ] **热更新 JS 没申报**（RN-OTA-UNDECLARED · 致命）
  - 验法：package.json 依赖 react-native/expo，又有 OTA 更新器（code-push、expo-updates、react-native-ota-hot-update、Stallion），审核说明里没讲它只用于修 bug。2026-10-16 起未申报、审核后加功能的更新路径属于 2.5.19 的"挂羊头卖狗肉"。
  - 修法：在审核备注里写明 OTA 机制，限制为不改用途、UI、功能的修 bug；审核后靠 OTA 加功能就是 bait-and-switch。
  - 出处：Apple 3.3.2 / 2.5.19

- [ ] **非消耗型购买没有"恢复购买"按钮**（APPLE-RESTORE-PURCHASES-MISSING · 致命）
  - 验法：有 StoreKit 购买，但找不到恢复路径。
  - 修法：加可见的"恢复购买"控件。非消耗品和非续订订阅必须有。
  - 出处：Apple 3.1.1

### 无障碍

- [ ] **不考虑深色/浅色和高对比度**（APPLE-ACCESSIBILITY-COLORCONTRAST · 中）
  - 验法：用硬编码自定义颜色，不支持深浅模式、高对比度，也不检查 isDarkerSystemColorsEnabled。
  - 修法：用能自动适配的动态/系统颜色，或监听高对比度状态动态调整。
  - 出处：Apple Design - Accessibility

- [ ] **不支持动态字体**（APPLE-ACCESSIBILITY-DYNAMICTYPE · 中）
  - 验法：硬编码字号/样式，没配缩放或 preferredFont API，或把 adjustsFontForContentSizeCategory 设成 false。
  - 修法：UIKit 用 preferredFont(forTextStyle:)、SwiftUI 用系统/相对字体样式，并开启 adjustsFontForContentSizeCategory。
  - 出处：Apple Design - Accessibility

- [ ] **交互没有触感反馈**（APPLE-ACCESSIBILITY-HAPTICS · 中）
  - 验法：交互元素、按钮、自定义控件没有反馈生成器或 CoreHaptics 调用。
  - 修法：给按钮、开关、滑动加触感反馈（UIImpactFeedbackGenerator 或选择反馈）。
  - 出处：Apple Design - Accessibility

- [ ] **不支持键盘导航和焦点状态**（APPLE-ACCESSIBILITY-KEYBOARD · 中）
  - 验法：自定义文本编辑器或复杂导航流程没有 keyCommands、focusState 或可聚焦修饰。
  - 修法：UIKit 用 keyCommands、SwiftUI 用 focusable() 和 @FocusState 支持物理键盘导航。
  - 出处：Apple Design - Accessibility

- [ ] **忽略"减少动态效果"设置**（APPLE-ACCESSIBILITY-REDUCEMOTION · 中）
  - 验法：自定义动画/转场不检查 UIAccessibility.isReduceMotionEnabled 或 accessibilityReduceMotion。
  - 修法：检查该设置，用户要求时关闭或简化非必要动画。
  - 出处：Apple Design - Accessibility

- [ ] **VoiceOver 支持缺失或不全**（APPLE-ACCESSIBILITY-VOICEOVER · 中）
  - 验法：交互视图或图片没有 accessibilityLabel、accessibilityIdentifier、isAccessibilityElement 或 accessibilityElement(children:)。
  - 修法：给所有交互组件和有意义/装饰性图片设正确的标签、提示和特征。
  - 出处：Apple Design - Accessibility

### 其他

- [ ] **最低部署版本低于 iOS 13**（APPLE-MIN-DEPLOYMENT-TARGET-IOS13 · 高）
  - 验法：上传到 App Store Connect 的 iOS/iPadOS App 必须以 iOS 13 或更高为目标。IPHONEOS_DEPLOYMENT_TARGET 或 Podfile platform 低于 13 会在上传时被拒。注意：某个依赖或测试目标低于 13 不会单独阻断上传，所以这条报"高"而非阻断。
  - 修法：项目、App target 和 Podfile 里的部署版本都提到 13.0 以上。
  - 出处：App Store Connect 上传要求（Upcoming Requirements）

- [ ] **只支持 IPv4，在 IPv6-only 审核网络里跑不起来**（APPLE-2.5.5-IPV4-ONLY-NETWORKING · 致命）
  - 验法：App Review 在 IPv6-only NAT64 网络测试。用 inet_addr、inet_aton、gethostbyname 解析或连接的代码在 IPv4 下正常、审核时失败，看起来像坏了（2.5.5 要求 App 在纯 IPv6 网络完整可用）。
  - 修法：改用 getaddrinfo、Network.framework 或 URLSession，避免硬编码 IPv4 字面量；用 Mac 互联网共享建 NAT64 网络测试。
  - 出处：Apple 2.5.5

---

## 二、Google Play（43 条）

### 权限与 API

- [ ] **字体用 dp 导致系统字体缩放失效**（ANDROID-ACCESSIBILITY-FONTSCALING · 中）
  - 验法：Android XML 或 Jetpack Compose 里把字号硬编码成 dp 而不是 sp。
  - 修法：字号一律用 sp（缩放无关像素），让系统字体缩放生效。
  - 出处：Google 用户体验 - 无障碍

- [ ] **硬编码颜色，无视高对比度**（ANDROID-ACCESSIBILITY-HIGHCONTRAST · 中）
  - 验法：布局文件里写死十六进制颜色，或 Compose 里写死 Color 对象，不用主题属性。
  - 修法：引用语义颜色或颜色资源，让 App 自动遵循高对比度主题。
  - 出处：Google 用户体验 - 无障碍

- [ ] **触摸目标小于 48dp**（ANDROID-ACCESSIBILITY-SCANNER · 中）
  - 验法：可点元素或按钮的 layout_width/height/padding 导致触摸区小于 48dp。
  - 修法：用 padding、minWidth、minHeight 保证所有交互元素至少 48dp×48dp。
  - 出处：Google 用户体验 - 无障碍

- [ ] **没支持 TalkBack**（ANDROID-ACCESSIBILITY-TALKBACK · 中）
  - 验法：视图或图形组件缺 contentDescription，或 importantForAccessibility 设置不当。
  - 修法：给所有有信息量的图片和交互视图写有意义的 contentDescription，并正确设置 importantForAccessibility。
  - 出处：Google 用户体验 - 无障碍

- [ ] **敏感运行时权限没做校验**（ANDROID-RUNTIME-PERMISSIONS · 高）
  - 验法：申请相机、通讯录、存储等关键权限时，没有运行时动态检查，也没向用户说明白。
  - 修法：运行时动态检查权限，被拒后给出清楚理由，并优雅处理拒绝。
  - 出处：Google Permissions and APIs

- [ ] **用无障碍服务做了非无障碍用途**（GOOGLE-PERM-ACCESSIBILITY-MISUSE · 致命）
  - 验法：不是无障碍工具的 App 声明了 BIND_ACCESSIBILITY_SERVICE。
  - 修法：无障碍 API 只用于真正的无障碍功能并声明用途，否则删掉该服务。
  - 出处：Google Permissions and APIs

- [ ] **申请全部文件访问但不符合条件**（GOOGLE-PERM-ALL-FILES · 高）
  - 验法：AndroidManifest 里声明了 MANAGE_EXTERNAL_STORAGE。
  - 修法：改用分区存储；只有符合许可用途才申请全部文件访问并完成声明。
  - 出处：Google Permissions and APIs

- [ ] **后台定位没有核心功能支撑**（GOOGLE-PERM-BACKGROUND-LOCATION · 高）
  - 验法：声明了 ACCESS_BACKGROUND_LOCATION，却没有明确核心功能或显著披露。
  - 修法：尽量用前台定位；确实要后台就说明核心功能、显著披露并完成权限声明。
  - 出处：Google Permissions and APIs

- [ ] **短信/通话记录权限没有获批用途**（GOOGLE-PERM-SMS-CALLLOG · 高）
  - 验法：声明了 READ_SMS、SEND_SMS、RECEIVE_SMS、READ_CALL_LOG、WRITE_CALL_LOG 却没有获批用途。2027-01-27 起用电话做账号验证不再是 READ_CALL_LOG 的许可用途，改用 Digital Credentials API / SMS Retriever API / SMS User Consent API。
  - 修法：用权限声明表说明获批的核心用途，否则删掉权限；2027-01-27 后改走上述替代 API。
  - 出处：Google Permissions and APIs（Play Console Help 10208820、18100766）

- [ ] **系统悬浮窗权限（tapjacking/恶意信号）**（ANDROID-OVERLAY-TAPJACKING · 致命）
  - 验法：声明了 SYSTEM_ALERT_WINDOW 或应用悬浮层，尤其和无障碍服务同时出现——悬浮层+无障碍是谷歌重点打击的强恶意信号。
  - 修法：去掉悬浮层滥用。
  - 出处：Google Permissions and APIs

- [ ] **声明了 QUERY_ALL_PACKAGES 却没有许可用途**（ANDROID-QUERY-ALL-PACKAGES · 高）
  - 验法：AndroidManifest 里声明了 QUERY_ALL_PACKAGES。
  - 修法：用 queries 元素声明具体包名，或证明符合许可用途。
  - 出处：Google Package visibility

- [ ] **照片/视频权限没走系统选择器也没申报**（GOOGLE-PHOTO-VIDEO-PERMISSIONS-DECLARATION · 高）
  - 验法：目标 API 33+ 的 App，只有系统照片选择器不够用核心功能时才可申请 READ_MEDIA_IMAGES / READ_MEDIA_VIDEO，且保留权限的 App 必须在 Play Console 完成照片和视频权限声明。清单里声明了权限、源码里又没有照片选择器用法，是典型被拒形态。
  - 修法：一次性选图改用系统照片选择器；只有核心是图库类功能才保留广权限，并完成 Play Console 声明。
  - 出处：Google Photo and Video Permissions（Play Console Help 14115180）

- [ ] **申请通讯录权限但选择器就够用**（GOOGLE-CONTACTS-PICKER-REQUIRED · 高）
  - 验法：目标 API 37+ 的 App，只有 Android 通讯录选择器不足以实现核心功能时才可申请 READ_CONTACTS，且必须完成 Play Console 声明。2026-10-27 起预审核、2027-01-27 起执行。
  - 修法：一次性选联系人改用 Contact Picker；只为真核心用途（拨号器、通讯录管理）保留权限并提交声明。
  - 出处：Google 通讯录权限政策（Play Console Help 16909972）

- [ ] **定位没用"位置按钮"的权限范围**（GOOGLE-LOCATION-BUTTON-SCOPE · 高）
  - 验法：目标 API 37+ 的 App，如果定位只在用户点一下时需要，必须用 manifest 里的 onlyForLocationButton 标记实现位置按钮。为"点一下定位"申请宽泛的 ACCESS_FINE_LOCATION，2027-01-27 起属违规。
  - 修法：一次性定位用 onlyForLocationButton 标记限定到位置按钮；宽权限只留给能说明的连续定位功能。
  - 出处：Google 定位权限政策（Play Console Help 16909972）

- [ ] **健康/健身数据没声明 Health Connect**（ANDROID-HEALTH-PERMISSIONS · 高）
  - 验法：访问 Health Connect 客户端或查健康权限（步数、心率等），却没有相应声明或专门的健康隐私政策。
  - 修法：声明 Health Connect 权限，填完控制台的 Health Connect 表单，维护专门的健康隐私政策。
  - 出处：Google Permissions and APIs

- [ ] **动态下载并执行代码**（ANDROID-DYNAMIC-CODE-LOADING · 致命）
  - 验法：从下载文件用 DexClassLoader/PathClassLoader，或运行时下载并执行代码。目标 API 37 起，System.load() 加载的每个 native 库必须只读，否则抛 UnsatisfiedLinkError。
  - 修法：所有代码随包发布；服务端下发的只能是数据，不能是可执行代码。
  - 出处：Google 设备与网络滥用

- [ ] **本地网络访问没申请新权限**（ANDROID-LOCAL-NETWORK-PERMISSION · 高）
  - 验法：Android 17 起对目标 API 37+ 强制要求。mDNS、NSD 发现、组播、直连局域网没有声明并申请 ACCESS_LOCAL_NETWORK 会抛安全异常。
  - 修法：声明 android.permission.ACCESS_LOCAL_NETWORK，在任何局域网发现/连接前运行时申请，被拒时优雅降级。
  - 出处：Android 17 行为变更（API 37）

### 用户数据与隐私

- [ ] **敏感数据没做显著披露**（ANDROID-USER-DATA-DISCLOSURE · 致命）
  - 验法：声明了读取通讯录、短信、通话记录、设备账号或全部文件的权限（谷歌强制显著披露的范围），App 里却没有披露或同意流程。
  - 修法：采集敏感个人信息前在应用内显著披露，并取得明确同意。
  - 出处：Google User Data

- [ ] **广告 ID 没披露或没退出选项**（ANDROID-ADVERTISING-ID · 高）
  - 验法：用了 AD_ID 权限或查 GAID，但没有退出支持或用户删除路径（代码/隐私政策里都没有）。
  - 修法：在 manifest 声明 AD_ID，并按政策处理用户退出或删除请求。
  - 出处：Google User Data

- [ ] **备份开着却没过滤敏感数据**（ANDROID-INSECURE-BACKUP · 高）
  - 验法：manifest 里 android:allowBackup=true，却没设数据提取规则排除凭据和数据库。
  - 修法：设 allowBackup="false"，或用 dataExtractionRules/fullBackupContent 排除敏感凭据和 SQLite 数据库。
  - 出处：Google 设备与网络滥用

- [ ] **能建号但应用内不能删号、也没删数据 URL**（ANDROID-ACCOUNT-DELETION-URL · 致命）
  - 验法：能建号，但应用内没有删除路径，Play Console 上架信息里也没有网页删数据 URL。
  - 修法：提供应用内删号，并在 Play Console 上架信息里设置公开的删数据 URL。
  - 出处：Google User Data

- [ ] **Play 年龄信号 API 挪作他用**（GOOGLE-PLAY-AGE-SIGNALS-MISUSE · 致命）
  - 验法：把 Play Age Signals API（com.google.android.play:age-signals）和广告、营销、用户画像或分析库一起用，违反 Play 服务条款。
  - 修法：该 API 的信息只能用于按年龄提供合适内容和体验，不得用于广告、营销、画像、分析。
  - 出处：Google User Data

- [ ] **儿童 App 用了不合规广告 SDK**（GOOGLE-FAMILIES-AD-SDK · 致命）
  - 验法：声明为儿童应用的 App，用了未通过 Families 认证的广告 SDK，或对未成年人展示行为广告。
  - 修法：只用 Families 认证的广告 SDK，去掉面向未成年人的行为广告。
  - 出处：Google Families

### 付款与订阅

- [ ] **数字商品不用 Play 支付**（GOOGLE-PLAY-BILLING · 致命）
  - 验法：应用内数字商品走网页结账或第三方支付 SDK，而不是 Play Billing。
  - 修法：应用内数字商品走 Play Billing；地区性替代方案只在谷歌允许的地方用。
  - 出处：Google Payments

- [ ] **Play 支付库低于 8**（GOOGLE-PLAY-BILLING-V8-REQUIRED · 高）
  - 验法：依赖 com.android.billingclient:billing 的主版本低于 8。2026-08-31 起新 App 和更新必须用 8 或更高（有弃用阶梯），可用 Play Console 延期到 2026-11-01；已发布的 v7 包在 2027 全应用截止前仍可交易。
  - 修法：升到 billing 8.x，或在 2026-11-01 前申请延期。
  - 出处：Google Payments（Play Billing 弃用 FAQ）

- [ ] **应用内捐赠链接绕过 Play 支付**（GOOGLE-PAYMENTS-DONATION-LINK · 致命）
  - 验法：应用内链到 Open Collective、Ko-fi、Patreon、Buy Me a Coffee、GitHub Sponsors、Liberapay 或 PayPal 捐赠页。谷歌按字面执行支付政策例外：只有捐给免税慈善机构（501(c)(3) 类，不是 501(c)(6) 行业协会或未注册项目）才能绕过 Play 支付，其余一律按数字商品付费处理。开源 App 最常中招（AnkiDroid，2026-08）。
  - 修法：Play 版去掉捐赠入口（做个 build flavor 即可），或走 Play 支付做一次性商品；若收款方是免税慈善机构，在审核备注里留资质证明。别在申诉里争辩，谷歌已明确 501(c)(6) 不算。
  - 出处：Google Payments policy（Play Console Help 9992660）

- [ ] **Play 支付没处理拒付，成本现在由开发者承担**（GOOGLE-PLAY-CHARGEBACK-LIABILITY · 高）
  - 验法：2026-08-03 之后的订单，谷歌不再承担拒付，开发者承担货款减服务费再加卡组织拒付费（每单通常 15–25 美元）。App 用了 Play 支付却从不处理 PendingRefundReviewNotification 实时通知、也不调 Review Refund API，每笔欺诈争议都默认输。这不是拒因，是落在开发者账上的收入和欺诈风险。
  - 修法：订阅实时开发者通知，处理 PendingRefundReviewNotification，24 小时内调 Review Refund API 并提交退款偏好和使用证据，让谷歌代为抗辩；把拒付费算进收入模型。
  - 出处：Play Console 退款保护与拒付成本变更（Play Console Help 17068375）

### 上架与技术质量

- [ ] **新个人账号没做封闭测试**（GOOGLE-12-TESTER-RULE · 高）
  - 验法：人工查。新个人开发者账号要至少 12 名测试者连续 14 天封闭测试才能转正式。
  - 修法：做满 12 人×14 天封闭测试，或合适的话用组织账号。
  - 出处：Google 封闭测试要求

- [ ] **数据安全表跟实际行为对不上**（GOOGLE-DATASAFETY-MISMATCH · 致命）
  - 验法：有分析、广告、追踪 SDK 在采集或共享数据，但数据安全表里没申报。这是谷歌拒因第一名。
  - 修法：审计每个 SDK 和运行时数据流，把采集、共享、安全实践如实填进数据安全表。
  - 出处：Google Data Safety

- [ ] **商店介绍与实际功能不符**（GOOGLE-MISLEADING-LISTING · 高）
  - 验法：人工核对。商店介绍、截图、描述必须和 App 实际功能一致。
  - 修法：介绍和构建完全一致，截图用真实应用内画面。
  - 出处：Google Store Listing and Promotion

- [ ] **没隐私政策**（GOOGLE-MISSING-PRIVACY-POLICY · 致命）
  - 验法：App 采集用户数据，但 Play Console 上架信息里没有隐私政策 URL。
  - 修法：发布隐私政策，把 URL 填进 Play Console 上架信息。
  - 出处：Google User Data

- [ ] **目标 API 版本不够新**（GOOGLE-TARGET-API · 致命）
  - 验法：build.gradle 里 targetSdkVersion 低于谷歌现行要求。2026-08-31 起新 App 和更新必须以 Android 16（API 36）或更高为目标，可用 Play Console 延期到 2026-11-01。Wear OS/Automotive OS 至少 API 35，TV/XR 至少 API 34。
  - 修法：按现行要求构建，2026-08-31 起是 API 36+；低于门槛会被自动拒。
  - 出处：Google Target API level

- [ ] **受监管品类用个人账号发布**（GOOGLE-ORG-REGISTRATION-REQUIRED · 致命）
  - 验法：2026-09-30 起，金融产品服务（银行、贷款、交易、投资基金、加密钱包和交易所）、健康 App（医疗、人体研究）、获批用 VpnService 的 App、政府 App，必须用组织账号发布，且 D-U-N-S 编号与邓白氏档案一致。对 VpnService、Health Connect、金融信号是启发式判断。
  - 修法：转建组织账号，办 D-U-N-S 编号，账号信息和邓白氏档案完全一致，2026-09-30 前走官方 Transfer ownership 流程转移 App。
  - 出处：Play Console 受监管品类组织账号要求（Help 10788890、17125096）

- [ ] **包名没注册开发者验证**（GOOGLE-PLAY-APP-REGISTRATION-MISSING · 致命）
  - 验法：每个 Play 包名必须在 2026-09-30 前在 Play Console 注册以完成 Android 开发者验证。这一条是全球性的，未注册有被全球下架风险。人工在 Play Console 查。从不分发在开发包名不需要注册。
  - 修法：打开 Play Console 完成验证，注册每个分发包名，新增 applicationId 或 product flavor 后复查。
  - 出处：Android 开发者验证 Play 侧（Help 17125096、17134731）

- [ ] **用前台服务做地理围栏**（GOOGLE-FGS-GEOFENCE-REMOVED · 高）
  - 验法：目标 API 37 起地理围栏不再是获批的前台服务用途。声明 FOREGROUND_SERVICE_LOCATION 却只拿它做地理围栏的 App，2027-01-27 起被拒。
  - 修法：改用 Geofence API（GeofencingClient），若地理围栏是唯一用途就去掉 FOREGROUND_SERVICE_LOCATION。
  - 出处：Google 前台服务要求（Play Console Help 16965181）

- [ ] **specialUse 前台服务没写子类型**（ANDROID-FGS-SPECIAL-USE-UNDECLARED · 高）
  - 验法：specialUse 类型的前台服务必须声明 PROPERTY_SPECIAL_USE_FGS_SUBTYPE 属性，并在 Play Console 前台服务声明里说明理由。否则审核会问理由、可能拒更新。
  - 修法：在服务里加子类型属性并填完 Play Console 声明，或改用具体服务类型。
  - 出处：Google 前台服务类型政策

- [ ] **发布包没做优化/混淆**（ANDROID-R8-OPTIMIZATION-MISSING · 高）
  - 验法：2027-02 起 App 必须在优化、缩减、混淆上达到至少 25% 覆盖率（用 R8 之类工具）。发布构建 minifyEnabled=false 或压根没写，就低于门槛，失去曝光和发布能力。
  - 修法：发布构建类型开启 R8（isMinifyEnabled=true、isShrinkResources=true），修好 keep 规则，2027-02 前核对 Play Console 优化报告。
  - 出处：Play Console 技术质量要求 DEX 优化（Help 17492799）

- [ ] **换了新设备登录状态没恢复**（ANDROID-RESTORE-CREDENTIALS-REQUIRED · 高）
  - 验法：2027-04 起任何有登录（可选或强制）的 App，用户换 Android 新机时必须用 Restore Credentials API 恢复登录状态。游戏目前不在范围内。有登录流程但没接 RestoreCredential 就会不达标。
  - 修法：登录成功时通过 Credential Manager 创建 restore credential，换机后首启恢复，登出时清除。
  - 出处：Play Console 技术质量要求 Zero-Tap Sign-In（Help 17492799）

- [ ] **上传了可调试的包**（ANDROID-DEBUGGABLE-RELEASE · 高）
  - 验法：Play Console 拒绝标记为 debuggable 的 APK/app bundle。manifest 里硬写 android:debuggable="true" 会让它进发布包。
  - 修法：从 manifest 去掉 android:debuggable，让发布构建类型保持 false。
  - 出处：Play Console 上传校验

- [ ] **32 位 native 库没有 64 位版本**（ANDROID-64BIT-ABI-MISSING · 致命）
  - 验法：Google Play 要求每个 native 库都要有 64 位版本。abiFilters 里只有 armeabi-v7a、没有 arm64-v8a 就不达标。
  - 修法：abiFilters 加 arm64-v8a，若发布 x86 也加 x86_64。
  - 出处：Google Play 64 位要求

### 生成式 AI 与未成年人

- [ ] **生成式图片/视频 App 没有 NCII 防护和全权限测试账号**（GOOGLE-GENAI-NCII-CONTROLS · 致命）
  - 验法：生成或编辑人物图片/视频的 App，必须接入定制的输入输出审核、记录测过的安全提示和边界情况，并给审核员一个能免付费访问全部 AI 功能的测试账号。被停用的 App 会在谷歌全平台被禁止变现和打广告。
  - 修法：加亲密内容和深度伪造的输入输出审核，留存安全提示和边界测试记录，在 Play Console 审核备注里放全权限测试账号。
  - 出处：Google 生成式 AI 政策执行，非自愿亲密内容（Android Developers Blog，2026-08-25）

- [ ] **随机/匿名聊天 App 没拦未成年人**（GOOGLE-ANON-CHAT-MINOR-BLOCK · 致命）
  - 验法：核心功能是随机连接陌生人、或隐藏身份的匿名交流的 App，必须用 Play Console 功能拦截未成年人，不得以儿童为目标受众，并受儿童安全标准政策约束（公开的 CSAE 标准、应用内举报、清除 CSAM、儿童安全联系人）。
  - 修法：开启 Play Console 未成年人拦截工具，年龄分级和目标受众排除儿童，公布 CSAE 标准，加应用内举报，指定儿童安全联系人。
  - 出处：Google 受限内容、Families、儿童安全标准（Help 17036597、17122218、14747720，2026-08-26 生效）

- [ ] **App 没有内容分级就发布或更新**（GOOGLE-UNRATED-APP-BANNED · 致命）
  - 验法：谷歌明确无分级的 App 不允许上架。IARC 内容分级问卷没填完或已过期会卡住发布。人工在 Play Console 查。
  - 修法：每个 App 填完内容分级问卷，功能变化（聊天、UGC、赌博、AI 生成）后重新答。
  - 出处：Google 内容分级政策澄清（Help 17134731，2026-08-26）

---

## 三、Apple 与 Google 共同（13 条）

- [ ] **生成式 AI 输出没有审核或防护**（BOTH-AI-GENERATED-CONTENT · 致命）
  - 验法：接了生成式 AI/图片生成，却没有内容过滤、举报、拉黑、年龄分级或滥用防护。苹果把 UGC 规则用在 AI 输出上，谷歌有专门的 AI 生成内容政策。2026-10-16 起苹果 1.2 明确点名 AI 内容创作 App，要求防止并清除包括 AI 生成在内的非自愿亲密影像。
  - 修法：加审核、举报、拉黑、准确年龄分级和滥用防护；防止 NSFW、深度伪造、换脸、脱衣生成。
  - 出处：Apple 1.2 / Google AI Generated Content

- [ ] **欧盟 e-Evidence 没指定代表或应急取证流程**（BOTH-E-EVIDENCE-COMPLIANCE-MISSING · 致命）
  - 验法：在欧盟处理用户数据的 App/服务，没指定欧盟法定代表，或没有在 10 天内（紧急 8 小时内）响应欧洲生产/保全令的内部流程。
  - 修法：在欧盟指定机构或法定代表，2026-08-18 前通知联系方式，建立 8 小时内安全交付用户数据的内部协议。
  - 出处：欧盟 e-Evidence 包（EU 2023/1543 与指令 2023/1544）

- [ ] **欧盟 GPSR 缺厂商信息或安全警示**（BOTH-GPSR-COMPLIANCE-MISSING · 致命）
  - 验法：有电商或数字商品上架，但界面上没有厂商邮箱、邮寄地址或产品安全警示。
  - 修法：在欧盟境内销售的消费品，直接在商品页或在线界面显著提供厂商联系方式（邮箱+邮寄地址）和适用的产品安全警示。
  - 出处：欧盟通用产品安全法规 GPSR（EU 2023/988）

- [ ] **第三方 SDK 替开发者违规**（BOTH-SDK-SUPPLY-CHAIN · 致命）
  - 验法：打包的 SDK 在申请权限、追踪用户或做 App 没声明的行为。开发者要为 SDK 行为负责。
  - 修法：逐个审查 SDK，保持更新，移除任何采集或共享未声明数据的 SDK。
  - 出处：SDK 责任

- [ ] **用了设备指纹追踪用户**（BOTH-FINGERPRINTING · 致命）
  - 验法：用硬件或系统设置拼出持久设备指纹来识别用户。苹果一律禁止，拿到 ATT 同意也不行。
  - 修法：不要做指纹。确实需要追踪就用平台广告标识符并取得同意。
  - 出处：Apple 5.1.2 / Google 设备与网络滥用

- [ ] **随机奖励没公布概率**（BOTH-LOOTBOX-ODDS · 致命）
  - 验法：有开箱、抽卡或随机付费奖励，但购买前没公布概率。
  - 修法：购买前公布每一种随机奖励的概率。
  - 出处：Apple 3.1.1 / Google 赌博政策

- [ ] **敏感凭据存在不加密的格式里**（BOTH-SECURE-STORAGE · 致命）
  - 验法：会话凭据或令牌明文存进 plist、UserDefaults、SharedPreferences，而不是 Keychain 或 Android Keystore/EncryptedSharedPreferences。
  - 修法：所有敏感数据和访问令牌存进 iOS Keychain 或 Android EncryptedSharedPreferences。
  - 出处：Data Security

- [ ] **自定义深链用来做敏感操作又不校验**（BOTH-UNSAFE-DEEPLINK · 高）
  - 验法：靠自定义 URL scheme 做敏感路由、导航或传令牌，且没有严格输入校验。
  - 修法：用 Universal Links（iOS）和 App Links（Android）做域名校验的安全路由，并清洗所有深链参数。
  - 出处：Data Security

- [ ] **商店里的支持/营销/隐私链接打不开**（BOTH-UNREACHABLE-METADATA-URL · 高）
  - 验法：上架信息里的支持 URL、营销 URL 或隐私政策 URL 加载不出来。
  - 修法：确认每个链接公开可访问，且整个审核窗口内都能打开。
  - 出处：Apple 1.5 / 2.1，Google User Data

- [ ] **元数据字段超限或有违规装饰**（BOTH-METADATA-DECORATION · 中）
  - 验法：App 名超长（苹果 30、谷歌 30）、标题里有 emoji、全大写，或在标题/图标里写排名和价格宣称（第一、最佳、顶部、免费）。
  - 修法：各字段控制在限制内，标题和图标去掉 emoji、全大写、排名和价格宣称。
  - 出处：Apple 2.3.7 / Google Store Listing

- [ ] **订阅取消要打电话、发邮件或到店，注册却是一键**（BOTH-SUBSCRIPTION-HARD-CANCEL · 致命）
  - 验法：商店外计费（网页或账号设置）的订阅，取消却要打电话、寄信或到店，而不是自助取消。联邦 FTC 一键取消规则 2025 年被撤销，但加州、纽约、麻州有自己的自动续费法规在生效，FTC 仍保有 Section 5 和 ROSCA 权力。
  - 修法：提供至少和注册一样简单的自助取消路径（应用内按钮或网页账号设置）；商店外计费的订阅绝不要求打电话、寄信或到店。
  - 出处：Apple 3.1.2 / FTC Section 5、ROSCA / 州自动续费法规

- [ ] **欧盟消费者合同缺显眼的撤回按钮**（BOTH-WITHDRAWAL-BUTTON-MISSING · 致命）
  - 验法：向欧盟消费者提供数字订阅或远程合同的 App，界面上没提供显眼、易访问的"撤回按钮/功能"让消费者在 14 天内取消。
  - 修法：在界面上加显眼、专门、易访问的撤回按钮或功能，让消费者无障碍地撤回合同/订阅。
  - 出处：Apple 3.1.2 / 欧盟远程金融服务营销指令 2023/2673

- [ ] **美国州级 ASAA 没接商店年龄信号**（BOTH-US-ASAA-AGE-SIGNALS-MISSING · 致命）
  - 验法：启发式判断，非认证。有账号或年龄限制功能的 App，看不到商店年龄信号接口的接入（iOS 的 Declared Age Range、Android 的 Play Age Signals API），也没有对未成年人账号的可验证家长同意处理。商店侧义务 2026-05-06（犹他）起生效。
  - 修法：接入商店年龄信号 API，未成年人使用前确认可验证家长同意，重大变更时重新请求，核验后删除原始年龄验证数据。
  - 出处：美国州级 App Store Accountability Acts（犹他 SB 142、德州 SB 2420 等后续州法案）

---

## 四、Web（6 条）

- [ ] **未经同意写非必要 cookie**（WEB-COOKIE-CONSENT · 高）
  - 验法：写 document.cookie 或 cookieStore 之前没检查用户是否通过 cookie 同意横幅接受。
  - 修法：做合规的 cookie 同意横幅，用户明确同意前不写非必要 cookie。
  - 出处：ePrivacy 指令

- [ ] **处理网页个人数据却没有 GDPR 控制项**（WEB-GDPR-COMPLIANCE · 致命）
  - 验法：采集或处理个人网页数据，却没有明确 opt-in 控制、隐私政策链接或被遗忘权（删除）选项。
  - 修法：接入标准 GDPR 合规门，包括明确 opt-in 和数据删除机制。
  - 出处：GDPR

- [ ] **IndexedDB 存了个人数据却没安全控制**（WEB-INDEXEDDB · 高）
  - 验法：把用户记录存进 IndexedDB，没有用户同意、加密或正确的删除生命周期。
  - 修法：结构化敏感记录用加密的 IndexedDB 封装，检查用户同意，登出时清库。
  - 出处：GDPR

- [ ] **localStorage 明文存敏感个人数据**（WEB-LOCAL-STORAGE · 高）
  - 验法：敏感信息或 JWT 令牌明文存进 localStorage，没加密也没检查用户同意。
  - 修法：别在 localStorage 明文存敏感信息，令牌要加密，尊重存储偏好。
  - 出处：GDPR

- [ ] **sessionStorage 存了会话密钥却没保护**（WEB-SESSION-STORAGE · 高）
  - 验法：原始鉴权或会话密钥存进 sessionStorage，没加密也没清理逻辑。
  - 修法：限制并保护写进 sessionStorage 的数据，做加密，会话结束时删除。
  - 出处：GDPR

- [ ] **第三方追踪脚本未经同意就加载**（WEB-TRACKING-TECHNOLOGIES · 高）
  - 验法：接了分析像素或追踪脚本（Google Analytics、Facebook Pixel、Hotjar），没有先校验同意。
  - 修法：拿到用户明确的 cookie 同意后再条件加载第三方追踪脚本和像素。
  - 出处：GDPR

---

## 状态说明

本清单是**草稿**：规则经过官方来源核对，但还没找做过上架的人逐条过，也没拿真项目验证过能不能真的捞出问题。按 `checklists/_SCHEMA.md`，没过老手评审不能当验收依据。
