import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/detail_screen.dart';
<<<<<<< Updated upstream
import 'package:movie_app/screens/home_Screen.dart';
=======
import 'package:movie_app/screens/home_screen.dart';
>>>>>>> Stashed changes
import 'package:movie_app/screens/list_view_screen.dart';

class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? _name = settings.name;
    final Object? _id = settings.arguments;

    switch (_name) {
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ListViewScreen.route:
        return MaterialPageRoute(builder: (_) => ListViewScreen(
          idArchitecture: _id as String,
        ));
      case DetailScreen.route:
        return MaterialPageRoute(
            builder: (_) => DetailScreen(
                  selectedMovie: _id as MovieInfo,
                ));
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    throw Exception(["page not found"]);
  }
}
