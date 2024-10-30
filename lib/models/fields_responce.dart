import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pathfinding/models/field_model.dart';

part 'fields_responce.freezed.dart';
part 'fields_responce.g.dart';

@freezed
class FieldApiResponce with _$FieldApiResponce {
  const FieldApiResponce._();

  const factory FieldApiResponce({
    @JsonKey(name: 'error') @Default(false) bool error,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') @Default([]) List<FieldModel> fields,
  }) = _FieldApiResponce;

  factory FieldApiResponce.fromJson(Map<String, dynamic> json) =>
      _$FieldApiResponceFromJson(json);
}
