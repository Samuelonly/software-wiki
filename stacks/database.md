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
