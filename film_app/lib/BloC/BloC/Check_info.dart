import 'dart:async';
import 'package:film_app/Model/Movie_model.dart';
import 'package:film_app/Storage/Data.dart';
import 'package:film_app/Networking/Network.dart';
import 'package:flutter/cupertino.dart';

class Check_info_bloc {
  late final int _index = 0;
  late final Data_networking data_networking = Data_networking();
  Movie _movieModel = new Movie(
      name_of_movie: "none", description_of_movie: "none", img: "none");

  late final _inputIndexController = StreamController<String>();

  StreamSink<String> get inputIndexSink => this._inputIndexController.sink;

  StreamSink<String> get StreamInput => this._inputIndexController;

  final _outputStateController = StreamController<Movie>();

  Stream<Movie> get outputStateStream => _outputStateController.stream;

  Future _mapEventToState(String name_of_mov) async {
    if (Data.movies_list.contains(name_of_mov)) {
      Map<String, dynamic> description =
          await this.data_networking.getDescMap() as Map<String, dynamic>;
      Map<String, dynamic> img_src =
          await this.data_networking.getImgMap() as Map<String, dynamic>;
      _movieModel = new Movie(
          name_of_movie: name_of_mov,
          description_of_movie: await description[name_of_mov] as String,
          img: await img_src[name_of_mov] as String);
    } else {
      throw Exception("not correct movie");
    }
    _outputStateController.sink.add(_movieModel);

  }

  Check_info_bloc() {
    _inputIndexController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputIndexController.close();
    _outputStateController.close();
  }
}
