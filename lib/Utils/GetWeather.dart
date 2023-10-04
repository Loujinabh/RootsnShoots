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

Future<Widget> getWeather() async {
  try {
    var location = await getLocation();

    Weather weather = await wf.currentWeatherByLocation(
        location.latitude, location.longitude);

    return WeatherInfo(
      iconData: getWeatherIcon(weather.weatherIcon!),
      temperature: weather.temperature?.celsius ?? 0.0,
      date: weather.date ?? DateTime.now(),
      humidity: weather.humidity ?? 0.0,
      windSpeed: weather.windSpeed ?? 0.0,
      rainLast3Hours: weather.rainLast3Hours ?? 0.0,
      cloudiness: weather.cloudiness ?? 0.0,
      weatherDescription: weather.weatherDescription ?? "",
      fontSize: 18,
      fontColor: AppColors.contrast,
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
