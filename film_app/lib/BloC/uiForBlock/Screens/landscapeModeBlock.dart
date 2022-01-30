import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/Widgets/listView.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:flutter/material.dart';

class LandScapeMode extends StatefulWidget {
  final List<String> moviesList;
  final Movie? selected_movie;

  const LandScapeMode({
    Key? key,
    required this.moviesList,
    this.selected_movie,
  }) : super(key: key);

  @override
  _LandScapeModeState createState() =>
      _LandScapeModeState(movie: this.selected_movie, moviesList: moviesList);
}

class _LandScapeModeState extends State<LandScapeMode> {
  final List<String> moviesList;
  late final Description_block _check_info_bloc = new Description_block();
  late Movie _movie;
  late final Widget chooseArchInfoWidget;
  final _selection = ValueNotifier<String?>(null);

  _LandScapeModeState({Movie? movie, required this.moviesList}) {
    if (movie != null) {
      this._movie = movie as Movie;
      _selection.value = _movie.name_of_movie;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 300,
          child: movieListView(
              movies_list: moviesList,
              onSelect: (value) {
                setState(() {
                  _selection.value = value;
                });
              }),
        ),
        Expanded(
            //scroll
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
              //info container class with optional size
              return Container(
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream: _check_info_bloc.outputMovieController,
                        builder: (context, snapshot) {
                          _check_info_bloc.inputMovieNameController.add(name);
                          if (snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          _movie = snapshot.data as Movie;
                          return InfoView(
                              movie: _movie,
                              paddingSizeForNameOfMovie:
                                  PaddingSizeModel(bottom: 250),
                              paddingSizeForImgOfMovie:
                                  PaddingSizeModel(top: 80, left: 10),
                              paddingSizeForDescriptionOfMovie:
                                  PaddingSizeModel(top: 80, left: 200),
                              widthForImg: 150,
                              fontSizeNameOfMovie: 30,
                              fontSizeDiscriptionOfMovie: 20);
                        }),
                  ],
                ),
              );
            }
          },
        ))
      ],
    );
  }
}
