import 'package:cp_confirm_location/modules/dashboard/widgets/current_location_failure.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/address_entity.dart';
import '../models/address_from_lat_lng.dart';

class CurrentLocationRepository {
  Future<Position> getCurrentLocationLatLng() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ServiceDisableFailure();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw DeniedFailure();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw PermanentDeniedFailure();
    }
    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      if (e.toString() == 'The location service on the device is disabled.') {
        throw DialogServiceNotEnabled();
      }
      throw e;
    }
  }

  Future<AddressEntity?> getAddressFromLatLng({
    required double lat,
    required double lng,
  }) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);

      if (placeMarks.isEmpty) {
        throw Exception("No address found for the given coordinates.");
      }

      Placemark placeMark = placeMarks.first;
      AddressFromLatLng model = AddressFromLatLng.fromModel(placeMark);

      String formattedAddress =
          '${model.street ?? ''}, ${model.thoroughfare ?? ''}, ${model.state ?? ''}, ${model.city ?? ''}, ${model.country ?? ''}';

      return AddressEntity(
        address: formattedAddress,
        lat: lat,
        lng: lng,
        city: model.city ?? '',
        state: model.state ?? '',
        country: model.country ?? '',
      );
    } catch (e) {
      print("Error fetching address: $e");
      return null; // Return null or handle it based on your app's logic
    }
  }
}
