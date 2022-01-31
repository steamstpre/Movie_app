import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:flutter/material.dart';

class LandScapeInfo extends StatelessWidget {
  final DescriptionBlock _checkInfoBloc = new DescriptionBlock();
  late Movie _movie;
  String nameOfMovie;

  LandScapeInfo({Key? key, required this.nameOfMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder(
              stream: _checkInfoBloc.outputMovieController,
              builder: (context, snapshot) {
                _checkInfoBloc.inputMovieNameController.add(nameOfMovie);
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                _movie = snapshot.data as Movie;
                return InfoView(
                    movie: _movie,
                    paddingSizeForNameOfMovie: PaddingSizeModel(bottom: 250),
                    paddingSizeForImgOfMovie: PaddingSizeModel(top: 80, left: 10),
                    paddingSizeForDescriptionOfMovie:
                        PaddingSizeModel(top: 80, left: 200),
                    widthForImg: 150,
                    fontSizeNameOfMovie: 30,
                    fontSizeDiscriptionOfMovie: 20);
              }),
        ],
      ),
    );

  }
}
