import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pathfinding/models/field_dot_model.dart';

part 'results_request.freezed.dart';
part 'results_request.g.dart';

@freezed
class ResultApiRequest with _$ResultApiRequest {
  const ResultApiRequest._();

  const factory ResultApiRequest({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'result') required Steps result,
    @JsonKey(name: 'path') required String path,
  }) = _ResultApiRequest;

  factory ResultApiRequest.fromJson(Map<String, dynamic> json) =>
      _$ResultApiRequestFromJson(json);
}

@freezed
class Steps with _$Steps {
  const Steps._();

  const factory Steps({
    @JsonKey(name: 'steps') required List<FieldDotModel> steps,
  }) = _Steps;

  factory Steps.fromJson(Map<String, dynamic> json) => _$StepsFromJson(json);
}
