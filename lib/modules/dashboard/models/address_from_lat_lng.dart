import 'package:geocoding/geocoding.dart';

class AddressFromLatLng {
  final String street;
  final String thoroughfare;
  final String state;
  final String city;
  final String country;

  AddressFromLatLng({
    required this.street,
    required this.thoroughfare,
    required this.state,
    required this.city,
    required this.country,
  });

  factory AddressFromLatLng.fromModel(Placemark placeMark) {
    return AddressFromLatLng(
      street: placeMark.street!.isEmpty ? '' : '${placeMark.street}, ',
      thoroughfare:
          placeMark.thoroughfare!.isEmpty ? '' : '${placeMark.thoroughfare}, ',
      state:
          placeMark.administrativeArea!.isEmpty
              ? ''
              : '${placeMark.administrativeArea}, ',
      city: placeMark.locality!.isEmpty ? '' : '${placeMark.locality}, ',
      country: placeMark.country!.isEmpty ? '' : '${placeMark.country}',
    );
  }
}
