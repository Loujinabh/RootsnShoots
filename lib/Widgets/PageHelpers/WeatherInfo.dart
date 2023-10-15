import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_diary/API/GetWeather.dart';

class WeatherInfo extends StatelessWidget {
  final List<WeatherDisplay> weatherList;
  final double fontSize;

  const WeatherInfo({
    super.key,
    required this.weatherList,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          weatherList.length - 1,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: fontSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat('d. MMM').format(weatherList[index].weather.date!),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: weatherList[index].color,
                  ),
                ),
                SizedBox(
                  height: fontSize * 0.5,
                ),
                Icon(
                  weatherList[index].icon,
                  color: weatherList[index].color,
                  size: fontSize * 2.75,
                ),
                SizedBox(
                  height: fontSize * 1.25,
                ),
                Text(
                  '${weatherList[index].weather.temperature!.celsius!.toInt().toString()}°C',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: weatherList[index].color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
