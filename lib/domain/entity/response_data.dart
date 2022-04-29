class ResponseData<T> {
  final int type;
  final int totalCount;
  final List<T> data;
  final int page;
  final int maxPage;
  final String query;

  ResponseData({
    required this.type,
    required this.totalCount,
    required this.data,
    required this.page,
    required this.maxPage,
    required this.query,
  });

  factory ResponseData.empty() => ResponseData(
        type: 0,
        totalCount: 0,
        data: [],
        page: 0,
        maxPage: 0,
        query: '',
      );

  ResponseData copyWith({
    int? type,
    int? totalCount,
    List<T>? data,
    int? page,
    int? maxPage,
    String? query,
  }) =>
      ResponseData(
        type: type ?? this.type,
        totalCount: totalCount ?? this.totalCount,
        data: data ?? this.data,
        page: page ?? this.page,
        maxPage: maxPage ?? this.maxPage,
        query: query ?? this.query,
      );
}
