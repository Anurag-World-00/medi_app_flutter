class UiState<T> {
  final bool isLoading;
  final T? data;
  final String? error;

  UiState._({
    this.isLoading = false,
    this.data,
    this.error,
  }); // 👈 private constructor
  factory UiState.idle() => UiState._();

  factory UiState.loading() => UiState._(isLoading: true);

  factory UiState.success(T data) => UiState._(data: data);

  factory UiState.error(String error) => UiState._(error: error);
}
