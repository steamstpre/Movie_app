import 'dart:async';

import 'package:film_app/repositories/repository.dart';

class List_of_movies_bloc {
  late List _random_list;
  final _outputStateController = StreamController<List>();
  Data_networking _controller = Data_networking();

  Stream<List> get outputStateStream => _outputStateController.stream;

  List_of_movies_bloc() {
    _getListFromDataBase();
  }

  void _getListFromDataBase() async {
    _random_list = (await _controller.getMovieList())!;
    _random_list.shuffle();
    _outputStateController.sink.add(_random_list);
  }

  Future refreshList() async{//its must to be future generic
    if(_random_list.isNotEmpty) {
      _random_list.shuffle();
      _outputStateController.sink.add(_random_list);
    }else{
      _getListFromDataBase();
      refreshList();
    }
  }

  void dispose() {
    _outputStateController.close();
  }
}
