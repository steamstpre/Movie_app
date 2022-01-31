import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/BloC/listMoviesBloc.dart';
import 'package:film_app/BloC/uiForBlock/Screens/infoVIewBlock.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Widgets/refreshWidget.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatefulWidget {
  static const route = "MoviesList";
  const MoviesList({Key? key, this.selectedMovie}) : super(key: key);
  final Movie? selectedMovie;

  @override
  _MoviesListState createState() => _MoviesListState(movie: selectedMovie);
}

// no use _
class _MoviesListState extends State<MoviesList> {
  late ListOfMoviesBloc _listOfMoviesBloc = new ListOfMoviesBloc();
  List<String> _moviesList = [];
  late final DescriptionBlock _checkInfoBloc = new DescriptionBlock();
  late Movie? movie;
  late MovieInfo _movieInfo;

  _MoviesListState({this.movie});

  @override
  void dispose() {
    this._listOfMoviesBloc.dispose();
    this._checkInfoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
      Widget buildList() {
        return RefreshWidget(
          onRefresh: _listOfMoviesBloc.refreshList,
          child: StreamBuilder(
              stream: _listOfMoviesBloc.outputStateStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  _moviesList = snapshot.data as List<String>;
                  if (orientation == Orientation.portrait) {
                    return MovieListView(
                      moviesList: _moviesList,
                      onSelect: (item) {
                        setState(() {
                          this._movieInfo =
                              new MovieInfo(this._moviesList, item);
                        });
                        Navigator.of(context).pushNamed(Info.route,
                            arguments: this._movieInfo);
                      },
                    );
                  } else {
                    if (this.movie == null) {
                      return LandScapeMode(moviesList: _moviesList);
                    } else {
                      return LandScapeMode(
                        moviesList: _moviesList,
                        selectedMovie: movie,
                      );
                    }
                  }
                }
              }),
        );
      }

      return Scaffold(
          appBar: AppBar(
            title: Text("Movie list BloC"),
          ),
          body: buildList());
    });
  }
}
