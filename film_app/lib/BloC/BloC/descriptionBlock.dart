import 'dart:async';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Storage/Data.dart';
import 'package:film_app/repositories/repository.dart';

class Description_block {
  late final Data_networking _network = Data_networking();
  Movie _movieModel = new Movie(
      name_of_movie: "none", description_of_movie: "none", img: "none");

  late final _inputMovieNameController = StreamController<String>();

  StreamSink<String> get inputMovieNameController =>
      this._inputMovieNameController.sink;

  StreamSink<String> get StreamInput => this._inputMovieNameController;

  final _outputMovieController = StreamController<Movie>();

  Stream<Movie> get outputMovieController => _outputMovieController.stream;

  void _mapEventToState(String name_of_mov) async {
    if (Data.movies_list.contains(name_of_mov)) {
      Map<String, dynamic> description =
          await this._network.getDescMap() as Map<String, dynamic>;
      Map<String, dynamic> img_src =
          await this._network.getImgMap() as Map<String, dynamic>;
      _movieModel = new Movie(
          name_of_movie: name_of_mov,
          description_of_movie: await description[name_of_mov] as String,
          img: await img_src[name_of_mov] as String);
    } else {
      throw Exception("not correct movie");
    }
    _outputMovieController.sink.add(_movieModel);
  }

  Description_block() {
    _inputMovieNameController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputMovieNameController.close();
    _outputMovieController.close();
  }
}
