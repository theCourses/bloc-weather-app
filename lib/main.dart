import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:weather_app/blocs/theme/theme_bloc.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(
                  weatherRepository: context.read<WeatherRepository>())),
          BlocProvider<TempSettingsBloc>(
              create: (context) => TempSettingsBloc()),
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc())
        ],
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.weather.temp > 5) {
              context
                  .read<ThemeBloc>()
                  .add(const ChangeThemeEvent(appTheme: AppTheme.light));
            } else {
              context
                  .read<ThemeBloc>()
                  .add(const ChangeThemeEvent(appTheme: AppTheme.dark));
            }
          },
          builder: (context, state) {
            return MaterialApp(
              title: 'Weather app',
              debugShowCheckedModeBanner: false,
              theme: context.watch<ThemeBloc>().state.appTheme == AppTheme.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
