import 'package:cp_confirm_location/modules/dashboard/models/order_detail_response.dart';

enum UpdateLocationStatus { initial, loading, success, error }

class UpdateLocationState {
  final UpdateLocationStatus status;
  final String message;

  const UpdateLocationState({required this.status, required this.message});

  factory UpdateLocationState.initial() {
    return const UpdateLocationState(
      status: UpdateLocationStatus.initial,
      message: '',
    );
  }

  UpdateLocationState copyWith({
    UpdateLocationStatus? status,
    String? message,
    OrderModel? orderModel,
  }) {
    return UpdateLocationState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
