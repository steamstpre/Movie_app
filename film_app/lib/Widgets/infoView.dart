import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final Movie movie;
  final PaddingSizeModel paddingSizeForNameOfMovie;
  final PaddingSizeModel paddingSizeForImgOfMovie;
  final PaddingSizeModel paddingSizeForDescriptionOfMovie;
  final double widthForImg;
  final double fontSizeNameOfMovie;
  final double fontSizeDiscriptionOfMovie;

  const InfoView(
      {Key? key,
      required this.movie,
      required this.paddingSizeForNameOfMovie,
      required this.paddingSizeForImgOfMovie,
      required this.paddingSizeForDescriptionOfMovie,
      required this.widthForImg,
      required this.fontSizeNameOfMovie,
      required this.fontSizeDiscriptionOfMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(
                top: this.paddingSizeForNameOfMovie.top as double,
                bottom: this.paddingSizeForNameOfMovie.bottom as double,
                right: this.paddingSizeForNameOfMovie.right as double,
                left: this.paddingSizeForNameOfMovie.left as double),
            child: Center(
                child: Text(
              movie.name_of_movie,
              style: TextStyle(fontSize: this.fontSizeNameOfMovie),
              key: UniqueKey(),
            ))),
        Padding(
          padding: EdgeInsets.only(
              top: this.paddingSizeForImgOfMovie.top as double,
              left: this.paddingSizeForImgOfMovie.left as double,
              right: this.paddingSizeForImgOfMovie.right as double,
              bottom: this.paddingSizeForImgOfMovie.bottom as double),
          child: SizedBox(
            width: this.widthForImg,
            child: CachedNetworkImage(
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageUrl: movie.img,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: this.paddingSizeForDescriptionOfMovie.top as double,
                left: this.paddingSizeForDescriptionOfMovie.left as double,
                right: this.paddingSizeForDescriptionOfMovie.right as double,
                bottom: this.paddingSizeForDescriptionOfMovie.bottom as double),
            child:
                SizedBox(width: 300, child: Text(movie.description_of_movie)))
      ],
    );
    ;
  }
}
