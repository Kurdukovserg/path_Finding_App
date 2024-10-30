import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_dot.freezed.dart';

abstract class FieldDot {
  const FieldDot();

  int get x;

  int get y;

  bool get disabled;

  bool get isStart;

  bool get isFinish;

  FieldDotDto toDto() {
    return FieldDotDto(
      x: x,
      y: y,
      disabled: disabled,
      isStart: isStart,
      isFinish: isFinish,
    );
  }
}

@freezed
class FieldDotDto extends FieldDot with _$FieldDotDto {
  const FieldDotDto._();

  const factory FieldDotDto({
    @Default(0) int x,
    @Default(0) int y,
    @Default(false) bool disabled,
    @Default(false) bool isStart,
    @Default(false) bool isFinish,
  }) = _FieldDotDto;

  @override
  FieldDotDto toDto() => this;
}
