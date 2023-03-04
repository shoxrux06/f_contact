// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeState {
  List<District> get region => throw _privateConstructorUsedError;
  List<District> get district => throw _privateConstructorUsedError;
  List<String> get regionList => throw _privateConstructorUsedError;
  List<String> get districtList => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<District> region,
      List<District> district,
      List<String> regionList,
      List<String> districtList,
      String code});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = null,
    Object? district = null,
    Object? regionList = null,
    Object? districtList = null,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as List<District>,
      district: null == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as List<District>,
      regionList: null == regionList
          ? _value.regionList
          : regionList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      districtList: null == districtList
          ? _value.districtList
          : districtList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$$_HomeStateCopyWith(
          _$_HomeState value, $Res Function(_$_HomeState) then) =
      __$$_HomeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<District> region,
      List<District> district,
      List<String> regionList,
      List<String> districtList,
      String code});
}

/// @nodoc
class __$$_HomeStateCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$_HomeState>
    implements _$$_HomeStateCopyWith<$Res> {
  __$$_HomeStateCopyWithImpl(
      _$_HomeState _value, $Res Function(_$_HomeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? region = null,
    Object? district = null,
    Object? regionList = null,
    Object? districtList = null,
    Object? code = null,
  }) {
    return _then(_$_HomeState(
      region: null == region
          ? _value._region
          : region // ignore: cast_nullable_to_non_nullable
              as List<District>,
      district: null == district
          ? _value._district
          : district // ignore: cast_nullable_to_non_nullable
              as List<District>,
      regionList: null == regionList
          ? _value._regionList
          : regionList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      districtList: null == districtList
          ? _value._districtList
          : districtList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_HomeState implements _HomeState {
  const _$_HomeState(
      {final List<District> region = const [],
      final List<District> district = const [],
      final List<String> regionList = const [],
      final List<String> districtList = const [],
      this.code = ''})
      : _region = region,
        _district = district,
        _regionList = regionList,
        _districtList = districtList;

  final List<District> _region;
  @override
  @JsonKey()
  List<District> get region {
    if (_region is EqualUnmodifiableListView) return _region;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_region);
  }

  final List<District> _district;
  @override
  @JsonKey()
  List<District> get district {
    if (_district is EqualUnmodifiableListView) return _district;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_district);
  }

  final List<String> _regionList;
  @override
  @JsonKey()
  List<String> get regionList {
    if (_regionList is EqualUnmodifiableListView) return _regionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regionList);
  }

  final List<String> _districtList;
  @override
  @JsonKey()
  List<String> get districtList {
    if (_districtList is EqualUnmodifiableListView) return _districtList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_districtList);
  }

  @override
  @JsonKey()
  final String code;

  @override
  String toString() {
    return 'HomeState(region: $region, district: $district, regionList: $regionList, districtList: $districtList, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeState &&
            const DeepCollectionEquality().equals(other._region, _region) &&
            const DeepCollectionEquality().equals(other._district, _district) &&
            const DeepCollectionEquality()
                .equals(other._regionList, _regionList) &&
            const DeepCollectionEquality()
                .equals(other._districtList, _districtList) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_region),
      const DeepCollectionEquality().hash(_district),
      const DeepCollectionEquality().hash(_regionList),
      const DeepCollectionEquality().hash(_districtList),
      code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      __$$_HomeStateCopyWithImpl<_$_HomeState>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final List<District> region,
      final List<District> district,
      final List<String> regionList,
      final List<String> districtList,
      final String code}) = _$_HomeState;

  @override
  List<District> get region;
  @override
  List<District> get district;
  @override
  List<String> get regionList;
  @override
  List<String> get districtList;
  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$$_HomeStateCopyWith<_$_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
