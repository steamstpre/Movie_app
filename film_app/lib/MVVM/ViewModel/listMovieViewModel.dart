import 'package:film_app/repositories/repository.dart';

class ListMovieViewModel {
  late List randomList;
  final DataNetwork _dataNetworking = DataNetwork();

  Future applyRandomList() async {
    randomList = (await _dataNetworking.getMovieList())!;
    randomList.shuffle();
    return randomList;
  }
}
