import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/field_dot.dart';
import 'package:pathfinding/models/field_dot_model.dart';

part 'field_model.freezed.dart';
part 'field_model.g.dart';

@freezed
class FieldModel extends PathfinderField with _$FieldModel {
  const FieldModel._();

  @JsonSerializable(includeIfNull: false)
  const factory FieldModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'start') required FieldDotModel start,
    @JsonKey(name: 'end') required FieldDotModel end,
    @JsonKey(name: 'field') @Default([]) List<String> fieldStrings,
  }) = _FieldModel;


  @override
  List<List<FieldDot>> get field => throw UnimplementedError();

  factory FieldModel.fromJson(Map<String, dynamic> json) => _$FieldModelFromJson(json);
}
