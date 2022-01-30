import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/BloC/listMoviesBloc.dart';
import 'package:film_app/BloC/Consts/routeNameConst.dart';
import 'package:film_app/BloC/uiForBlock/Screens/infoVIewBlock.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Widgets/Refresh_widget.dart';
import 'package:flutter/material.dart';

class Movies_list extends StatefulWidget {
  static const route = "MoviesList";
  const Movies_list({Key? key, this.selected_movie}) : super(key: key);
  final Movie? selected_movie;

  @override
  _Movies_listState createState() => _Movies_listState(movie: selected_movie);
}

class _Movies_listState extends State<Movies_list> {
  late List_of_movies_bloc _list_of_movies_bloc = new List_of_movies_bloc();
  List<String> _movies_list = [];
  late final Description_block _check_info_bloc = new Description_block();
  late Movie? movie;
  late MovieInfo _movieInfo;

  _Movies_listState({this.movie});

  @override
  void dispose() {
    this._list_of_movies_bloc.dispose();
    this._check_info_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      Widget buildList() {
        return Refresh_widget(
          onRefresh: _list_of_movies_bloc.refreshList,
          child: StreamBuilder(
              stream: _list_of_movies_bloc.outputStateStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  _movies_list = snapshot.data as List<String>;
                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait) {
                    return movieListView(
                      movies_list: _movies_list,
                      onSelect: (item) {
                        setState(() {
                          this._movieInfo =
                              new MovieInfo(this._movies_list, item);
                        });
                        Navigator.of(context).pushNamed(Info.route,
                            arguments: this._movieInfo);
                      },
                    );
                  } else {
                    if (this.movie == null) {
                      return LandScapeMode(moviesList: _movies_list);
                    } else {
                      return LandScapeMode(
                        moviesList: _movies_list,
                        selected_movie: movie,
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
