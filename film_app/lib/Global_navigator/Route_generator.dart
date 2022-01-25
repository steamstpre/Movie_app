import 'package:film_app/BloC/UI_for_block/Screens/Info.dart';
import 'package:film_app/BloC/UI_for_block/Screens/List_of_movies.dart';
import 'package:film_app/MVVM/View/Info_view.dart';
import 'package:flutter/material.dart';
import '../Global_UI/Choose_arch_screen.dart';
import 'package:film_app/BloC/Consts/Route_name_const.dart';
import 'package:film_app/MVVM/View/List_of_movies.dart';

class Route_Generator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final Object? index = settings.arguments;


    if (name == null) {
      return Route_Generator.onUnknownRoute(settings);
    }

    switch (name) {
      case Route_name.home_page:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Route_name.movie_list_block:
        return MaterialPageRoute(
            builder: (_) => Movies_list(

                ));
      case Route_name.movie_list_mvvm:
        return MaterialPageRoute(
            builder: (_) => Movies_list_MvvM());
      case Route_name.info_block:
        return MaterialPageRoute(
            builder: (_) => Info(
                  name_of_movie: index as String,
                ));
      case Route_name.info_mvvm:
        return MaterialPageRoute(
            builder: (_) => Info_view(
                  name_of_movie: index as String,
                ));
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  static Route<dynamic>? onInitialRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => HomeScreen());
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("404"),
        ),
      );
    });
  }
}
