import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_app/Model/Movie_model.dart';
import 'package:film_app/MVVM/ViewModel/List_movie_view_model.dart';
import 'package:film_app/MVVM/ViewModel/ViewModelMovie.dart';
import 'package:film_app/Widgets/Refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:film_app/BloC/Consts/Route_name_const.dart';

class Movies_list_MvvM extends StatefulWidget {
  const Movies_list_MvvM({Key? key}) : super(key: key);

  @override
  _Movies_list_MvvMState createState() => _Movies_list_MvvMState();
}

class _Movies_list_MvvMState extends State<Movies_list_MvvM> {
  List<String> movies_list = [];
  late List_movie_view_model list_movie_view_model = List_movie_view_model();
  final _selection = ValueNotifier<String>('null');
  late ViewModelMovie _modelMovie = new ViewModelMovie();
  late Movie _movie;

  _Movies_list_MvvMState();

  Future load_data() async {
    movies_list = await list_movie_view_model.apply_random_list();

    setState(() {
      this.list_movie_view_model = list_movie_view_model;
    });
  }

  Future get_data_movie() async {
    _movie = await _modelMovie.apply_movie(_selection.value);
    setState(() {
      this._modelMovie = _modelMovie;
      this._movie = _movie;
    });
  }

  @override
  void initState() {
    load_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      Widget buildList() {
        if (movies_list.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (constrains.maxWidth > 400) {
          return Row(
            children: [
              Container(
                width: 300,
                child: builtListView((value) {
                  setState(() {
                    _selection.value = value;
                    print(value);
                    this._movie = _modelMovie.apply_for_landscape(value);
                  });
                }),
              ),
              Expanded(
                  child: ValueListenableBuilder<String>(
                valueListenable: _selection,
                builder: (context, name, child) {
                  if (name == 'null') {
                    return Stack(
                      children: [
                        Center(
                          child: Text("select item"),
                        )
                      ],
                    );
                  } else {
                    get_data_movie();
                    try {
                      return Stack(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                  key: UniqueKey(),
                                  padding: EdgeInsets.only(bottom: 290),
                                  child: Center(
                                      key: UniqueKey(),
                                      child: Text(
                                        _movie.name_of_movie,
                                        style: TextStyle(fontSize: 42),
                                      ))),
                              Padding(
                                padding: EdgeInsets.only(top: 80, left: 10),
                                child: SizedBox(
                                  width: 150,
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    imageUrl: _movie.img,
                                  ),
                                ),
                              ),
                              Padding(
                                  key: UniqueKey(),
                                  padding: EdgeInsets.only(top: 80, left: 190),
                                  child: SizedBox(
                                      width: 300,
                                      child: Text(_movie.description_of_movie)))
                            ],
                          ),
                        ],
                      );
                    } catch (e) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              ))
            ],
          );
        }
        return Refresh_widget(
          onRefresh: load_data,
          child: Center(
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: ListView.builder(
                    itemCount: list_movie_view_model.random_list.length,
                    itemBuilder: (context, index) {
                      final item = list_movie_view_model.random_list[index];
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Route_name.info_mvvm, arguments: item);
                        },
                      );
                    })),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("Movie list MVVM"),
        ),
        body: buildList(),
      );
    });
  }

  Widget builtListView(ValueChanged onSelect) {
    return ListView.builder(
        itemCount: list_movie_view_model.random_list.length,
        itemBuilder: (context, index) {
          final item = list_movie_view_model.random_list[index];
          return ListTile(title: Text(item), onTap: () => onSelect(item));
        });
  }
}
