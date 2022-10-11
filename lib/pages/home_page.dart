// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/settings_page.dart';
import 'package:weather_app/widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Weather'),
              actions: [
                IconButton(
                    onPressed: () async {
                      _city = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const SearchPage();
                        }),
                      );
                      print('city: $_city');
                      if (_city != null) {
                        context
                            .read<WeatherBloc>()
                            .add(FetchWeatherEvent(city: _city!));
                      }
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SettingsPage();
                      }));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            body: _showWeather()));
  }

  String showTemprature(double temp) {
    if (context.watch<TempSettingsBloc>().state.tempUnit == TempUnit.celsius) {
      return '${temp.toStringAsFixed(2)}°C';
    } else {
      return '${(temp * 1.8 + 32).toStringAsFixed(2)}°F';
    }
  }

  Widget showIcon(String icon) {
    return Image.network(
      'http://$iconHost/img/wn/$icon@4x.png',
      height: 96,
      width: 96,
    );
  }

  Widget formatText(String desc) {
    final formattedString = desc.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 21.0),
      textAlign: TextAlign.center,
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.customError.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        } else if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == WeatherStatus.error &&
            state.weather.name == '') {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdate)
                      .format(context),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  '(${state.weather.country})',
                  style: const TextStyle(fontSize: 18.0),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemprature(state.weather.temp),
                  style: const TextStyle(
                      fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  children: [
                    Text(
                      showTemprature(state.weather.tempMax),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      showTemprature(state.weather.tempMin),
                      style: const TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                showIcon(state.weather.icon),
                Expanded(flex: 3, child: formatText(state.weather.description)),
                const Spacer(),
              ],
            )
          ],
        );
      },
    );
  }
}
