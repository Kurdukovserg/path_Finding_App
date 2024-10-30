import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pathfinding/dtos/field_dot.dart';

part 'field_dot_model.freezed.dart';
part 'field_dot_model.g.dart';

@freezed
class FieldDotModel extends FieldDot with _$FieldDotModel{
  const FieldDotModel._();

  @JsonSerializable(includeIfNull: false)
  const factory FieldDotModel({
    @JsonKey(name: 'x') required int x,
    @JsonKey(name: 'y') required int y,
    @Default(false) bool disabled,
}) = _FieldDotModel;

  factory FieldDotModel.fromJson(Map<String, dynamic> json) => _$FieldDotModelFromJson(json);
}