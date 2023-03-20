import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyek_example/src/model/weather.dart';
import 'package:proyek_example/src/util/apimanager.dart';
import 'package:proyek_example/src/util/keyapi.dart';

class WeatherCheck extends StatefulWidget {
  const WeatherCheck({super.key});

  @override
  State<WeatherCheck> createState() => _WeatherCheckState();
}

class _WeatherCheckState extends State<WeatherCheck> {
  Weather? _result;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    permissionCheck();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    checkLocation();
    super.didChangeDependencies();
  }

  Future<void> permissionCheck() async {
    var statusPermission = await Permission.location.status;
    if (statusPermission.isDenied) {
      if (await Permission.location.request().isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Lokasi Diijinkan!",
        )));
        await checkLocation();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Lokasi Diijinkan!",
      )));
      await checkLocation();
    }
  }

  Future<void> checkLocation() async {
    var locationStatus = await Geolocator.isLocationServiceEnabled();
    if (!locationStatus) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Lokasi Mati!",
      )));
    } else {
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print(position.latitude);
      }
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    }
  }

  Future<void> fetchWeatherApi() async {
    await checkLocation();
    if (kDebugMode) {
      print(_latitude);
      print(_longitude);
    }
    var result = await ApiManager.init.post("weather/", queryParameters: {
      "lat": _latitude,
      "lon": _longitude,
      "appid": weatherkey,
    });

    setState(() {
      _result = Weather.fromJson(result.data);
    });

    if (kDebugMode) {
      print("datatess : ${result.data}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ini Check Weather",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'FiraSans',
          ),
        ),
        leading: IconButton(
            onPressed: () {
              context.go("/");
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              size: 16,
              color: Colors.black,
            )),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    size: 16,
                    color: Colors.black,
                  ))
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Text(
                'Kota : ${_result?.name?.length == 0 ? "Unknown" : _result?.name}',
                style: const TextStyle(
                  fontFamily: "FiraSans",
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Text(
                'Suhu : ${_result?.main?.temp == 0 ? "Unknown" : _result?.main?.temp}',
                style: const TextStyle(
                  fontFamily: "FiraSans",
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Text(
                'Cuaca : ${_result?.weather?.elementAt(0).main?.length == 0 ? "Unknown" : _result?.weather?.elementAt(0).main}',
                style: const TextStyle(
                  fontFamily: "FiraSans",
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                    onPressed: () async {
                      await fetchWeatherApi();
                    },
                    child: const Text(
                      "Cek Cuaca",
                      style: TextStyle(
                          fontFamily: "FiraSans",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
          ],
        ),
      ),
    );
  }
}
