import 'package:film_app/Storage/Data.dart';
import 'package:film_app/repositories/repository.dart';


class List_movie_view_model {
  late List random_list;
  final Data_networking _data_networking = Data_networking();


  Future apply_random_list() async {
    random_list = (await _data_networking.getMovieList())!;
    random_list.shuffle();
    return random_list;
  }
}
