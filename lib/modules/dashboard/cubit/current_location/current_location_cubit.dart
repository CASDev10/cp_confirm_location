import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../repositories/current_location_repository.dart';
import '../../widgets/current_location_failure.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit(this.currentLocationRepository)
    : super(CurrentLocationState.initial());
  CurrentLocationRepository currentLocationRepository;

  Future<void> getCurrentLocationLatLng() async {
    try {
      emit(
        state.copyWith(currentLocationStatus: CurrentLocationStatus.loading),
      );
      Position result =
          await currentLocationRepository.getCurrentLocationLatLng();
      emit(
        state.copyWith(
          currentLocationStatus: CurrentLocationStatus.success,
          lat: result.latitude,
          lng: result.longitude,
          address: '',
        ),
      );
    } on CurrentLocationFailure catch (e) {
      emit(
        state.copyWith(
          currentLocationStatus: CurrentLocationStatus.failure,
          exception: e,
        ),
      );
    }
  }
}
