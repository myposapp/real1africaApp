// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'home_content.dart';

class HomeCategorySummaryMapper extends ClassMapperBase<HomeCategorySummary> {
  HomeCategorySummaryMapper._();

  static HomeCategorySummaryMapper? _instance;
  static HomeCategorySummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeCategorySummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeCategorySummary';

  static String _$id(HomeCategorySummary v) => v.id;
  static const Field<HomeCategorySummary, String> _f$id = Field(
    'id',
    _$id,
    key: r'_id',
  );
  static String? _$parentCategory(HomeCategorySummary v) => v.parentCategory;
  static const Field<HomeCategorySummary, String> _f$parentCategory = Field(
    'parentCategory',
    _$parentCategory,
    key: r'category',
    opt: true,
  );
  static String _$title(HomeCategorySummary v) => v.title;
  static const Field<HomeCategorySummary, String> _f$title = Field(
    'title',
    _$title,
  );
  static String? _$pageTitle(HomeCategorySummary v) => v.pageTitle;
  static const Field<HomeCategorySummary, String> _f$pageTitle = Field(
    'pageTitle',
    _$pageTitle,
    opt: true,
  );
  static String? _$description(HomeCategorySummary v) => v.description;
  static const Field<HomeCategorySummary, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$article(HomeCategorySummary v) => v.article;
  static const Field<HomeCategorySummary, String> _f$article = Field(
    'article',
    _$article,
    opt: true,
  );
  static String _$image(HomeCategorySummary v) => v.image;
  static const Field<HomeCategorySummary, String> _f$image = Field(
    'image',
    _$image,
  );
  static String _$createdAt(HomeCategorySummary v) => v.createdAt;
  static const Field<HomeCategorySummary, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String _$updatedAt(HomeCategorySummary v) => v.updatedAt;
  static const Field<HomeCategorySummary, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
  );
  static int _$count(HomeCategorySummary v) => v.count;
  static const Field<HomeCategorySummary, int> _f$count = Field(
    'count',
    _$count,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<HomeCategorySummary> fields = const {
    #id: _f$id,
    #parentCategory: _f$parentCategory,
    #title: _f$title,
    #pageTitle: _f$pageTitle,
    #description: _f$description,
    #article: _f$article,
    #image: _f$image,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #count: _f$count,
  };

  static HomeCategorySummary _instantiate(DecodingData data) {
    return HomeCategorySummary(
      id: data.dec(_f$id),
      parentCategory: data.dec(_f$parentCategory),
      title: data.dec(_f$title),
      pageTitle: data.dec(_f$pageTitle),
      description: data.dec(_f$description),
      article: data.dec(_f$article),
      image: data.dec(_f$image),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      count: data.dec(_f$count),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeCategorySummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeCategorySummary>(map);
  }

  static HomeCategorySummary fromJson(String json) {
    return ensureInitialized().decodeJson<HomeCategorySummary>(json);
  }
}

mixin HomeCategorySummaryMappable {
  String toJson() {
    return HomeCategorySummaryMapper.ensureInitialized()
        .encodeJson<HomeCategorySummary>(this as HomeCategorySummary);
  }

  Map<String, dynamic> toMap() {
    return HomeCategorySummaryMapper.ensureInitialized()
        .encodeMap<HomeCategorySummary>(this as HomeCategorySummary);
  }

  HomeCategorySummaryCopyWith<
    HomeCategorySummary,
    HomeCategorySummary,
    HomeCategorySummary
  >
  get copyWith =>
      _HomeCategorySummaryCopyWithImpl<
        HomeCategorySummary,
        HomeCategorySummary
      >(this as HomeCategorySummary, $identity, $identity);
  @override
  String toString() {
    return HomeCategorySummaryMapper.ensureInitialized().stringifyValue(
      this as HomeCategorySummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeCategorySummaryMapper.ensureInitialized().equalsValue(
      this as HomeCategorySummary,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeCategorySummaryMapper.ensureInitialized().hashValue(
      this as HomeCategorySummary,
    );
  }
}

extension HomeCategorySummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeCategorySummary, $Out> {
  HomeCategorySummaryCopyWith<$R, HomeCategorySummary, $Out>
  get $asHomeCategorySummary => $base.as(
    (v, t, t2) => _HomeCategorySummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HomeCategorySummaryCopyWith<
  $R,
  $In extends HomeCategorySummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? parentCategory,
    String? title,
    String? pageTitle,
    String? description,
    String? article,
    String? image,
    String? createdAt,
    String? updatedAt,
    int? count,
  });
  HomeCategorySummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HomeCategorySummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeCategorySummary, $Out>
    implements HomeCategorySummaryCopyWith<$R, HomeCategorySummary, $Out> {
  _HomeCategorySummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeCategorySummary> $mapper =
      HomeCategorySummaryMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    Object? parentCategory = $none,
    String? title,
    Object? pageTitle = $none,
    Object? description = $none,
    Object? article = $none,
    String? image,
    String? createdAt,
    String? updatedAt,
    int? count,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (parentCategory != $none) #parentCategory: parentCategory,
      if (title != null) #title: title,
      if (pageTitle != $none) #pageTitle: pageTitle,
      if (description != $none) #description: description,
      if (article != $none) #article: article,
      if (image != null) #image: image,
      if (createdAt != null) #createdAt: createdAt,
      if (updatedAt != null) #updatedAt: updatedAt,
      if (count != null) #count: count,
    }),
  );
  @override
  HomeCategorySummary $make(CopyWithData data) => HomeCategorySummary(
    id: data.get(#id, or: $value.id),
    parentCategory: data.get(#parentCategory, or: $value.parentCategory),
    title: data.get(#title, or: $value.title),
    pageTitle: data.get(#pageTitle, or: $value.pageTitle),
    description: data.get(#description, or: $value.description),
    article: data.get(#article, or: $value.article),
    image: data.get(#image, or: $value.image),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    count: data.get(#count, or: $value.count),
  );

  @override
  HomeCategorySummaryCopyWith<$R2, HomeCategorySummary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _HomeCategorySummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeStateSummaryMapper extends ClassMapperBase<HomeStateSummary> {
  HomeStateSummaryMapper._();

  static HomeStateSummaryMapper? _instance;
  static HomeStateSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeStateSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeStateSummary';

  static String _$state(HomeStateSummary v) => v.state;
  static const Field<HomeStateSummary, String> _f$state = Field(
    'state',
    _$state,
    key: r'_id',
  );
  static int _$count(HomeStateSummary v) => v.count;
  static const Field<HomeStateSummary, int> _f$count = Field('count', _$count);

  @override
  final MappableFields<HomeStateSummary> fields = const {
    #state: _f$state,
    #count: _f$count,
  };

  static HomeStateSummary _instantiate(DecodingData data) {
    return HomeStateSummary(
      state: data.dec(_f$state),
      count: data.dec(_f$count),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeStateSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeStateSummary>(map);
  }

  static HomeStateSummary fromJson(String json) {
    return ensureInitialized().decodeJson<HomeStateSummary>(json);
  }
}

mixin HomeStateSummaryMappable {
  String toJson() {
    return HomeStateSummaryMapper.ensureInitialized()
        .encodeJson<HomeStateSummary>(this as HomeStateSummary);
  }

  Map<String, dynamic> toMap() {
    return HomeStateSummaryMapper.ensureInitialized()
        .encodeMap<HomeStateSummary>(this as HomeStateSummary);
  }

  HomeStateSummaryCopyWith<HomeStateSummary, HomeStateSummary, HomeStateSummary>
  get copyWith =>
      _HomeStateSummaryCopyWithImpl<HomeStateSummary, HomeStateSummary>(
        this as HomeStateSummary,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeStateSummaryMapper.ensureInitialized().stringifyValue(
      this as HomeStateSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeStateSummaryMapper.ensureInitialized().equalsValue(
      this as HomeStateSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeStateSummaryMapper.ensureInitialized().hashValue(
      this as HomeStateSummary,
    );
  }
}

extension HomeStateSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeStateSummary, $Out> {
  HomeStateSummaryCopyWith<$R, HomeStateSummary, $Out>
  get $asHomeStateSummary =>
      $base.as((v, t, t2) => _HomeStateSummaryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeStateSummaryCopyWith<$R, $In extends HomeStateSummary, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? state, int? count});
  HomeStateSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HomeStateSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeStateSummary, $Out>
    implements HomeStateSummaryCopyWith<$R, HomeStateSummary, $Out> {
  _HomeStateSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeStateSummary> $mapper =
      HomeStateSummaryMapper.ensureInitialized();
  @override
  $R call({String? state, int? count}) => $apply(
    FieldCopyWithData({
      if (state != null) #state: state,
      if (count != null) #count: count,
    }),
  );
  @override
  HomeStateSummary $make(CopyWithData data) => HomeStateSummary(
    state: data.get(#state, or: $value.state),
    count: data.get(#count, or: $value.count),
  );

  @override
  HomeStateSummaryCopyWith<$R2, HomeStateSummary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeStateSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeShelfSortMapper extends ClassMapperBase<HomeShelfSort> {
  HomeShelfSortMapper._();

  static HomeShelfSortMapper? _instance;
  static HomeShelfSortMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeShelfSortMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HomeShelfSort';

  static String _$key(HomeShelfSort v) => v.key;
  static const Field<HomeShelfSort, String> _f$key = Field('key', _$key);
  static int _$value(HomeShelfSort v) => v.value;
  static const Field<HomeShelfSort, int> _f$value = Field('value', _$value);

  @override
  final MappableFields<HomeShelfSort> fields = const {
    #key: _f$key,
    #value: _f$value,
  };

  static HomeShelfSort _instantiate(DecodingData data) {
    return HomeShelfSort(key: data.dec(_f$key), value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static HomeShelfSort fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeShelfSort>(map);
  }

  static HomeShelfSort fromJson(String json) {
    return ensureInitialized().decodeJson<HomeShelfSort>(json);
  }
}

mixin HomeShelfSortMappable {
  String toJson() {
    return HomeShelfSortMapper.ensureInitialized().encodeJson<HomeShelfSort>(
      this as HomeShelfSort,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeShelfSortMapper.ensureInitialized().encodeMap<HomeShelfSort>(
      this as HomeShelfSort,
    );
  }

  HomeShelfSortCopyWith<HomeShelfSort, HomeShelfSort, HomeShelfSort>
  get copyWith => _HomeShelfSortCopyWithImpl<HomeShelfSort, HomeShelfSort>(
    this as HomeShelfSort,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return HomeShelfSortMapper.ensureInitialized().stringifyValue(
      this as HomeShelfSort,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeShelfSortMapper.ensureInitialized().equalsValue(
      this as HomeShelfSort,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeShelfSortMapper.ensureInitialized().hashValue(
      this as HomeShelfSort,
    );
  }
}

extension HomeShelfSortValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeShelfSort, $Out> {
  HomeShelfSortCopyWith<$R, HomeShelfSort, $Out> get $asHomeShelfSort =>
      $base.as((v, t, t2) => _HomeShelfSortCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeShelfSortCopyWith<$R, $In extends HomeShelfSort, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? key, int? value});
  HomeShelfSortCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeShelfSortCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeShelfSort, $Out>
    implements HomeShelfSortCopyWith<$R, HomeShelfSort, $Out> {
  _HomeShelfSortCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeShelfSort> $mapper =
      HomeShelfSortMapper.ensureInitialized();
  @override
  $R call({String? key, int? value}) => $apply(
    FieldCopyWithData({
      if (key != null) #key: key,
      if (value != null) #value: value,
    }),
  );
  @override
  HomeShelfSort $make(CopyWithData data) => HomeShelfSort(
    key: data.get(#key, or: $value.key),
    value: data.get(#value, or: $value.value),
  );

  @override
  HomeShelfSortCopyWith<$R2, HomeShelfSort, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeShelfSortCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeShelfMapper extends ClassMapperBase<HomeShelf> {
  HomeShelfMapper._();

  static HomeShelfMapper? _instance;
  static HomeShelfMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeShelfMapper._());
      HomeShelfSortMapper.ensureInitialized();
      PropertyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeShelf';

  static String? _$eyebrow(HomeShelf v) => v.eyebrow;
  static const Field<HomeShelf, String> _f$eyebrow = Field(
    'eyebrow',
    _$eyebrow,
    opt: true,
  );
  static String _$title(HomeShelf v) => v.title;
  static const Field<HomeShelf, String> _f$title = Field('title', _$title);
  static String? _$description(HomeShelf v) => v.description;
  static const Field<HomeShelf, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$filterMode(HomeShelf v) => v.filterMode;
  static const Field<HomeShelf, String> _f$filterMode = Field(
    'filterMode',
    _$filterMode,
    opt: true,
  );
  static List<dynamic> _$filters(HomeShelf v) => v.filters;
  static const Field<HomeShelf, List<dynamic>> _f$filters = Field(
    'filters',
    _$filters,
    opt: true,
    def: const [],
  );
  static HomeShelfSort? _$sort(HomeShelf v) => v.sort;
  static const Field<HomeShelf, HomeShelfSort> _f$sort = Field(
    'sort',
    _$sort,
    opt: true,
  );
  static int? _$limit(HomeShelf v) => v.limit;
  static const Field<HomeShelf, int> _f$limit = Field(
    'limit',
    _$limit,
    opt: true,
  );
  static String _$id(HomeShelf v) => v.id;
  static const Field<HomeShelf, String> _f$id = Field('id', _$id, key: r'_id');
  static String _$type(HomeShelf v) => v.type;
  static const Field<HomeShelf, String> _f$type = Field('type', _$type);
  static List<Property> _$items(HomeShelf v) => v.items;
  static const Field<HomeShelf, List<Property>> _f$items = Field(
    'items',
    _$items,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<HomeShelf> fields = const {
    #eyebrow: _f$eyebrow,
    #title: _f$title,
    #description: _f$description,
    #filterMode: _f$filterMode,
    #filters: _f$filters,
    #sort: _f$sort,
    #limit: _f$limit,
    #id: _f$id,
    #type: _f$type,
    #items: _f$items,
  };

  static HomeShelf _instantiate(DecodingData data) {
    return HomeShelf(
      eyebrow: data.dec(_f$eyebrow),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      filterMode: data.dec(_f$filterMode),
      filters: data.dec(_f$filters),
      sort: data.dec(_f$sort),
      limit: data.dec(_f$limit),
      id: data.dec(_f$id),
      type: data.dec(_f$type),
      items: data.dec(_f$items),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeShelf fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeShelf>(map);
  }

  static HomeShelf fromJson(String json) {
    return ensureInitialized().decodeJson<HomeShelf>(json);
  }
}

mixin HomeShelfMappable {
  String toJson() {
    return HomeShelfMapper.ensureInitialized().encodeJson<HomeShelf>(
      this as HomeShelf,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeShelfMapper.ensureInitialized().encodeMap<HomeShelf>(
      this as HomeShelf,
    );
  }

  HomeShelfCopyWith<HomeShelf, HomeShelf, HomeShelf> get copyWith =>
      _HomeShelfCopyWithImpl<HomeShelf, HomeShelf>(
        this as HomeShelf,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeShelfMapper.ensureInitialized().stringifyValue(
      this as HomeShelf,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeShelfMapper.ensureInitialized().equalsValue(
      this as HomeShelf,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeShelfMapper.ensureInitialized().hashValue(this as HomeShelf);
  }
}

extension HomeShelfValueCopy<$R, $Out> on ObjectCopyWith<$R, HomeShelf, $Out> {
  HomeShelfCopyWith<$R, HomeShelf, $Out> get $asHomeShelf =>
      $base.as((v, t, t2) => _HomeShelfCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeShelfCopyWith<$R, $In extends HomeShelf, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?> get filters;
  HomeShelfSortCopyWith<$R, HomeShelfSort, HomeShelfSort>? get sort;
  ListCopyWith<$R, Property, PropertyCopyWith<$R, Property, Property>>
  get items;
  $R call({
    String? eyebrow,
    String? title,
    String? description,
    String? filterMode,
    List<dynamic>? filters,
    HomeShelfSort? sort,
    int? limit,
    String? id,
    String? type,
    List<Property>? items,
  });
  HomeShelfCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeShelfCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeShelf, $Out>
    implements HomeShelfCopyWith<$R, HomeShelf, $Out> {
  _HomeShelfCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeShelf> $mapper =
      HomeShelfMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>
  get filters => ListCopyWith(
    $value.filters,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(filters: v),
  );
  @override
  HomeShelfSortCopyWith<$R, HomeShelfSort, HomeShelfSort>? get sort =>
      $value.sort?.copyWith.$chain((v) => call(sort: v));
  @override
  ListCopyWith<$R, Property, PropertyCopyWith<$R, Property, Property>>
  get items => ListCopyWith(
    $value.items,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(items: v),
  );
  @override
  $R call({
    Object? eyebrow = $none,
    String? title,
    Object? description = $none,
    Object? filterMode = $none,
    List<dynamic>? filters,
    Object? sort = $none,
    Object? limit = $none,
    String? id,
    String? type,
    List<Property>? items,
  }) => $apply(
    FieldCopyWithData({
      if (eyebrow != $none) #eyebrow: eyebrow,
      if (title != null) #title: title,
      if (description != $none) #description: description,
      if (filterMode != $none) #filterMode: filterMode,
      if (filters != null) #filters: filters,
      if (sort != $none) #sort: sort,
      if (limit != $none) #limit: limit,
      if (id != null) #id: id,
      if (type != null) #type: type,
      if (items != null) #items: items,
    }),
  );
  @override
  HomeShelf $make(CopyWithData data) => HomeShelf(
    eyebrow: data.get(#eyebrow, or: $value.eyebrow),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    filterMode: data.get(#filterMode, or: $value.filterMode),
    filters: data.get(#filters, or: $value.filters),
    sort: data.get(#sort, or: $value.sort),
    limit: data.get(#limit, or: $value.limit),
    id: data.get(#id, or: $value.id),
    type: data.get(#type, or: $value.type),
    items: data.get(#items, or: $value.items),
  );

  @override
  HomeShelfCopyWith<$R2, HomeShelf, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeShelfCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HomeContentMapper extends ClassMapperBase<HomeContent> {
  HomeContentMapper._();

  static HomeContentMapper? _instance;
  static HomeContentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HomeContentMapper._());
      HomeCategorySummaryMapper.ensureInitialized();
      HomeStateSummaryMapper.ensureInitialized();
      HomeShelfMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'HomeContent';

  static List<HomeCategorySummary> _$categories(HomeContent v) => v.categories;
  static const Field<HomeContent, List<HomeCategorySummary>> _f$categories =
      Field('categories', _$categories, opt: true, def: const []);
  static int _$propertyCount(HomeContent v) => v.propertyCount;
  static const Field<HomeContent, int> _f$propertyCount = Field(
    'propertyCount',
    _$propertyCount,
  );
  static int _$agentCount(HomeContent v) => v.agentCount;
  static const Field<HomeContent, int> _f$agentCount = Field(
    'agentCount',
    _$agentCount,
  );
  static List<HomeStateSummary> _$states(HomeContent v) => v.states;
  static const Field<HomeContent, List<HomeStateSummary>> _f$states = Field(
    'states',
    _$states,
    opt: true,
    def: const [],
  );
  static List<HomeShelf> _$shelves(HomeContent v) => v.shelves;
  static const Field<HomeContent, List<HomeShelf>> _f$shelves = Field(
    'shelves',
    _$shelves,
    opt: true,
    def: const [],
  );

  @override
  final MappableFields<HomeContent> fields = const {
    #categories: _f$categories,
    #propertyCount: _f$propertyCount,
    #agentCount: _f$agentCount,
    #states: _f$states,
    #shelves: _f$shelves,
  };

  static HomeContent _instantiate(DecodingData data) {
    return HomeContent(
      categories: data.dec(_f$categories),
      propertyCount: data.dec(_f$propertyCount),
      agentCount: data.dec(_f$agentCount),
      states: data.dec(_f$states),
      shelves: data.dec(_f$shelves),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HomeContent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HomeContent>(map);
  }

  static HomeContent fromJson(String json) {
    return ensureInitialized().decodeJson<HomeContent>(json);
  }
}

mixin HomeContentMappable {
  String toJson() {
    return HomeContentMapper.ensureInitialized().encodeJson<HomeContent>(
      this as HomeContent,
    );
  }

  Map<String, dynamic> toMap() {
    return HomeContentMapper.ensureInitialized().encodeMap<HomeContent>(
      this as HomeContent,
    );
  }

  HomeContentCopyWith<HomeContent, HomeContent, HomeContent> get copyWith =>
      _HomeContentCopyWithImpl<HomeContent, HomeContent>(
        this as HomeContent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HomeContentMapper.ensureInitialized().stringifyValue(
      this as HomeContent,
    );
  }

  @override
  bool operator ==(Object other) {
    return HomeContentMapper.ensureInitialized().equalsValue(
      this as HomeContent,
      other,
    );
  }

  @override
  int get hashCode {
    return HomeContentMapper.ensureInitialized().hashValue(this as HomeContent);
  }
}

extension HomeContentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HomeContent, $Out> {
  HomeContentCopyWith<$R, HomeContent, $Out> get $asHomeContent =>
      $base.as((v, t, t2) => _HomeContentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HomeContentCopyWith<$R, $In extends HomeContent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HomeCategorySummary,
    HomeCategorySummaryCopyWith<$R, HomeCategorySummary, HomeCategorySummary>
  >
  get categories;
  ListCopyWith<
    $R,
    HomeStateSummary,
    HomeStateSummaryCopyWith<$R, HomeStateSummary, HomeStateSummary>
  >
  get states;
  ListCopyWith<$R, HomeShelf, HomeShelfCopyWith<$R, HomeShelf, HomeShelf>>
  get shelves;
  $R call({
    List<HomeCategorySummary>? categories,
    int? propertyCount,
    int? agentCount,
    List<HomeStateSummary>? states,
    List<HomeShelf>? shelves,
  });
  HomeContentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HomeContentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HomeContent, $Out>
    implements HomeContentCopyWith<$R, HomeContent, $Out> {
  _HomeContentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HomeContent> $mapper =
      HomeContentMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    HomeCategorySummary,
    HomeCategorySummaryCopyWith<$R, HomeCategorySummary, HomeCategorySummary>
  >
  get categories => ListCopyWith(
    $value.categories,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(categories: v),
  );
  @override
  ListCopyWith<
    $R,
    HomeStateSummary,
    HomeStateSummaryCopyWith<$R, HomeStateSummary, HomeStateSummary>
  >
  get states => ListCopyWith(
    $value.states,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(states: v),
  );
  @override
  ListCopyWith<$R, HomeShelf, HomeShelfCopyWith<$R, HomeShelf, HomeShelf>>
  get shelves => ListCopyWith(
    $value.shelves,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(shelves: v),
  );
  @override
  $R call({
    List<HomeCategorySummary>? categories,
    int? propertyCount,
    int? agentCount,
    List<HomeStateSummary>? states,
    List<HomeShelf>? shelves,
  }) => $apply(
    FieldCopyWithData({
      if (categories != null) #categories: categories,
      if (propertyCount != null) #propertyCount: propertyCount,
      if (agentCount != null) #agentCount: agentCount,
      if (states != null) #states: states,
      if (shelves != null) #shelves: shelves,
    }),
  );
  @override
  HomeContent $make(CopyWithData data) => HomeContent(
    categories: data.get(#categories, or: $value.categories),
    propertyCount: data.get(#propertyCount, or: $value.propertyCount),
    agentCount: data.get(#agentCount, or: $value.agentCount),
    states: data.get(#states, or: $value.states),
    shelves: data.get(#shelves, or: $value.shelves),
  );

  @override
  HomeContentCopyWith<$R2, HomeContent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HomeContentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

