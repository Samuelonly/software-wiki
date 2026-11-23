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
