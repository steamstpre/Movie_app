import 'package:film_app/BloC/uiForBlock/Screens/infoVIewBlock.dart';
import 'package:film_app/BloC/uiForBlock/Screens/listMoviesViewBlock.dart';
import 'package:film_app/MVVM/View/InfoView.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:flutter/material.dart';
import '../chooseArchiScreen/chooseArchScreen.dart';
import 'package:film_app/MVVM/View/listOfMoviesViewMVVM.dart';

class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? _name = settings.name;
    final Object? _index = settings.arguments;

    switch (_name) {
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case MoviesList.route:
        return MaterialPageRoute(builder: (_) => MoviesList());
      case MoviesListMvvM.route:
        return MaterialPageRoute(builder: (_) => MoviesListMvvM());
      case Info.route:
        return MaterialPageRoute(
            builder: (_) => Info(
                  movieInfo: _index as MovieInfo,
                ));
      case InfoViewMvvM.route:
        return MaterialPageRoute(
            builder: (_) => InfoViewMvvM(
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
