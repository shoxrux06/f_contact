import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_model.g.dart';
part 'contact_model.freezed.dart';
@freezed
class ContactModel with _$ContactModel{
  const factory ContactModel({
    required int id,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String country,
    required String region,
    required String district,
    required String address,
  }) = _ContactModel;
  const ContactModel._();

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);
}