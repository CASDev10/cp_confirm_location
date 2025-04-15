import 'package:bloc/bloc.dart';
import 'package:cp_confirm_location/modules/dashboard/models/base_response.dart';
import 'package:cp_confirm_location/modules/dashboard/repositories/dashboard_repository.dart';

import '../../../../core/exceptions/api_error.dart';
import 'confirm_location_state.dart';

class UpdateLocationCubit extends Cubit<UpdateLocationState> {
  final DashboardRepository _repository;

  UpdateLocationCubit(this._repository) : super(UpdateLocationState.initial());

  Future<void> updateLocation(int orderNo, double lat, double lng,String address) async {
    emit(state.copyWith(status: UpdateLocationStatus.loading));

    try {
      BaseResponse response = await _repository.updateLocation(
        orderNo,
        lat,
        lng,
        address
      );
      if (response.success) {
        emit(
          state.copyWith(
            status: UpdateLocationStatus.success,
            message: response.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: UpdateLocationStatus.error,
            message: response.message,
          ),
        );
      }
    } on ApiError catch (e) {
      emit(
        state.copyWith(status: UpdateLocationStatus.error, message: e.message),
      );
    }
  }
}
