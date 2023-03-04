import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/address_data_class.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeState({
    @Default([]) List<District> region,
    @Default([]) List<District> district,
    @Default([]) List<String> regionList,
    @Default([]) List<String> districtList,
    @Default('') String code,
  }) = _HomeState;

}