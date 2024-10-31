import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_response.freezed.dart';
part 'results_response.g.dart';

@freezed
class ResultsApiResponce with _$ResultsApiResponce {
  const ResultsApiResponce._();

  const factory ResultsApiResponce({
    @JsonKey(name: 'error') @Default(false) bool error,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') @Default([]) List<ResultData?> resultData,
  }) = _ResultsApiResponce;

  factory ResultsApiResponce.fromJson(Map<String, dynamic> json) =>
      _$ResultsApiResponceFromJson(json);
}

@freezed
class ResultData with _$ResultData {
  const ResultData._();

  @JsonSerializable(includeIfNull: false)
  const factory ResultData({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'correct') @Default(true) correct,
  }) = _ResultData;

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
}
