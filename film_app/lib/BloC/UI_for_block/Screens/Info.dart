import 'package:film_app/BloC/BloC/Check_info.dart';
import 'package:film_app/Model/Movie_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Info extends StatefulWidget {
  final String name_of_movie;

  Info({
    Key? key,
    required this.name_of_movie,
  }) : super(key: key);

  @override
  _InfoState createState() => _InfoState(this.name_of_movie);
}

class _InfoState extends State<Info> {
  final String name_of_movie;
  late final Check_info_bloc _check_info_bloc;
  late Movie _movie;

  _InfoState(this.name_of_movie);

  @override
  void initState() {
    super.initState();
    _check_info_bloc = Check_info_bloc();
  }

  @override
  void dispose() {
    _check_info_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      return Scaffold(
        appBar: AppBar(title: Text("Info")),
        body: Stack(
          children: [
            StreamBuilder(
                stream: _check_info_bloc.outputStateStream,
                builder: (context, snapshot) {
                  _check_info_bloc.inputIndexSink.add(name_of_movie);
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  _movie = snapshot.data as Movie;
                  return Stack(
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
                          padding:
                              EdgeInsets.only(top: 390, left: 13, right: 13),
                          child: Text(_movie.description_of_movie))
                    ],
                  );
                }),
          ],
        ),
      );
    });
  }
}
