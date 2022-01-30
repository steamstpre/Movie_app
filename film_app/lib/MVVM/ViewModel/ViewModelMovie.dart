import 'package:film_app/repositories//repository.dart';
import 'package:flutter/material.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Storage//Data.dart';

class ViewModelMovie {
  late final Movie movie;
  final Data_networking data_networking = Data_networking();
  late Map<String, dynamic> description;
  late Map<String, dynamic> img_src;

  Future apply_movie(String name) async {
    this.description =
    await this.data_networking.getDescMap() as Map<String, dynamic>;
    this.img_src =
    await this.data_networking.getImgMap() as Map<String, dynamic>;
    this.movie = new Movie(
        name_of_movie: name,
        description_of_movie: await description[name] as String,
        img: await img_src[name] as String);
    return this.movie;
  }

  Movie apply_for_landscape(String name) {
    Movie movie_for_lanscape = new Movie(name_of_movie: name,
        description_of_movie: description[name] as String,
        img: img_src[name] as String);
    return movie_for_lanscape;
  }
}
