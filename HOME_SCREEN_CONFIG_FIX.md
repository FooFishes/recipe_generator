# 主界面配置状态显示修复

## 问题描述
主界面（home_screen）的提示卡片只检查API密钥的配置状态，不会提示用户配置模型名称和基础URL，导致用户可能不知道还需要配置其他项目。

## 修复内容

### 1. 添加完整的配置状态检查
**之前的逻辑：**
```dart
final apiKey = ref.watch(apiKeyProvider);
final hasApiKey = apiKey != null && apiKey.isNotEmpty;
```

**修复后的逻辑：**
```dart
final apiKey = ref.watch(apiKeyProvider);
final hasApiKey = apiKey != null && apiKey.isNotEmpty;
final model = ref.watch(modelProvider);
final hasModel = model != null && model.isNotEmpty;
final baseUrl = ref.watch(baseUrlProvider);
final hasBaseUrl = baseUrl != null && baseUrl.isNotEmpty;

// 检查是否所有配置都完成
final isFullyConfigured = hasApiKey && hasModel && hasBaseUrl;
```

### 2. 改进提示卡片显示
**之前的显示：**
- 只显示"API密钥未设置"
- 只有API密钥未配置时才显示提示

**修复后的显示：**
- 标题改为"配置未完成"
- 列出所有未配置的项目：
  - • 未配置API密钥
  - • 未配置模型名称  
  - • 未配置基础URL
- 只要有任何一项未配置就显示提示

### 3. 更新按钮启用条件
**之前：**
```dart
onPressed: hasApiKey ? _generateRecipes : null,
```

**修复后：**
```dart
onPressed: isFullyConfigured ? _generateRecipes : null,
```

## 用户体验改进

### 配置提示更全面
- **完整性检查**：检查所有必需的配置项
- **具体指导**：明确告诉用户哪些项目未配置
- **视觉突出**：未配置项目用红色粗体显示

### 交互逻辑更严格
- **按钮状态**：只有全部配置完成才能生成菜谱
- **错误预防**：避免用户在配置不完整时尝试生成菜谱
- **引导流程**：清晰的"前往设置"按钮

## 显示效果

### 全部未配置时
```
⚠️ 配置未完成

• 未配置API密钥
• 未配置模型名称
• 未配置基础URL

请先在设置中完成所有配置

[前往设置]
```

### 部分配置时
```
⚠️ 配置未完成

• 未配置模型名称
• 未配置基础URL

请先在设置中完成所有配置

[前往设置]
```

### 全部配置完成时
- 不显示提示卡片
- 生成菜谱按钮可用

## 技术实现

### 状态监听
- 监听所有三个配置provider
- 实时更新配置状态
- 响应式UI更新

### 条件渲染
- 使用条件语句显示未配置项目
- 动态生成提示内容
- 保持UI简洁

### 一致性保证
- 与设置页面的配置检查逻辑一致
- 与Repository层的验证逻辑对应
- 统一的用户体验

## 效果验证

用户现在可以：
1. **清楚了解**：在主界面就能看到所有未配置的项目
2. **快速导航**：直接点击"前往设置"完成配置
3. **避免错误**：配置不完整时无法生成菜谱，避免运行时错误
4. **获得指导**：明确知道需要配置哪些具体项目

这个修复确保了用户在使用应用时能够得到完整和准确的配置状态信息，避免了只提示API密钥而忽略其他必需配置的问题。
