import 'package:cp_confirm_location/modules/dashboard/models/address_entity.dart';

enum GeocodingStatus { none, loading, success, failure }

class GeocodingLocationState {
  final GeocodingStatus geocodingStatus;
  final Exception exception;
  AddressEntity addressEntity;
  bool isFromPlacesApi;

  GeocodingLocationState({
    required this.geocodingStatus,
    required this.addressEntity,
    required this.exception,
    required this.isFromPlacesApi,
  });

  factory GeocodingLocationState.initial() {
    return GeocodingLocationState(
      geocodingStatus: GeocodingStatus.none,
      addressEntity: AddressEntity.empty(),
      exception: new Exception(),
      isFromPlacesApi: false,
    );
  }

  GeocodingLocationState copyWith({
    GeocodingStatus? geocodingStatus,
    AddressEntity? addressEntity,
    Exception? exception,
    bool? isFromPlacesApi,
  }) {
    return GeocodingLocationState(
      geocodingStatus: geocodingStatus ?? this.geocodingStatus,
      addressEntity: addressEntity ?? this.addressEntity,
      exception: exception ?? this.exception,
      isFromPlacesApi: isFromPlacesApi ?? this.isFromPlacesApi,
    );
  }
}
