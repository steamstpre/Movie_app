import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class DescriptionView extends StatelessWidget {
  final Movie movie;

  DescriptionView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery
        .of(context)
        .orientation == Orientation.portrait) {
      return  Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .size
                        .width * 1.65,
                    left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.1),
                child: Center(
                    child: Text(
                      movie.nameOfMovie,
                      style:
                      TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.09),
                      key: UniqueKey(),
                    ))),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8),
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    imageUrl: movie.img,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding:
                  EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7),
                  child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,
                      child: Text(movie.descriptionOfMovie))),
            )
          ],
        );

    }else{
      return SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    bottom: 280,
                    right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                child: Center(
                    child: Text(
                      movie.nameOfMovie,
                      style:
                      TextStyle(fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05),
                      key: UniqueKey(),
                    ))),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                     top: 90),
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.38,
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    imageUrl: movie.img,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding:
                  EdgeInsets.only(top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4 ),
                  child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      child: Text(movie.descriptionOfMovie))),
            )
          ],
        ),
      );
    }
  }
}
