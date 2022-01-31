import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/chooseArchiScreen/chooseArchScreen.dart';
import 'package:flutter/material.dart';
import 'package:film_app/MVVM/ViewModel/viewModelMovie.dart';

class InfoViewMvvM extends StatefulWidget {
  final MovieInfo movieInfo;
  late final String _nameOfMovie;
  List<String> _moviesList = [];
  static const route = "infoView";
  InfoViewMvvM({
    Key? key,
    required this.movieInfo,
  }) : super(key: key) {
    _nameOfMovie = movieInfo.selectedMovie;
    _moviesList = movieInfo.moviesList;
  }

  @override
  _InfoState createState() => _InfoState(_nameOfMovie , _moviesList);
}

class _InfoState extends State<InfoViewMvvM> {
  late final String nameOfMovie;
  late ViewModelMovie _modelMovie = new ViewModelMovie();
  Movie? _movie;
  List<String> moviesList = [];

  _InfoState(this.nameOfMovie , this.moviesList) {
    getData();
  }

  Future getData() async {
    _movie = await _modelMovie.applyMovie(this.nameOfMovie);
    setState(() {
      this._modelMovie = _modelMovie;
      this._movie = _movie;
    });
  }

  void exitFromInfoPortraine() {
    Navigator.of(context).pop();
  }

  void exitFromInfoLandScape() {
    Navigator.of(context).pushNamed(HomeScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      if (_movie == null) {
        return Scaffold(
            appBar: AppBar(title: Text("Info")),
            body: Center(
              child: CircularProgressIndicator(),
            ));
      } else {
        //Orientation builder
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return Scaffold(
              appBar: AppBar(
                  title: Text("Info"),
                  leading: new IconButton(
                      onPressed: exitFromInfoPortraine,
                      icon: Icon(Icons.arrow_back_ios))),
              body: InfoView(
                  movie: _movie as Movie,
                  paddingSizeForNameOfMovie: PaddingSizeModel(bottom: 650),
                  paddingSizeForImgOfMovie:
                      PaddingSizeModel(top: 110, left: 13, right: 13),
                  paddingSizeForDescriptionOfMovie:
                      PaddingSizeModel(top: 390, left: 44),
                  widthForImg: 400,
                  fontSizeNameOfMovie: 42,
                  fontSizeDiscriptionOfMovie: 20));
        } else {
          getData();
          return Scaffold(
            appBar: AppBar(
                title: Text("Info"),
                leading: new IconButton(
                    onPressed: exitFromInfoLandScape,
                    icon: Icon(Icons.arrow_back_ios))),
            body: LandScapeMode(
                moviesList: this.moviesList, selectedMovie: _movie),
          );
        }
      }
    });
  }
}
