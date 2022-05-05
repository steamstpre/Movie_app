import 'package:flutter/material.dart';
<<<<<<< Updated upstream
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
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/description_bloc.dart';
import 'package:movie_app/models/event.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/state.dart';
import 'package:movie_app/widgets/info_view_widget.dart';

class WrapperBlocDescription extends StatelessWidget {
  late Movie _movie;
  String? nameOfMovie;
  MovieModelState modelState = new MovieModelState();
  late NameOfMovieEvent _nameOfMovieEvent;

  WrapperBlocDescription({Key? key, this.nameOfMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DescriptionBlock(modelState),
      child: BlocBuilder<DescriptionBlock, MovieModelState?>(
          builder: (context, MovieModelState? state) {
        _nameOfMovieEvent = new NameOfMovieEvent(nameOfMovie as String);
        BlocProvider.of<DescriptionBlock>(context).add(_nameOfMovieEvent);
        if (state!.movie == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else {
          _movie = state.movie as Movie;
          return DescriptionView(movie: _movie);
        }
      }),
    );
>>>>>>> Stashed changes
  }
}
