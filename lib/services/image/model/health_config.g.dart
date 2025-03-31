// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthConfig _$HealthConfigFromJson(Map<String, dynamic> json) => HealthConfig(
  test: json['Test'] as String,
  interval: (json['Interval'] as num).toInt(),
  timeout: (json['Timeout'] as num).toInt(),
  reties: (json['Reties'] as num).toInt(),
  startPeriod: (json['StartPeriod'] as num).toInt(),
);

Map<String, dynamic> _$HealthConfigToJson(HealthConfig instance) =>
    <String, dynamic>{
      'Test': instance.test,
      'Interval': instance.interval,
      'Timeout': instance.timeout,
      'Reties': instance.reties,
      'StartPeriod': instance.startPeriod,
    };
