# Recipe Generator

一个基于 AI 的菜谱生成器，使用 Flutter 开发，支持根据输入的食材智能生成菜谱，包含营养分析、文化故事等功能。

### Key features
- **菜谱生成**：根据输入的食材，AI 智能生成多个菜谱
- **营养分析**：每个菜谱包含详细的营养成分分析和健康建议
- **文化故事**：可选择开启菜谱的文化背景故事
- **收藏管理**：收藏喜欢的菜谱，支持一键清空
- **历史记录**：查看所有生成历史，按时间排序，支持查看详情和收藏
- **日志导出**：完整的应用日志记录和导出功能

### 状态管理
- **flutter_riverpod** `^2.6.1` - 响应式状态管理

### 路由导航
- **go_router** `^16.0.0` - 声明式路由管理

### 数据存储
- **hive** `^2.2.3` - 轻量级 NoSQL 数据库
- **flutter_secure_storage** `^9.2.4` - 安全存储 API 密钥
- **shared_preferences** `^2.5.3` - 应用设置存储

### 网络请求
- **dio** `^5.8.0+1` - HTTP 客户端

### 序列化
- **json_annotation** `^4.9.0` - JSON 序列化注解
- **freezed_annotation** `^2.4.4` - 不可变数据类生成

### 目录结构
```
lib/
├── application/          # 应用层
│   └── providers/       # Riverpod 状态管理
├── core/                # 核心功能
│   ├── config/         # 应用配置
│   └── logging/        # 日志系统
├── data/                # 数据层
│   ├── models/         # 数据模型
│   ├── repositories/   # 仓库实现
│   └── services/       # 服务层
├── domain/              # 领域层
│   ├── entities/       # 实体类
│   └── repositories/   # 仓库接口
├── presentation/        # 表现层
│   ├── screens/        # 页面
│   └── widgets/        # 组件
└── main.dart           # 应用入口
```

### TODOs
- 🔮 菜谱搜索和过滤
- 🔮 菜谱分享功能
- 🔮 购物清单生成
- 🔮 烹饪计时器
- 🔮 个人偏好设置
- 🔮 离线模式
- 🔮 多语言支持


⭐ 如果这个项目对您有帮助，请给它一个星标！
