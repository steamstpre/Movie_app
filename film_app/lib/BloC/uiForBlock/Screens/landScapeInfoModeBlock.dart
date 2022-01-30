import 'package:film_app/BloC/BloC/descriptionBlock.dart';
import 'package:film_app/BloC/Consts/paddingSizeModel.dart';
import 'package:film_app/Model/movieModel.dart';
import 'package:film_app/Widgets/infoView.dart';
import 'package:flutter/material.dart';

class landScapeInfo extends StatelessWidget {
  final Description_block _check_info_bloc = new Description_block();
  late Movie _movie;
  String name_of_movie;

  landScapeInfo({Key? key, required this.name_of_movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder(
              stream: _check_info_bloc.outputMovieController,
              builder: (context, snapshot) {
                _check_info_bloc.inputMovieNameController.add(name_of_movie);
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
    ;
  }
}
