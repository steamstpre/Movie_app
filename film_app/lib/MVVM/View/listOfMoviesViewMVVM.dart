import 'dart:async';
import 'package:film_app/MVVM/View/InfoView.dart';
import 'package:film_app/MVVM/View/landScapeViewMVVM.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/MVVM/ViewModel/listMovieViewModel.dart';

import 'package:film_app/Widgets/refreshWidget.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:flutter/material.dart';

class MoviesListMvvM extends StatefulWidget {
  final Movie? selectedMovie;
  static const route = "Movies_list_MvvM";

  const MoviesListMvvM({Key? key, this.selectedMovie}) : super(key: key);

  @override
  _MoviesListMvvMState createState() =>
      _MoviesListMvvMState(selectedMovie);
}

class _MoviesListMvvMState extends State<MoviesListMvvM> {
  List<String> _moviesList = [];
  late ListMovieViewModel listMovieViewModel = ListMovieViewModel();
  late Movie? _movie;
  late MovieInfo _movieInfo;

  _MoviesListMvvMState(this._movie);

  Future loadData() async {
    _moviesList = await listMovieViewModel.applyRandomList();

    setState(() {
      this.listMovieViewModel = listMovieViewModel;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
      Widget buildList() {
        if (_moviesList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (orientation == Orientation.portrait) {
          return RefreshWidget(
              onRefresh: loadData,
              child: MovieListView(
                moviesList: _moviesList,
                onSelect: (item) {
                  setState(() {
                    this._movieInfo = new MovieInfo(this._moviesList, item);
                  });
                  Navigator.of(context).pushNamed(InfoViewMvvM.route,
                      arguments: this._movieInfo);
                },
              ));
        } else {
          if (this._movie == null) {
            return RefreshWidget(
                child: LandScapeView(
                  moviesList: _moviesList,
                ),
                onRefresh: loadData);
          } else {
            return RefreshWidget(
                child: LandScapeView(
                  moviesList: _moviesList,
                  selectedMovie: _movie,
                ),
                onRefresh: loadData);
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
