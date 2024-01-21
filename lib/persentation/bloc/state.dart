

import 'package:equatable/equatable.dart';

enum PageStatus {
  none,
  loading,
  loadingMore,
  ready,
  error,
}

class BlocState<T> extends Equatable {
  final T data;
  final PageStatus status;
  final String? error;

  const BlocState._({
    required this.data,
    this.status = PageStatus.none,
    this.error,
  });

  factory BlocState.initial(T bootstrapData) =>
      BlocState._(data: bootstrapData);

  bool get isLoading => status == PageStatus.loading;

  bool get isReady => status == PageStatus.ready;

  bool get isError => error != null && status == PageStatus.error;

  bool get isLoadingMore => status == PageStatus.loadingMore;

  String getError() => error ?? "";

  BlocState<T> copyWith({
    T? data,
    String? error,
    PageStatus? status,
  }) {
    return BlocState<T>._(
      data: data ?? this.data,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        data,
        error,
        status,
      ];
}
