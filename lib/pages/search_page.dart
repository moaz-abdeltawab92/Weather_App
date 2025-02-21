import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //no background color
        backgroundColor:
            BlocProvider.of<WeatherCubit>(context).weatherModel == null
                ? Colors.blue
                : BlocProvider.of<WeatherCubit>(context)
                    .weatherModel!
                    .getThemeColor(),
        title: const Text(
          'Search a city',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            // onChanged will be used in search items for example
            // onSubmitted when you click on علامة الصح ال ف الكيبورد
            onSubmitted: (data) async {
              cityName = data;

              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              label: const Text("Search Now"),
              border: const OutlineInputBorder(),
              hintText: 'Enter a city name',
              suffix: GestureDetector(
                  onTap: () async {
                    WeatherServices services = WeatherServices();
                    WeatherModel? weather =
                        await services.getWeather(cityName: cityName!);
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = cityName;

                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}
