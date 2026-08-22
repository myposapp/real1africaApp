// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'analytics.dart';

class AnalyticsMapper extends ClassMapperBase<Analytics> {
  AnalyticsMapper._();

  static AnalyticsMapper? _instance;
  static AnalyticsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AnalyticsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Analytics';

  static int _$totalProperties(Analytics v) => v.totalProperties;
  static const Field<Analytics, int> _f$totalProperties = Field(
    'totalProperties',
    _$totalProperties,
  );
  static int _$savedProperties(Analytics v) => v.savedProperties;
  static const Field<Analytics, int> _f$savedProperties = Field(
    'savedProperties',
    _$savedProperties,
  );

  @override
  final MappableFields<Analytics> fields = const {
    #totalProperties: _f$totalProperties,
    #savedProperties: _f$savedProperties,
  };

  static Analytics _instantiate(DecodingData data) {
    return Analytics(
      totalProperties: data.dec(_f$totalProperties),
      savedProperties: data.dec(_f$savedProperties),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Analytics fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Analytics>(map);
  }

  static Analytics fromJson(String json) {
    return ensureInitialized().decodeJson<Analytics>(json);
  }
}

mixin AnalyticsMappable {
  String toJson() {
    return AnalyticsMapper.ensureInitialized().encodeJson<Analytics>(
      this as Analytics,
    );
  }

  Map<String, dynamic> toMap() {
    return AnalyticsMapper.ensureInitialized().encodeMap<Analytics>(
      this as Analytics,
    );
  }

  AnalyticsCopyWith<Analytics, Analytics, Analytics> get copyWith =>
      _AnalyticsCopyWithImpl<Analytics, Analytics>(
        this as Analytics,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AnalyticsMapper.ensureInitialized().stringifyValue(
      this as Analytics,
    );
  }

  @override
  bool operator ==(Object other) {
    return AnalyticsMapper.ensureInitialized().equalsValue(
      this as Analytics,
      other,
    );
  }

  @override
  int get hashCode {
    return AnalyticsMapper.ensureInitialized().hashValue(this as Analytics);
  }
}

extension AnalyticsValueCopy<$R, $Out> on ObjectCopyWith<$R, Analytics, $Out> {
  AnalyticsCopyWith<$R, Analytics, $Out> get $asAnalytics =>
      $base.as((v, t, t2) => _AnalyticsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AnalyticsCopyWith<$R, $In extends Analytics, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? totalProperties, int? savedProperties});
  AnalyticsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AnalyticsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Analytics, $Out>
    implements AnalyticsCopyWith<$R, Analytics, $Out> {
  _AnalyticsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Analytics> $mapper =
      AnalyticsMapper.ensureInitialized();
  @override
  $R call({int? totalProperties, int? savedProperties}) => $apply(
    FieldCopyWithData({
      if (totalProperties != null) #totalProperties: totalProperties,
      if (savedProperties != null) #savedProperties: savedProperties,
    }),
  );
  @override
  Analytics $make(CopyWithData data) => Analytics(
    totalProperties: data.get(#totalProperties, or: $value.totalProperties),
    savedProperties: data.get(#savedProperties, or: $value.savedProperties),
  );

  @override
  AnalyticsCopyWith<$R2, Analytics, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AnalyticsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

