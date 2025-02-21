import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Weather App',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
            return onSuccessBody(weatherData: state.weatherModel);
          } else if (state is WeatherFailure) {
            return const Center(
              child: Text(
                "Sorry, Something went wrong please try again",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            );
          } else {
            return const defaultHomePage();
          }
        },
      ),
    );
  }
}

class defaultHomePage extends StatelessWidget {
  const defaultHomePage({
    super.key,
  });

  @override
  Widget build(context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'There is no weather 😔 ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            'start searching now 🔍',
            style: TextStyle(
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}

class onSuccessBody extends StatelessWidget {
  const onSuccessBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,

          //Colors.orange
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(BlocProvider.of<WeatherCubit>(context).cityName!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
          Text(
              'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
              style: const TextStyle(
                fontSize: 19,
              )),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(weatherData!.temp.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
              Column(
                children: [
                  Text("maxTemp : ${weatherData!.maxTemp.toInt()}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("minTemp :  ${weatherData!.minTemp.toInt()}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            weatherData?.weatherStateName ?? " ",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
