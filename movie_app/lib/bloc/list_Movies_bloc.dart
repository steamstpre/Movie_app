import 'dart:async';

import 'package:movie_app/repository/repository.dart';

class ListOfMoviesBloc {
  late List _randomList;
  final _outputStateController = StreamController<List>();
  DataNetwork _controller = DataNetwork();

  Stream<List> get outputStateStream => _outputStateController.stream;

  ListOfMoviesBloc() {
    _getListFromDataBase();
  }

  void _getListFromDataBase() async {
    _randomList = (await _controller.getMovieList())!;
    _randomList.shuffle();
    _outputStateController.sink.add(_randomList);
  }

  Future refreshList() async{//its must to be future generic
    if(_randomList.isNotEmpty) {
      _randomList.shuffle();
      _outputStateController.sink.add(_randomList);
    }else{
      _getListFromDataBase();
      refreshList();
    }
  }

  void dispose() {
    _outputStateController.close();
  }
}
