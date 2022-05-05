import 'package:flutter/services.dart';

import '../repository/repository.dart';

class ListMovieViewModel {
  late List randomList;
  final DataNetwork _dataNetworking = DataNetwork();

  Future applyRandomList() async {
    randomList = (await _dataNetworking.getMovieList())!;
    randomList.shuffle();
    SystemNavigator.pop();
    return randomList;
  }
}
