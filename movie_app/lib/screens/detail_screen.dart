import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/widgets/wrapper_bloc_description_widget.dart';
import 'package:movie_app/widgets/wrapper_mvvm_description_widget.dart';

class DetailScreen extends StatelessWidget {
  static const route = "DetailScreen";
  late Widget _wrapperWidget;
  final MovieInfo selectedMovie;

  DetailScreen({Key? key, required this.selectedMovie}) : super(key: key) {
    if (selectedMovie.idArchitecture == "Bloc") {
      _wrapperWidget = WrapperBlocDescription(
        nameOfMovie: this.selectedMovie.selectedMovie,
      );
    } else {
      _wrapperWidget = WrapperMvvMDescription(
        nameOfMovie: this.selectedMovie.selectedMovie,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Screen"),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constrains) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return _wrapperWidget;
        } else {
          Navigator.of(context).pop(selectedMovie);
          return CircularProgressIndicator();
        }
      }),
    );
    }
  }

