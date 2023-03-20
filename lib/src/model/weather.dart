import 'package:flutter/widgets.dart';

class Weather {
  Map<String, dynamic>? coord;
  List<CloudWeather>? weather;
  String? base;
  WeatherPrimary? main;
  dynamic? visibility;
  dynamic? id;
  String? name;

  Weather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.id,
    this.name,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: json["coord"],
        weather: List<CloudWeather>.from(json["weather"].map((x) => CloudWeather.fromJson(x))),
        base: json["base"],
        main: WeatherPrimary.fromJson(json["main"]),
        visibility: json["visibility"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord,
        "weather": weather,
        "base": base,
        "main": main,
        "visibility": visibility,
        "id": id,
        "name": name,
      };
}

class CloudWeather {
  dynamic? id;
  dynamic? main;
  dynamic? description;
  dynamic? icon;

  CloudWeather({this.id, this.main, this.description, this.icon});

  factory CloudWeather.fromJson(Map<String, dynamic> json) => CloudWeather(
      id: json["id"], main: json["main"], description: json["description"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class WeatherPrimary {
  dynamic? temp;
  dynamic? feels_like;
  dynamic? temp_min;
  dynamic? temp_max;
  dynamic? pressure;
  dynamic? humidity;

  WeatherPrimary(
      {this.temp, this.feels_like, this.temp_min, this.temp_max, this.pressure, this.humidity});

  factory WeatherPrimary.fromJson(Map<String, dynamic> json) => WeatherPrimary(
        temp: json["temp"],
        feels_like: json["feels_like"],
        temp_min: json["temp_min"],
        temp_max: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feels_like,
        "temp_min": temp_min,
        "temp_max": temp_max,
        "pressure": pressure,
        "humidity": humidity,
      };
}
