import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/chooseArchiScreen/chooseArchScreen.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final MovieInfo movieInfo;
  late final String _nameOfMovie;
  final DescriptionBlock _checkInfoBloc = DescriptionBlock();
  late Movie _movie;
  late Function() _exitFromInfo;
  List<String> _moviesList = [];
  bool statusOfLandScape = true;
  static const route = "InfoViewBlock";

  Info({
    Key? key,
    required this.movieInfo,
  }) : super(key: key) {
    _nameOfMovie = movieInfo.selectedMovie;
    _moviesList = movieInfo.moviesList;
  }

  @override
  Widget build(BuildContext context) {
    void exitFromInfoPortraine() {
      Navigator.of(context).pop();
    }

    void exitFromInfoLandScape() {
      Navigator.of(context).pushNamed(HomeScreen.route);
    }

    this._exitFromInfo = exitFromInfoPortraine;
    return OrientationBuilder(
        builder: (context, orientation) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Info"),
          leading: new IconButton(
              onPressed: _exitFromInfo, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Stack(
          children: [
            StreamBuilder(
                stream: _checkInfoBloc.outputMovieController,
                builder: (context, snapshot) {
                  _checkInfoBloc.inputMovieNameController.add(_nameOfMovie);
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _movie = snapshot.data as Movie;
                  if (orientation == Orientation.portrait) {
                    this._exitFromInfo = exitFromInfoPortraine;
                    return InfoView(
                        movie: _movie,
                        paddingSizeForNameOfMovie:
                            PaddingSizeModel(bottom: 650),
                        paddingSizeForImgOfMovie:
                            PaddingSizeModel(top: 110, left: 13, right: 13),
                        paddingSizeForDescriptionOfMovie:
                            PaddingSizeModel(top: 390, left: 44),
                        widthForImg: 400,
                        fontSizeNameOfMovie: 42,
                        fontSizeDiscriptionOfMovie: 20);
                  } else {
                    this._exitFromInfo =
                        exitFromInfoLandScape; //inherited widget
                    return LandScapeMode(
                        moviesList: this._moviesList, selectedMovie: _movie);
                  }
                }),
          ],
        ),
      );
    });
  }
}
