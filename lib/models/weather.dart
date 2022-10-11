// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final DateTime lastUpdate;

  const Weather({
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.lastUpdate,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'];
    final main = json['main'];
    return Weather(
        description: weather['description'],
        icon: weather['icon'],
        temp: main['temp'],
        tempMin: main['tempMin'],
        tempMax: main['tempMax'],
        name: '',
        country: '',
        lastUpdate: DateTime.now());
  }

  factory Weather.initial() => Weather(
      description: '',
      icon: '',
      temp: 100.0,
      tempMin: 100.0,
      tempMax: 100.0,
      name: '',
      country: '',
      lastUpdate: DateTime(1970));

  @override
  List<Object> get props {
    return [
      description,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      lastUpdate,
    ];
  }

  @override
  bool get stringify => true;
}
