import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pathfinding/dtos/field_dot.dart';

part 'field.freezed.dart';

abstract class PathfinderField {
  const PathfinderField();

  String get id;

  List<List<FieldDot>> get field;

  FieldDot get start;

  FieldDot get end;

  PathfinderFieldDto toDto() {
    return PathfinderFieldDto(
      id: id,
      field: field,
      start: start,
      end: end,
    );
  }
}

@freezed
class PathfinderFieldDto extends PathfinderField with _$PathfinderFieldDto {
  const PathfinderFieldDto._();

  const factory PathfinderFieldDto({
    required String id,
    @Default([[]]) List<List<FieldDot>> field,
    required FieldDot start,
    required FieldDot end,
  }) = _PathfinderFieldDto;

  @override
  PathfinderFieldDto toDto() => this;
}
