import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  final IconData iconData;
  final double temperature;
  final DateTime date;
  final double humidity;
  final double windSpeed;
  final double rainLast3Hours;
  final double cloudiness;
  final String weatherDescription;
  final double fontSize;
  final Color fontColor;

  const WeatherInfo({
    super.key,
    required this.iconData,
    required this.temperature,
    required this.date,
    required this.humidity,
    required this.windSpeed,
    required this.rainLast3Hours,
    required this.cloudiness,
    required this.weatherDescription,
    required this.fontSize,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          iconData,
          color: fontColor,
          size: fontSize * 3,
        ),
        SizedBox(height: fontSize * 2),
        Text(
          'Date: ${date.toLocal()}',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Temperature: ${temperature.toStringAsFixed(2)}°C',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Humidity: ${humidity.toStringAsFixed(2)}%',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Wind Speed: ${windSpeed.toStringAsFixed(2)} m/s',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Rain (Last 3 Hours): ${rainLast3Hours.toStringAsFixed(2)} mm',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Cloudiness: ${cloudiness.toStringAsFixed(2)}%',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
        Text(
          'Description: $weatherDescription',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
      ],
    );
  }
}
