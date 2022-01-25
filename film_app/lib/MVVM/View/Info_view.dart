import 'package:film_app/BloC/BloC/Check_info.dart';
import 'package:film_app/Model/Movie_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_app/MVVM/ViewModel/ViewModelMovie.dart';

class Info_view extends StatefulWidget {
  Info_view({
    Key? key,
    required this.name_of_movie,
  }) : super(key: key) {}
  late String name_of_movie;

  @override
  _InfoState createState() => _InfoState(name_of_movie);
}

class _InfoState extends State<Info_view> {
  late final String name_of_movie;
  late ViewModelMovie _modelMovie = new ViewModelMovie();
  late Movie _movie = new Movie(
      name_of_movie: "none", description_of_movie: "none", img: "none");

  _InfoState(this.name_of_movie) {
    get_data();
  }

  Future get_data() async {
    _movie = await _modelMovie.apply_movie(this.name_of_movie);
    setState(() {
      this._modelMovie = _modelMovie;
      this._movie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      if (_movie.name_of_movie == "none") {
        return Scaffold(
            appBar: AppBar(title: Text("Info")),
            body: Center(
              child: CircularProgressIndicator(),
            ));
      } else {
        return Scaffold(
          appBar: AppBar(title: Text("Info")),
          body: Stack(
            children: [
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 650),
                      child: Center(
                          child: Text(
                        _movie.name_of_movie,
                        style: TextStyle(fontSize: 42),
                      ))),
                  Padding(
                    padding: EdgeInsets.only(top: 110, left: 13, right: 13),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      imageUrl: _movie.img,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 390, left: 13, right: 13),
                      child: Text(_movie.description_of_movie))
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
