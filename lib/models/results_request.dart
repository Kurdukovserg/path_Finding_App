import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_request.freezed.dart';

part 'results_request.g.dart';

@freezed
class ResultApiRequest with _$ResultApiRequest {
  const ResultApiRequest._();

  const factory ResultApiRequest({
    required String id,
    required Steps result,
  }) = _ResultApiRequest;

  factory ResultApiRequest.fromJson(Map<String, dynamic> json) =>
      _$ResultApiRequestFromJson(json);
}

@freezed
class Steps with _$Steps {
  const Steps._();

  const factory Steps({
    required List<DotModel> steps,
    required String path,
  }) = _Steps;

  factory Steps.fromJson(Map<String, dynamic> json) => _$StepsFromJson(json);
}

@freezed
class DotModel with _$DotModel {
  const DotModel._();

  const factory DotModel({
    @JsonKey(name: 'x') required int x,
    @JsonKey(name: 'y') required int y,
  }) = _DotModel;

  factory DotModel.fromJson(Map<String, dynamic> json) =>
      _$DotModelFromJson(json);
}
