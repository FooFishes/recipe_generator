import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'log_config.freezed.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

enum LogOutputType {
  console,
  file,
  both,
}

@freezed
class LogConfig with _$LogConfig {
  const factory LogConfig({
    @Default(LogLevel.debug) LogLevel? minLevel,
    @Default(LogOutputType.console) LogOutputType? outputType,
    @Default(true) bool? enabled,
    @Default(10) int? maxFileSize,
    @Default(5) int? maxFileCount,
    @Default(false) bool? enableInRelease,
    @Default(true) bool? showTimestamp,
    @Default(true) bool? showLevel,
    @Default(true) bool? showCaller,
    @Default(false) bool? showStackTrace,
    @Default('app_log') String? fileNamePrefix,
  }) = _LogConfig;

  static const LogConfig development = LogConfig(
    minLevel: LogLevel.debug,
    outputType: LogOutputType.both,
    enabled: true,
    enableInRelease: true,
    showTimestamp: true,
    showLevel: true,
    showCaller: true,
    showStackTrace: true,
  );

  static const LogConfig production = LogConfig(
    minLevel: LogLevel.warning,
    outputType: LogOutputType.file,
    enabled: true,
    enableInRelease: true,
    showTimestamp: true,
    showLevel: true,
    showCaller: false,
    showStackTrace: false,
  );

  static const LogConfig testing = LogConfig(
    minLevel: LogLevel.info,
    outputType: LogOutputType.console,
    enabled: true,
    enableInRelease: false,
    showTimestamp: false,
    showLevel: true,
    showCaller: false,
    showStackTrace: false,
  );
}

extension LogConfigExtension on LogConfig {
    Level toLoggerLevel() {
    switch (minLevel!) {
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.fatal:
        return Level.fatal;
    }
  }
}