import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/chooseArchiScreen/Choose_arch_screen.dart';
import 'package:flutter/material.dart';
import 'package:film_app/MVVM/ViewModel/ViewModelMovie.dart';

class Info_view extends StatefulWidget {
  final MovieInfo movieInfo;
  late final String _name_of_movie;
  List<String> _movies_list = [];
  static const route = "infoView";
  Info_view({
    Key? key,
    required this.movieInfo,
  }) : super(key: key) {
    _name_of_movie = movieInfo.selected_movie;
    _movies_list = movieInfo.moviesList;
  }

  @override
  _InfoState createState() => _InfoState(_name_of_movie , _movies_list);
}

class _InfoState extends State<Info_view> {
  late final String name_of_movie;
  late ViewModelMovie _modelMovie = new ViewModelMovie();
  Movie? _movie;
  List<String> movies_list = [];

  _InfoState(this.name_of_movie , this.movies_list) {
    get_data();
  }

  Future get_data() async {
    _movie = await _modelMovie.apply_movie(this.name_of_movie);
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
          get_data();
          return Scaffold(
            appBar: AppBar(
                title: Text("Info"),
                leading: new IconButton(
                    onPressed: exitFromInfoLandScape,
                    icon: Icon(Icons.arrow_back_ios))),
            body: LandScapeMode(
                moviesList: this.movies_list, selected_movie: _movie),
          );
        }
      }
    });
  }
}
