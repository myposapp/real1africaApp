// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'base_api_response.dart';

class BaseResponseMapper extends ClassMapperBase<BaseResponse> {
  BaseResponseMapper._();

  static BaseResponseMapper? _instance;
  static BaseResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BaseResponseMapper._());
      ResponseMetadataMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BaseResponse';
  @override
  Function get typeFactory =>
      <T>(f) => f<BaseResponse<T>>();

  static bool? _$success(BaseResponse v) => v.success;
  static const Field<BaseResponse, bool> _f$success = Field(
    'success',
    _$success,
    opt: true,
  );
  static String? _$message(BaseResponse v) => v.message;
  static const Field<BaseResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static dynamic _$data(BaseResponse v) => v.data;
  static dynamic _arg$data<T>(f) => f<T>();
  static const Field<BaseResponse, dynamic> _f$data = Field(
    'data',
    _$data,
    opt: true,
    arg: _arg$data,
  );
  static ResponseMetadata? _$metadata(BaseResponse v) => v.metadata;
  static const Field<BaseResponse, ResponseMetadata> _f$metadata = Field(
    'metadata',
    _$metadata,
    opt: true,
  );

  @override
  final MappableFields<BaseResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #data: _f$data,
    #metadata: _f$metadata,
  };

  static BaseResponse<T> _instantiate<T>(DecodingData data) {
    return BaseResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      data: data.dec(_f$data),
      metadata: data.dec(_f$metadata),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BaseResponse<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BaseResponse<T>>(map);
  }

  static BaseResponse<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<BaseResponse<T>>(json);
  }
}

mixin BaseResponseMappable<T> {
  String toJson() {
    return BaseResponseMapper.ensureInitialized().encodeJson<BaseResponse<T>>(
      this as BaseResponse<T>,
    );
  }

  Map<String, dynamic> toMap() {
    return BaseResponseMapper.ensureInitialized().encodeMap<BaseResponse<T>>(
      this as BaseResponse<T>,
    );
  }

  BaseResponseCopyWith<BaseResponse<T>, BaseResponse<T>, BaseResponse<T>, T>
  get copyWith =>
      _BaseResponseCopyWithImpl<BaseResponse<T>, BaseResponse<T>, T>(
        this as BaseResponse<T>,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BaseResponseMapper.ensureInitialized().stringifyValue(
      this as BaseResponse<T>,
    );
  }

  @override
  bool operator ==(Object other) {
    return BaseResponseMapper.ensureInitialized().equalsValue(
      this as BaseResponse<T>,
      other,
    );
  }

  @override
  int get hashCode {
    return BaseResponseMapper.ensureInitialized().hashValue(
      this as BaseResponse<T>,
    );
  }
}

extension BaseResponseValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, BaseResponse<T>, $Out> {
  BaseResponseCopyWith<$R, BaseResponse<T>, $Out, T> get $asBaseResponse =>
      $base.as((v, t, t2) => _BaseResponseCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class BaseResponseCopyWith<$R, $In extends BaseResponse<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  ResponseMetadataCopyWith<$R, ResponseMetadata, ResponseMetadata>?
  get metadata;
  $R call({
    bool? success,
    String? message,
    T? data,
    ResponseMetadata? metadata,
  });
  BaseResponseCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BaseResponseCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, BaseResponse<T>, $Out>
    implements BaseResponseCopyWith<$R, BaseResponse<T>, $Out, T> {
  _BaseResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BaseResponse> $mapper =
      BaseResponseMapper.ensureInitialized();
  @override
  ResponseMetadataCopyWith<$R, ResponseMetadata, ResponseMetadata>?
  get metadata => $value.metadata?.copyWith.$chain((v) => call(metadata: v));
  @override
  $R call({
    Object? success = $none,
    Object? message = $none,
    Object? data = $none,
    Object? metadata = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != $none) #success: success,
      if (message != $none) #message: message,
      if (data != $none) #data: data,
      if (metadata != $none) #metadata: metadata,
    }),
  );
  @override
  BaseResponse<T> $make(CopyWithData data) => BaseResponse(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    data: data.get(#data, or: $value.data),
    metadata: data.get(#metadata, or: $value.metadata),
  );

  @override
  BaseResponseCopyWith<$R2, BaseResponse<T>, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BaseResponseCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

class ResponseMetadataMapper extends ClassMapperBase<ResponseMetadata> {
  ResponseMetadataMapper._();

  static ResponseMetadataMapper? _instance;
  static ResponseMetadataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResponseMetadataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ResponseMetadata';

  static int _$total(ResponseMetadata v) => v.total;
  static const Field<ResponseMetadata, int> _f$total = Field('total', _$total);
  static int _$page(ResponseMetadata v) => v.page;
  static const Field<ResponseMetadata, int> _f$page = Field('page', _$page);
  static int _$pageSize(ResponseMetadata v) => v.pageSize;
  static const Field<ResponseMetadata, int> _f$pageSize = Field(
    'pageSize',
    _$pageSize,
  );
  static int? _$pageCount(ResponseMetadata v) => v.pageCount;
  static const Field<ResponseMetadata, int> _f$pageCount = Field(
    'pageCount',
    _$pageCount,
    opt: true,
  );

  @override
  final MappableFields<ResponseMetadata> fields = const {
    #total: _f$total,
    #page: _f$page,
    #pageSize: _f$pageSize,
    #pageCount: _f$pageCount,
  };

  static ResponseMetadata _instantiate(DecodingData data) {
    return ResponseMetadata(
      total: data.dec(_f$total),
      page: data.dec(_f$page),
      pageSize: data.dec(_f$pageSize),
      pageCount: data.dec(_f$pageCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ResponseMetadata fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ResponseMetadata>(map);
  }

  static ResponseMetadata fromJson(String json) {
    return ensureInitialized().decodeJson<ResponseMetadata>(json);
  }
}

mixin ResponseMetadataMappable {
  String toJson() {
    return ResponseMetadataMapper.ensureInitialized()
        .encodeJson<ResponseMetadata>(this as ResponseMetadata);
  }

  Map<String, dynamic> toMap() {
    return ResponseMetadataMapper.ensureInitialized()
        .encodeMap<ResponseMetadata>(this as ResponseMetadata);
  }

  ResponseMetadataCopyWith<ResponseMetadata, ResponseMetadata, ResponseMetadata>
  get copyWith =>
      _ResponseMetadataCopyWithImpl<ResponseMetadata, ResponseMetadata>(
        this as ResponseMetadata,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ResponseMetadataMapper.ensureInitialized().stringifyValue(
      this as ResponseMetadata,
    );
  }

  @override
  bool operator ==(Object other) {
    return ResponseMetadataMapper.ensureInitialized().equalsValue(
      this as ResponseMetadata,
      other,
    );
  }

  @override
  int get hashCode {
    return ResponseMetadataMapper.ensureInitialized().hashValue(
      this as ResponseMetadata,
    );
  }
}

extension ResponseMetadataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ResponseMetadata, $Out> {
  ResponseMetadataCopyWith<$R, ResponseMetadata, $Out>
  get $asResponseMetadata =>
      $base.as((v, t, t2) => _ResponseMetadataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ResponseMetadataCopyWith<$R, $In extends ResponseMetadata, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? total, int? page, int? pageSize, int? pageCount});
  ResponseMetadataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ResponseMetadataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ResponseMetadata, $Out>
    implements ResponseMetadataCopyWith<$R, ResponseMetadata, $Out> {
  _ResponseMetadataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ResponseMetadata> $mapper =
      ResponseMetadataMapper.ensureInitialized();
  @override
  $R call({int? total, int? page, int? pageSize, Object? pageCount = $none}) =>
      $apply(
        FieldCopyWithData({
          if (total != null) #total: total,
          if (page != null) #page: page,
          if (pageSize != null) #pageSize: pageSize,
          if (pageCount != $none) #pageCount: pageCount,
        }),
      );
  @override
  ResponseMetadata $make(CopyWithData data) => ResponseMetadata(
    total: data.get(#total, or: $value.total),
    page: data.get(#page, or: $value.page),
    pageSize: data.get(#pageSize, or: $value.pageSize),
    pageCount: data.get(#pageCount, or: $value.pageCount),
  );

  @override
  ResponseMetadataCopyWith<$R2, ResponseMetadata, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ResponseMetadataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

