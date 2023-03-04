import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/contact_model.dart';

part 'contact_state.freezed.dart';

@freezed
class ContactState with _$ContactState{
  const factory ContactState({
    @Default([]) List<ContactModel> contactList,
    @Default(false) bool isLoadingTable,
    @Default(false) bool isCreatingTable,
    @Default(false) bool isAddingToTable,
    @Default(false) bool isUpdatingToTable,
    @Default(false) bool isDeletingFromTable,
    @Default(false) bool isSearchingFromTable,
    @Default(false) bool isFilteringByRegion,
    @Default(false) bool isFilteringByDistrict,
}) = _ContactState;

  const ContactState._();
}