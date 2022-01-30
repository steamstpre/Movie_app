import 'dart:async';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/MVVM/ViewModel/ViewModelMovie.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:flutter/material.dart';

class landScapeView extends StatefulWidget {
  final List<String> moviesList;
  final Movie? selected_movie;

  const landScapeView({Key? key, required this.moviesList,
    this.selected_movie,}) : super(key: key);

  @override
  _landScapeViewState createState() =>
      _landScapeViewState(this.moviesList, this.selected_movie);
}

class _landScapeViewState extends State<landScapeView> {
  final List<String> moviesList;
  late Movie _movie;
  final _selection = ValueNotifier<String?>(null);
  ViewModelMovie _modelMovie = new ViewModelMovie();

  _landScapeViewState(this.moviesList, Movie? movie){
    if (movie != null) {
      this._movie = movie as Movie;
      _selection.value = _movie.name_of_movie;
    }
  }

  Future get_data_movie() async {
    _movie = await _modelMovie.apply_movie(_selection.value as String);
    setState(() {
      this._modelMovie = _modelMovie;
      this._movie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          child: movieListView(
            movies_list: this.moviesList, onSelect: (value) {
            setState(() {
              _selection.value = value;
              this._movie = _modelMovie.apply_for_landscape(value);
            });
          }
            ,),
        ),
        Expanded(
            child: ValueListenableBuilder<String?>(
              valueListenable: _selection,
              builder: (context, name, child) {
                if (name == null) {
                  return Stack(
                    children: [
                      Center(
                        child: Text("select item"),
                      )
                    ],
                  );
                } else {
                  get_data_movie();
                  try {
                    return InfoView(movie: this._movie,
                        paddingSizeForNameOfMovie:
                        PaddingSizeModel(bottom: 250),
                        paddingSizeForImgOfMovie:
                        PaddingSizeModel(top: 80, left: 10),
                        paddingSizeForDescriptionOfMovie:
                        PaddingSizeModel(top: 80, left: 200),
                        widthForImg: 150,
                        fontSizeNameOfMovie: 30,
                        fontSizeDiscriptionOfMovie: 20);
                  } catch (e) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              },
            ))
      ],
    );;
  }
}
