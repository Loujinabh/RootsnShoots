import 'package:flutter/material.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Config/Keys.dart';
import 'package:plant_diary/Utils/GetLocation.dart';
import 'package:plant_diary/Widgets/PageHelpers/WeatherInfo.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

WeatherFactory wf = WeatherFactory(Keys.weatherKey);

IconData getWeatherIcon(String weatherConditionCode) {
  switch (weatherConditionCode) {
    case "01d":
      return WeatherIcons.day_sunny;
    case "02d":
      return WeatherIcons.day_cloudy;
    case "03d":
      return WeatherIcons.cloudy_windy;
    case "04d":
      return WeatherIcons.cloudy;
    case "09d":
      return WeatherIcons.showers;
    case "10d":
      return WeatherIcons.rain;
    case "11d":
      return WeatherIcons.thunderstorm;
    case "13d":
      return WeatherIcons.snow;
    case "50d":
      return WeatherIcons.fog;
    default:
      return WeatherIcons.day_sunny_overcast;
  }
}

class WeatherDisplay {
  WeatherDisplay(
      {required this.weather, required this.color, required this.icon});
  Weather weather;
  Color color;
  IconData icon;
}

Future<Widget> getWeather() async {
  try {
    var location = await getLocation();

    Weather weather = await wf.currentWeatherByLocation(
        location.latitude, location.longitude);

    List<Weather> weathers = await wf.fiveDayForecastByLocation(
        location.latitude, location.longitude);

    List<Weather> weathersFiltered = weathers
        .where((element) => element.date!.hour == DateTime(2020, 1, 1).hour)
        .toList();

    weathersFiltered.insert(0, weather);

    List<WeatherDisplay> displays = weathersFiltered.asMap().entries.map((e) {
      int index = e.key;
      Weather item = e.value;

      Color color = index == 0
          ? AppColors.contrast
          : AppColors.contrast.withOpacity(0.75);
      IconData icon = getWeatherIcon(item.weatherIcon!);

      return WeatherDisplay(weather: item, color: color, icon: icon);
    }).toList();

    return WeatherInfo(
      weatherList: displays,
      fontSize: 15,
    );
  } catch (e) {
    return Center(
      child: Text(
        "Error fetching weather: $e",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.contrast,
        ),
      ),
    );
  }
}
