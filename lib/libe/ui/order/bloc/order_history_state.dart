part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistorySuccess extends OrderHistoryState {
  final List<OrderEntity> orders;

  const OrderHistorySuccess(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderHistoryError extends OrderHistoryState {
  final AppException e;

  const OrderHistoryError(this.e);
  @override
  List<Object> get props => [e];
}
