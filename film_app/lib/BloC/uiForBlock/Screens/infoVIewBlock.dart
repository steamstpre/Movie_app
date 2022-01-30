import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/Consts/routeNameConst.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/BloC/uiForBlock/Screens/landscapeModeBlock.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Model/movieInfo.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final MovieInfo movieInfo;
  late final String _name_of_movie;
  final Description_block _check_info_bloc = Description_block();
  late Movie _movie;
  late Function() _exitFromInfo;
  List<String> _movies_list = [];
  bool statusOfLandScape = true;
  static const route = "InfoViewBlock";

  Info({
    Key? key,
    required this.movieInfo,
  }) : super(key: key) {
    _name_of_movie = movieInfo.selected_movie;
    _movies_list = movieInfo.moviesList;
  }

  @override
  Widget build(BuildContext context) {
    void exitFromInfoPortraine() {
      Navigator.of(context).pop();
    }

    void exitFromInfoLandScape() {
      Navigator.of(context).pushNamed(Route_name.home_page);
    }

    this._exitFromInfo = exitFromInfoPortraine;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Info"),
          leading: new IconButton(
              onPressed: _exitFromInfo, icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Stack(
          children: [
            StreamBuilder(
                stream: _check_info_bloc.outputMovieController,
                builder: (context, snapshot) {
                  _check_info_bloc.inputMovieNameController.add(_name_of_movie);
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _movie = snapshot.data as Movie;
                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait) {
                    //_movie = snapshot.data as Movie;
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
                    this.statusOfLandScape = true;
                    this._exitFromInfo =
                        exitFromInfoLandScape; //inherited widget
                    return LandScapeMode(
                        moviesList: this._movies_list, selected_movie: _movie);
                  }
                }),
          ],
        ),
      );
    });
  }
}
