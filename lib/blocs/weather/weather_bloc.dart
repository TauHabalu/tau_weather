import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tau_weather/blocs/blocs.dart';
import 'package:tau_weather/models/weather.dart';
import 'package:tau_weather/repositories/repositories.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield* _mapWeatherRequestedToState(event);
    } else if (event is WeatherRefreshRequested) {
      yield* _mapWeatherRefreshRequestedToState(event);
    }
  }

  Stream<WeatherState> _mapWeatherRequestedToState(
    WeatherRequested event,
  ) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _mapWeatherRefreshRequestedToState(
    WeatherRefreshRequested event,
  ) async* {
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {}
  }
}
