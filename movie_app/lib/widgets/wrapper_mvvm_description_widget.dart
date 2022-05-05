import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/view_model/view_Model_Movie.dart';
import 'package:movie_app/widgets/info_view_widget.dart';

class WrapperMvvMDescription extends StatefulWidget {
  final String? nameOfMovie;

  WrapperMvvMDescription({Key? key, this.nameOfMovie}) : super(key: key);

  @override
  _WrapperMvvMDescriptionState createState() => _WrapperMvvMDescriptionState();
}

class _WrapperMvvMDescriptionState extends State<WrapperMvvMDescription> {
  ViewModelMovie _modelMovie = new ViewModelMovie();


<<<<<<< Updated upstream
  Future<Movie> getData() async {
=======
  Future<Movie?> getData() async {
>>>>>>> Stashed changes
    return await _modelMovie.applyMovie(this.widget.nameOfMovie as String);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
<<<<<<< Updated upstream
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
=======
        builder: (BuildContext context, AsyncSnapshot<Movie?> snapshot) {
>>>>>>> Stashed changes
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return DescriptionView(movie: snapshot.data as Movie);
          }
        });
    // return DescriptionView(movie: _movie as Movie);
  }
}
