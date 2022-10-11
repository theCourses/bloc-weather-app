// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;

  const DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];
    return DirectGeocoding(
        name: data['name'],
        lat: data['lat'],
        lon: data['lon'],
        country: data['country']);
  }

  @override
  List<Object> get props => [name, lat, lon, country];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
    };
  }

  factory DirectGeocoding.fromMap(Map<String, dynamic> map) {
    return DirectGeocoding(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
