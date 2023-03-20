import 'package:go_router/go_router.dart';
import 'package:proyek_example/src/weathercheck.dart';
import '../home.dart';
import '../model/weather.dart';
import '../setting.dart';

class RouteManager {
  static final RouteManager _routing = RouteManager._internal();

  factory RouteManager() {
    return _routing;
  }

  RouteManager._internal();

  final GoRouter route = GoRouter(initialLocation: '/', routes: <RouteBase>[
    GoRoute(path: "/", builder: ((context, state) => const Home())),
    GoRoute(
        path: "/settings",
        builder: ((context, state) => const Setting(
              restorationId: "setting",
            ))),
    GoRoute(path: "/weather", builder: ((context, state) => const WeatherCheck())),
  ]);
}
