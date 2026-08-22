import 'package:dart_mappable/dart_mappable.dart';

part 'base_api_response.mapper.dart';

@MappableClass()
class BaseResponse<T> with BaseResponseMappable<T> {
  const BaseResponse({this.success, this.message, this.data, this.metadata});

  final bool? success;
  final String? message;
  final T? data;
  final ResponseMetadata? metadata;

  static BaseResponse<T> fromMap<T>(Map<String, dynamic> map) =>
      BaseResponseMapper.fromMap<T>(map);

  static BaseResponse<T> fromJson<T>(String json) =>
      BaseResponseMapper.fromJson<T>(json);
}

@MappableClass()
class ResponseMetadata with ResponseMetadataMappable {
  const ResponseMetadata({
    required this.total,
    required this.page,
    required this.pageSize,
    this.pageCount,
  });

  final int total;
  final int page;
  final int pageSize;
  final int? pageCount;

  static final fromMap = ResponseMetadataMapper.fromMap;
  static final fromJson = ResponseMetadataMapper.fromJson;
}
