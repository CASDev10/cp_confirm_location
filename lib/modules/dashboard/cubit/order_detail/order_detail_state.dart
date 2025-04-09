import 'package:cp_confirm_location/modules/dashboard/models/order_detail_response.dart';

enum OrderDetailStatus { initial, loading, success, error, noResult }


class OrderDetailState {
  final OrderDetailStatus status;
  final String message;
  final OrderModel? orderModel;

  const OrderDetailState({
    required this.status,
    required this.message,
    required this.orderModel,
  });

  factory OrderDetailState.initial() {
    return const OrderDetailState(
      status: OrderDetailStatus.initial,
      message: '',
      orderModel: null,
    );
  }

  OrderDetailState copyWith({
    OrderDetailStatus? status,
    String? message,
    OrderModel? orderModel,
  }) {
    return OrderDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      orderModel: orderModel ?? this.orderModel,
    );
  }
}
