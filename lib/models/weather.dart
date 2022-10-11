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
        description: weather[0]['description'],
        icon: weather[0]['icon'],
        temp: main['temp'],
        tempMin: main['temp_min'],
        tempMax: main['temp_max'],
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

  Weather copyWith({
    String? description,
    String? icon,
    double? temp,
    double? tempMin,
    double? tempMax,
    String? name,
    String? country,
    DateTime? lastUpdate,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}
