import 'dart:async';
<<<<<<< Updated upstream
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repository/repository.dart';

class DescriptionBlock {
  late final DataNetwork _network = DataNetwork();
  Movie _movieModel =
      new Movie(nameOfMovie: "none", descriptionOfMovie: "none", img: "none");

  late final _inputMovieNameController = StreamController<String>();

  StreamSink<String> get inputMovieNameController =>
      this._inputMovieNameController.sink;

  StreamSink<String> get streamInput => this._inputMovieNameController;

  final _outputMovieController = StreamController<Movie>();

  Stream<Movie> get outputMovieController => _outputMovieController.stream;

  void _mapEventToState(String nameOfMov) async {
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/event.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/state.dart';
import 'package:movie_app/repository/repository.dart';

class DescriptionBlock extends Bloc<NameOfMovieEvent, MovieModelState?> {
  final DataNetwork _network = DataNetwork();
  Movie _movieModel =
      new Movie(nameOfMovie: "none", descriptionOfMovie: "none", img: "none");
  MovieModelState? _movieState;

  DescriptionBlock(MovieModelState initialState) : super(initialState);

  @override
  Stream<MovieModelState?> mapEventToState(NameOfMovieEvent event) async* {
>>>>>>> Stashed changes
    Map<String, dynamic> description =
        await this._network.getDescMap() as Map<String, dynamic>;
    Map<String, dynamic> imgSrc =
        await this._network.getImgMap() as Map<String, dynamic>;
    _movieModel = new Movie(
<<<<<<< Updated upstream
        nameOfMovie: nameOfMov,
        descriptionOfMovie: await description[nameOfMov] as String,
        img: await imgSrc[nameOfMov] as String);

    _outputMovieController.sink.add(_movieModel);
  }

  DescriptionBlock() {
    _inputMovieNameController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputMovieNameController.close();
    _outputMovieController.close();
=======
        nameOfMovie: event.nameOfMovie,
        descriptionOfMovie: await description[event.nameOfMovie] as String,
        img: await imgSrc[event.nameOfMovie] as String);
    _movieState = new MovieModelState(movie: _movieModel);
    yield _movieState;
>>>>>>> Stashed changes
  }
}
