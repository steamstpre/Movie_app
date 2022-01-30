import 'package:film_app/BloC/uiForBlock/Screens/infoVIewBlock.dart';
import 'package:film_app/BloC/uiForBlock/Screens/listMoviesViewBlock.dart';
import 'package:film_app/MVVM/View/Info_view.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:flutter/material.dart';
import '../chooseArchiScreen/Choose_arch_screen.dart';
import 'package:film_app/BloC/Consts/routeNameConst.dart';
import 'package:film_app/MVVM/View/List_of_movies.dart';

class Route_Generator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? _name = settings.name;
    final Object? _index = settings.arguments;

    switch (_name) {
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Movies_list.route:
        return MaterialPageRoute(builder: (_) => Movies_list());
      case Movies_list_MvvM.route:
        return MaterialPageRoute(builder: (_) => Movies_list_MvvM());
      case Info.route:
        return MaterialPageRoute(
            builder: (_) => Info(
                  movieInfo: _index as MovieInfo,
                ));
      case Info_view.route:
        return MaterialPageRoute(
            builder: (_) => Info_view(
                  movieInfo: _index as MovieInfo,
                ));
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  static Route<dynamic>? onInitialRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    throw Exception(["page not found"]);
  }
}
