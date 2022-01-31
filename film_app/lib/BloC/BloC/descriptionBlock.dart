import 'dart:async';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Storage/Data.dart';
import 'package:film_app/repositories/repository.dart';

class DescriptionBlock {
  late final DataNetwork _network = DataNetwork();
  Movie _movieModel = new Movie(
      nameOfMovie: "none", descriptionOfMovie: "none", img: "none");

  late final _inputMovieNameController = StreamController<String>();

  StreamSink<String> get inputMovieNameController =>
      this._inputMovieNameController.sink;

  StreamSink<String> get streamInput => this._inputMovieNameController;

  final _outputMovieController = StreamController<Movie>();

  Stream<Movie> get outputMovieController => _outputMovieController.stream;

  void _mapEventToState(String nameOfMov) async {
    if (Data.moviesList.contains(nameOfMov)) {
      Map<String, dynamic> description =
          await this._network.getDescMap() as Map<String, dynamic>;
      Map<String, dynamic> imgSrc =
          await this._network.getImgMap() as Map<String, dynamic>;
      _movieModel = new Movie(
          nameOfMovie: nameOfMov,
          descriptionOfMovie: await description[nameOfMov] as String,
          img: await imgSrc[nameOfMov] as String);
    } else {
      throw Exception("not correct movie");
    }
    _outputMovieController.sink.add(_movieModel);
  }

  DescriptionBlock() {
    _inputMovieNameController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputMovieNameController.close();
    _outputMovieController.close();
  }
}
