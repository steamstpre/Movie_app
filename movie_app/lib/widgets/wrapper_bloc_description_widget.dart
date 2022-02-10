import 'package:flutter/material.dart';
import 'package:movie_app/bloc/description_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/info_view_widget.dart';

class WrapperBlocDescription extends StatelessWidget {
  final DescriptionBlock _checkInfoBloc = DescriptionBlock();
  late Movie _movie;
  final String? nameOfMovie;

  WrapperBlocDescription({Key? key, this.nameOfMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _checkInfoBloc.outputMovieController,
        builder: (context, snapshot) {
          _checkInfoBloc.inputMovieNameController.add(nameOfMovie as String);
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            _movie = snapshot.data as Movie;
            return DescriptionView(movie: _movie);
          }
        });
  }
}
