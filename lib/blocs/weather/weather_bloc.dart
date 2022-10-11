// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : super(WeatherState.initial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(state.copyWith(status: WeatherStatus.loading));
      try {
        final Weather weather =
            await weatherRepository.fetchWeather(event.city);
        emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
        // ignore: avoid_print
        print('state: $state');
      } on CustomError catch (e) {
        emit(state.copyWith(status: WeatherStatus.error, customError: e));
      }
    });
  }
}
