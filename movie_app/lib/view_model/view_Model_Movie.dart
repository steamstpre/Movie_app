import 'package:movie_app/repository/repository.dart';
import 'package:movie_app/models/movie_model.dart';

class ViewModelMovie {
  Movie? movie;
  final DataNetwork dataNetworking = DataNetwork();
  late Map<String, dynamic> description;
  late Map<String, dynamic> imgSrc;

<<<<<<< Updated upstream
  Future applyMovie(String name) async {
=======
  Future<Movie?>applyMovie(String name) async {
>>>>>>> Stashed changes
    this.description =
        await this.dataNetworking.getDescMap() as Map<String, dynamic>;
    this.imgSrc = await this.dataNetworking.getImgMap() as Map<String, dynamic>;
    this.movie = new Movie(
        nameOfMovie: name,
        descriptionOfMovie: await description[name] as String,
        img: await imgSrc[name] as String);
    return this.movie;
  }

  Movie applyForLandscape(String name) {
    Movie movieForLanscape = new Movie(
        nameOfMovie: name,
        descriptionOfMovie: description[name] as String,
        img: imgSrc[name] as String);
    return movieForLanscape;
  }
}
