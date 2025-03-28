import 'package:bloc/bloc.dart';
import 'package:cp_confirm_location/modules/dashboard/models/order_detail_response.dart';
import 'package:cp_confirm_location/modules/dashboard/repositories/dashboard_repository.dart';

import '../../../../core/exceptions/api_error.dart';
import 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final DashboardRepository _repository;

  OrderDetailCubit(this._repository) : super(OrderDetailState.initial());

  Future<void> fetchOrderDetail(int orderNo) async {
    emit(state.copyWith(status: OrderDetailStatus.loading));

    try {
      OrderDetailResponse response = await _repository.fetchOrderDetail(
        orderNo,
      );
      if (response.success) {
        emit(
          state.copyWith(
            status: OrderDetailStatus.success,
            message: response.message,
            orderModel: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: OrderDetailStatus.error,
            message: response.message,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(state.copyWith(status: OrderDetailStatus.error, message: e.message));
    }
  }
}
