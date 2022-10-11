// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  const FetchWeatherEvent({
    required this.city,
  });

  @override
  String toString() => 'FetchWeatherEvent(city: $city)';

  @override
  List<Object> get props => [city];

  FetchWeatherEvent copyWith({
    String? city,
  }) {
    return FetchWeatherEvent(
      city: city ?? this.city,
    );
  }
}
