import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cp_confirm_location/modules/dashboard/cubit/geocoding/geocoding_state.dart';
import 'package:http/http.dart' as http;

import '../../models/address_entity.dart';
import '../../repositories/current_location_repository.dart';

class GeocodingCubit extends Cubit<GeocodingLocationState> {
  GeocodingCubit(this.currentLocationRepository)
    : super(GeocodingLocationState.initial());
  CurrentLocationRepository currentLocationRepository;

  void getCurrentLocationLatLng(double lat, double lng) async {
    try {
      emit(state.copyWith(geocodingStatus: GeocodingStatus.loading));
      await Future.delayed(const Duration(seconds: 3));
      String address = await getAddressFromLatLng(lat, lng);
      if (address.isEmpty) {
        emit(
          state.copyWith(
            geocodingStatus: GeocodingStatus.failure,
            exception: Exception('Failed to get address.'),
            isFromPlacesApi: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            geocodingStatus: GeocodingStatus.success,
            addressEntity: AddressEntity(
              address: address,
              city: '',
              state: '',
              country: '',
              lat: lat,
              lng: lng,
            ),
            isFromPlacesApi: false,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          geocodingStatus: GeocodingStatus.failure,
          exception: e,
          isFromPlacesApi: false,
        ),
      );
    }
  }

  void enableFromPlacesApi(AddressEntity addressEntity) {
    emit(
      state.copyWith(
        isFromPlacesApi: true,
        addressEntity: addressEntity,
        geocodingStatus: GeocodingStatus.success,
      ),
    );
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String apiKey = "AIzaSyDipz54vKiH4G86TodW_FZC0DYCQBziS_I";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == "OK") {
          return data["results"][0]["formatted_address"];
        }
      }
    } catch (e) {
      print("Error: $e");
    }
    return "Address not found";
  }
}
