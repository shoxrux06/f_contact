// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomeState _$$_HomeStateFromJson(Map<String, dynamic> json) => _$_HomeState(
      region: (json['region'] as List<dynamic>?)
              ?.map((e) => District.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      district: (json['district'] as List<dynamic>?)
              ?.map((e) => District.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      regionList: (json['region_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      districtList: (json['district_list'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      code: json['code'] as String? ?? '',
    );

Map<String, dynamic> _$$_HomeStateToJson(_$_HomeState instance) =>
    <String, dynamic>{
      'region': instance.region.map((e) => e.toJson()).toList(),
      'district': instance.district.map((e) => e.toJson()).toList(),
      'region_list': instance.regionList,
      'district_list': instance.districtList,
      'code': instance.code,
    };
