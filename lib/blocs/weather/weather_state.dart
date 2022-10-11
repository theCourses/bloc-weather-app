// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final CustomError customError;

  const WeatherState(
      {required this.status, required this.weather, required this.customError});

  factory WeatherState.initial() {
    return WeatherState(
        status: WeatherStatus.initial,
        weather: Weather.initial(),
        customError: const CustomError());
  }

  @override
  List<Object> get props => [status, weather, customError];

  @override
  bool get stringify => true;

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? customError,
  }) {
    return WeatherState(
        status: status ?? this.status,
        weather: weather ?? this.weather,
        customError: customError ?? this.customError);
  }
}
