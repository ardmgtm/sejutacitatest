class ResponseData<T> {
  final int totalCount;
  final List<T> data;

  ResponseData({
    required this.totalCount,
    required this.data,
  });
}
