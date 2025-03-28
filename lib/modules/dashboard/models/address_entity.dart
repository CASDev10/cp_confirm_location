class AddressEntity {
  final String address;
  final String city;
  final String country;
  final String state;
  final double lat;
  final double lng;

  AddressEntity({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.lat,
    required this.lng,
  });

  factory AddressEntity.empty() => AddressEntity(
      address: '', city: '', state: '', country: '', lat: 0.0, lng: 0.0);

  @override
  String toString() {
    return 'AddressEntity{address: $address, city:$city, state:$state, country:$country lat: $lat, lng: $lng}';
  }
}
