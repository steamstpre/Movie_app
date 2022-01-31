import 'dart:async';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/MVVM/ViewModel/viewModelMovie.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:flutter/material.dart';

class LandScapeView extends StatefulWidget {
  final List<String> moviesList;
  final Movie? selectedMovie;

  const LandScapeView({Key? key, required this.moviesList,
    this.selectedMovie,}) : super(key: key);

  @override
  _LandScapeViewState createState() =>
      _LandScapeViewState(this.moviesList, this.selectedMovie);
}

class _LandScapeViewState extends State<LandScapeView> {
  final List<String> moviesList;
  late Movie _movie;
  final _selection = ValueNotifier<String?>(null);
  ViewModelMovie _modelMovie = new ViewModelMovie();

  _LandScapeViewState(this.moviesList, Movie? movie){
    if (movie != null) {
      this._movie = movie;
      _selection.value = _movie.nameOfMovie;
    }
  }

  Future getDataMovie() async {
    _movie = await _modelMovie.applyMovie(_selection.value as String);
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
          child: MovieListView(
            moviesList: this.moviesList, onSelect: (value) {
            setState(() {
              _selection.value = value;
              this._movie = _modelMovie.applyForLandscape(value);
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
                  getDataMovie();
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
    );
  }
}
