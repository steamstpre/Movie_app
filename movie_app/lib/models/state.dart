import 'package:movie_app/models/movie_model.dart';

class MovieModelState {
  Movie? movie =
      new Movie(nameOfMovie: "none", descriptionOfMovie: "none", img: "none");

  MovieModelState({this.movie});
}
