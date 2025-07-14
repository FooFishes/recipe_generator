import 'package:flutter/material.dart';

/// 响应式断点定义
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1200;
  static const double desktop = 1800;
}

/// 设备类型枚举
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// 响应式工具类
class ResponsiveUtils {
  /// 获取当前设备类型
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < ResponsiveBreakpoints.mobile) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.tablet) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
  
  /// 是否为移动设备
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }
  
  /// 是否为平板设备
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }
  
  /// 是否为桌面设备
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }
  
  /// 是否为大屏幕设备（平板或桌面）
  static bool isLargeScreen(BuildContext context) {
    return !isMobile(context);
  }
  
  /// 获取响应式值
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
  
  /// 获取网格列数
  static int getGridColumns(BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    return getResponsiveValue(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
  
  /// 获取内容最大宽度
  static double getContentMaxWidth(BuildContext context) {
    return getResponsiveValue(
      context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1200,
    );
  }
  
  /// 获取表单最大宽度
  static double getFormMaxWidth(BuildContext context) {
    return getResponsiveValue(
      context,
      mobile: double.infinity,
      tablet: 600,
      desktop: 600,
    );
  }
  
  /// 获取卡片最大宽度
  static double getCardMaxWidth(BuildContext context) {
    return getResponsiveValue(
      context,
      mobile: double.infinity,
      tablet: 400,
      desktop: 400,
    );
  }
  
  /// 获取响应式边距
  static EdgeInsets getResponsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: getResponsiveValue(
        context,
        mobile: 16.0,
        tablet: 32.0,
        desktop: 48.0,
      ),
      vertical: 16.0,
    );
  }
  
  /// 获取响应式间距
  static double getResponsiveSpacing(BuildContext context) {
    return getResponsiveValue(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
  }
  
  /// 获取响应式字体大小
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final scaleFactor = getResponsiveValue(
      context,
      mobile: 1.0,
      tablet: 1.1,
      desktop: 1.2,
    );
    return baseFontSize * scaleFactor;
  }
}

/// 响应式布局构建器
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;
  
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });
  
  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveUtils.getDeviceType(context));
  }
}

/// 响应式包装容器
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final bool centerContent;
  final EdgeInsets? padding;
  
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.centerContent = true,
    this.padding,
  });
  
  @override
  Widget build(BuildContext context) {
    final containerMaxWidth = maxWidth ?? ResponsiveUtils.getContentMaxWidth(context);
    final containerPadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    
    Widget content = Container(
      constraints: BoxConstraints(maxWidth: containerMaxWidth),
      padding: containerPadding,
      child: child,
    );
    
    if (centerContent && ResponsiveUtils.isLargeScreen(context)) {
      content = Center(child: content);
    }
    
    return content;
  }
}

/// 响应式网格视图
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double? childAspectRatio;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  
  const ResponsiveGridView({
    super.key,
    required this.children,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio,
    this.physics,
    this.shrinkWrap = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getGridColumns(
      context,
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns ?? 2,
      desktop: desktopColumns ?? 3,
    );
    
    final spacing = ResponsiveUtils.getResponsiveSpacing(context);
    
    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: mainAxisSpacing ?? spacing,
      crossAxisSpacing: crossAxisSpacing ?? spacing,
      childAspectRatio: childAspectRatio ?? 1.0,
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}

/// 响应式列表视图
class ResponsiveListView extends StatelessWidget {
  final List<Widget> children;
  final bool useGrid;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double? childAspectRatio;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  
  const ResponsiveListView({
    super.key,
    required this.children,
    this.useGrid = false,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.childAspectRatio,
    this.physics,
    this.shrinkWrap = false,
  });
  
  @override
  Widget build(BuildContext context) {
    if (useGrid && ResponsiveUtils.isLargeScreen(context)) {
      return ResponsiveGridView(
        mobileColumns: mobileColumns,
        tabletColumns: tabletColumns,
        desktopColumns: desktopColumns,
        childAspectRatio: childAspectRatio,
        physics: physics,
        shrinkWrap: shrinkWrap,
        children: children,
      );
    }
    
    return ListView(
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}

/// 响应式卡片组件
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  
  const ResponsiveCard({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.margin,
  });
  
  @override
  Widget build(BuildContext context) {
    final cardMaxWidth = maxWidth ?? ResponsiveUtils.getCardMaxWidth(context);
    final cardPadding = padding ?? const EdgeInsets.all(16.0);
    final cardMargin = margin ?? const EdgeInsets.symmetric(vertical: 8.0);
    
    return Container(
      constraints: BoxConstraints(maxWidth: cardMaxWidth),
      margin: cardMargin,
      child: Card(
        child: Padding(
          padding: cardPadding,
          child: child,
        ),
      ),
    );
  }
}