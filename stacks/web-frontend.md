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
