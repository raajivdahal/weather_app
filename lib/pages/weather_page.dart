import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final searchCity = TextEditingController();
  final _weatherService =
      WeatherService(apiKey: "943740cb3514e86b8406917a07f53763");

  Weather? _weather;

  _fetchWeather(city) async {
    String cityName = await _weatherService.getCurrentCity();
    debugPrintStack(label: cityName);

    try {
      final weather = await _weatherService.getWeather(city);

      setState(() {
        _weather = weather;
        print(_weather);
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "dust":
      case "fog":
        return "assets/cloud.json";
      case "shower rain":
        return "assets/rain.json";
      case "thunder storm":
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    _fetchWeather("london");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.red,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.purple[800],
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://wallpaperaccess.com/full/1602615.png"),
                      fit: BoxFit.cover,
                    )),
                padding: EdgeInsets.only(top: 45, left: 15),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _weather?.cityName ?? "Loading",
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_weather?.temprature.round().toString()}' "°C",
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              "It's Sunday",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
