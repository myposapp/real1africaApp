// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'kyc_document.dart';

class KycDocumentMapper extends ClassMapperBase<KycDocument> {
  KycDocumentMapper._();

  static KycDocumentMapper? _instance;
  static KycDocumentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KycDocumentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'KycDocument';

  static String _$id(KycDocument v) => v.id;
  static const Field<KycDocument, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String _$type(KycDocument v) => v.type;
  static const Field<KycDocument, String> _f$type = Field('type', _$type);
  static String? _$content(KycDocument v) => v.content;
  static const Field<KycDocument, String> _f$content = Field(
    'content',
    _$content,
    opt: true,
  );
  static String? _$file(KycDocument v) => v.file;
  static const Field<KycDocument, String> _f$file = Field(
    'file',
    _$file,
    opt: true,
  );
  static String? _$status(KycDocument v) => v.status;
  static const Field<KycDocument, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$createdAt(KycDocument v) => v.createdAt;
  static const Field<KycDocument, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$updatedAt(KycDocument v) => v.updatedAt;
  static const Field<KycDocument, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<KycDocument> fields = const {
    #id: _f$id,
    #type: _f$type,
    #content: _f$content,
    #file: _f$file,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static KycDocument _instantiate(DecodingData data) {
    return KycDocument(
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      content: data.dec(_f$content),
      file: data.dec(_f$file),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static KycDocument fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<KycDocument>(map);
  }

  static KycDocument fromJson(String json) {
    return ensureInitialized().decodeJson<KycDocument>(json);
  }
}

mixin KycDocumentMappable {
  String toJson() {
    return KycDocumentMapper.ensureInitialized().encodeJson<KycDocument>(
      this as KycDocument,
    );
  }

  Map<String, dynamic> toMap() {
    return KycDocumentMapper.ensureInitialized().encodeMap<KycDocument>(
      this as KycDocument,
    );
  }

  KycDocumentCopyWith<KycDocument, KycDocument, KycDocument> get copyWith =>
      _KycDocumentCopyWithImpl<KycDocument, KycDocument>(
        this as KycDocument,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return KycDocumentMapper.ensureInitialized().stringifyValue(
      this as KycDocument,
    );
  }

  @override
  bool operator ==(Object other) {
    return KycDocumentMapper.ensureInitialized().equalsValue(
      this as KycDocument,
      other,
    );
  }

  @override
  int get hashCode {
    return KycDocumentMapper.ensureInitialized().hashValue(this as KycDocument);
  }
}

extension KycDocumentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, KycDocument, $Out> {
  KycDocumentCopyWith<$R, KycDocument, $Out> get $asKycDocument =>
      $base.as((v, t, t2) => _KycDocumentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class KycDocumentCopyWith<$R, $In extends KycDocument, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? type,
    String? content,
    String? file,
    String? status,
    String? createdAt,
    String? updatedAt,
  });
  KycDocumentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _KycDocumentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, KycDocument, $Out>
    implements KycDocumentCopyWith<$R, KycDocument, $Out> {
  _KycDocumentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<KycDocument> $mapper =
      KycDocumentMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? type,
    Object? content = $none,
    Object? file = $none,
    Object? status = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (content != $none) #content: content,
      if (file != $none) #file: file,
      if (status != $none) #status: status,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  KycDocument $make(CopyWithData data) => KycDocument(
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    content: data.get(#content, or: $value.content),
    file: data.get(#file, or: $value.file),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  KycDocumentCopyWith<$R2, KycDocument, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _KycDocumentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

