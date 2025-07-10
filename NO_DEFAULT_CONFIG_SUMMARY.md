# 移除默认值配置总结

## 修改目标
将模型和基础URL的配置逻辑改为与API密钥完全一致：用户必须自己配置所有项目，不提供任何默认值。

## 主要修改

### 1. SettingsService 修改
**移除的内容：**
- 删除了 `_defaultModel` 和 `_defaultBaseUrl` 常量
- 删除了 `getDefaultModel()` 和 `getDefaultBaseUrl()` 方法

**保留的行为：**
- `getModel()` 和 `getBaseUrl()` 返回 `String?`
- 未配置时返回 `null`
- 删除后返回 `null`

### 2. Repository 修改
**之前的逻辑：**
```dart
final model = await _settingsService.getModel() ?? _settingsService.getDefaultModel();
final baseUrl = await _settingsService.getBaseUrl() ?? _settingsService.getDefaultBaseUrl();
```

**现在的逻辑：**
```dart
final model = await _settingsService.getModel();
if (model == null || model.isEmpty) {
  throw Exception('模型名称未设置，请先在设置中配置模型名称');
}

final baseUrl = await _settingsService.getBaseUrl();
if (baseUrl == null || baseUrl.isEmpty) {
  throw Exception('基础URL未设置，请先在设置中配置基础URL');
}
```

### 3. UI 修改

#### 主设置页面
- **配置状态显示**：移除了"将使用默认值"的提示
- **图标逻辑**：只有当所有配置（API密钥、模型、基础URL）都完成时才显示绿色勾号
- **状态文本**：简化为"已配置"或"未配置"

#### API配置页面
- **输入框提示**：移除了默认值提示
- **删除反馈**：简化为"已删除"，不再提及默认值
- **说明文档**：添加了"所有配置项都是必需的"提示

## 用户体验变化

### 配置要求
- **API密钥**：必须配置 ✓
- **模型名称**：必须配置 ✓（新要求）
- **基础URL**：必须配置 ✓（新要求）

### 错误处理
当用户尝试生成菜谱但配置不完整时，会收到明确的错误提示：
- "API密钥未设置，请先设置API密钥"
- "模型名称未设置，请先在设置中配置模型名称"
- "基础URL未设置，请先在设置中配置基础URL"

### 配置流程
1. **首次使用**：用户必须配置所有三个项目
2. **配置检查**：主设置页面清晰显示哪些项目已配置
3. **完整性验证**：只有全部配置完成才显示绿色状态

## 技术实现

### 配置验证
```dart
// 在Repository中进行严格验证
if (model == null || model.isEmpty) {
  throw Exception('模型名称未设置，请先在设置中配置模型名称');
}
```

### 状态管理
- Provider继续支持nullable类型
- UI层正确处理null值
- 删除操作清空状态并更新UI

### 错误传播
- Repository层抛出具体的配置错误
- UI层捕获并显示用户友好的错误信息
- 引导用户到设置页面完成配置

## 优势

### 1. 一致性
- 所有配置项都遵循相同的逻辑
- 与API密钥的行为完全一致
- 用户体验统一

### 2. 明确性
- 用户清楚知道哪些配置是必需的
- 没有隐藏的默认值
- 配置状态一目了然

### 3. 可控性
- 用户完全控制所有配置
- 避免了默认值可能不适用的问题
- 强制用户进行有意识的配置选择

## 向后兼容性

对于已有用户：
- 如果之前依赖默认值，现在需要手动配置
- 系统会通过错误提示引导用户完成配置
- 一次性配置后，后续使用不受影响

这种设计确保了所有用户都明确知道并控制他们的API配置，避免了因默认值不适用而导致的问题。
