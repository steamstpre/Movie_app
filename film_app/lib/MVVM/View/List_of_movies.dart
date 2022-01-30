import 'dart:async';
import 'package:film_app/MVVM/View/Info_view.dart';
import 'package:film_app/MVVM/View/landScapeViewMVVM.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/MVVM/ViewModel/List_movie_view_model.dart';

import 'package:film_app/Widgets/Refresh_widget.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:flutter/material.dart';
import 'package:film_app/BloC/Consts/routeNameConst.dart';

class Movies_list_MvvM extends StatefulWidget {
  final Movie? selected_movie;
  static const route = "Movies_list_MvvM";

  const Movies_list_MvvM({Key? key, this.selected_movie}) : super(key: key);

  @override
  _Movies_list_MvvMState createState() =>
      _Movies_list_MvvMState(selected_movie);
}

class _Movies_list_MvvMState extends State<Movies_list_MvvM> {
  List<String> _movies_list = [];
  late List_movie_view_model list_movie_view_model = List_movie_view_model();
  late Movie? _movie;
  late MovieInfo _movieInfo;

  _Movies_list_MvvMState(this._movie);

  Future load_data() async {
    _movies_list = await list_movie_view_model.apply_random_list();

    setState(() {
      this.list_movie_view_model = list_movie_view_model;
    });
  }

  @override
  void initState() {
    load_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      Widget buildList() {
        if (_movies_list.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return Refresh_widget(
              onRefresh: load_data,
              child: movieListView(
                movies_list: _movies_list,
                onSelect: (item) {
                  setState(() {
                    this._movieInfo = new MovieInfo(this._movies_list, item);
                  });
                  Navigator.of(context).pushNamed(Info_view.route,
                      arguments: this._movieInfo);
                },
              ));
        } else {
          if (this._movie == null) {
            return Refresh_widget(
                child: landScapeView(
                  moviesList: _movies_list,
                ),
                onRefresh: load_data);
          } else {
            return Refresh_widget(
                child: landScapeView(
                  moviesList: _movies_list,
                  selected_movie: _movie,
                ),
                onRefresh: load_data);
          }
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("Movie list MVVM"),
        ),
        body: buildList(),
      );
    });
  }
}
