part of 'current_location_cubit.dart';

enum CurrentLocationStatus { none, loading, success, failure }

class CurrentLocationState {
  final CurrentLocationStatus currentLocationStatus;
  final CurrentLocationFailure exception;
  double lat;
  double lng;
  String address;

  CurrentLocationState({
    required this.currentLocationStatus,
    required this.exception,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory CurrentLocationState.initial() {
    return CurrentLocationState(
      currentLocationStatus: CurrentLocationStatus.none,
      exception: CurrentLocationFailure(),
      lat: 0.0,
      lng: 0.0,
      address: '',
    );
  }

  CurrentLocationState copyWith({
    CurrentLocationStatus? currentLocationStatus,
    CurrentLocationFailure? exception,
    double? lat,
    double? lng,
    String? address,
  }) {
    return CurrentLocationState(
      currentLocationStatus:
          currentLocationStatus ?? this.currentLocationStatus,
      exception: exception ?? this.exception,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return 'CurrentLocationState{currentLocationStatus: $currentLocationStatus, exception: $exception, lat: $lat, lng: $lng}';
  }
}
