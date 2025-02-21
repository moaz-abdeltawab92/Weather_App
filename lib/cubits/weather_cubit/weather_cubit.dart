import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherServices) : super(WeatherInitial());

  WeatherServices weatherServices;
  String? cityName;
  WeatherModel? weatherModel;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());

    try {
      WeatherModel weatherModel =
          await weatherServices.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherModel: weatherModel));
    } on Exception catch (e) {
      emit(WeatherFailure());
    }
  }
}
