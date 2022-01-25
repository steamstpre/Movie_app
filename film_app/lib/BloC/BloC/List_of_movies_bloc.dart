import 'dart:async';

import 'package:film_app/Storage/Data.dart';
import 'package:film_app/Networking/Network.dart';

class List_of_movies_bloc{
  late List random_list;
  final _outputStateController = StreamController<List>();
  Data_networking controller = Data_networking();

  Stream<List> get outputStateStream => _outputStateController.stream;

  List_of_movies_bloc(){
    new_list_apply();
  }

  Future new_list_apply() async{
    random_list = await controller.getMovieList();
    random_list.shuffle();
    _outputStateController.sink.add(random_list);

  }


  void dispose(){
    _outputStateController.close();
  }

}