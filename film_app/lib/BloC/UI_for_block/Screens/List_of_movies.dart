import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_app/BloC/BloC/Check_info.dart';
import 'package:film_app/BloC/BloC/List_of_movies_bloc.dart';
import 'package:film_app/BloC/Consts/Route_name_const.dart';
import 'package:film_app/BloC/UI_for_block/Screens/Info.dart';
import 'package:film_app/Model/Movie_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:film_app/Widgets/Refresh_widget.dart';
import 'package:flutter/material.dart';

class Movies_list extends StatefulWidget {
  const Movies_list({Key? key}) : super(key: key);

  @override
  _Movies_listState createState() => _Movies_listState();
}

class _Movies_listState extends State<Movies_list> {
  late List_of_movies_bloc _list_of_movies_bloc = new List_of_movies_bloc();
  List<String> movies_list = [];
  late final Check_info_bloc _check_info_bloc = new Check_info_bloc();
  late Movie _movie;
  final _selection = ValueNotifier<String>('null');

  @override
  void dispose() {
    this._list_of_movies_bloc.dispose();
    this._check_info_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      Widget buildList() {
        return Refresh_widget(
          onRefresh: _list_of_movies_bloc.new_list_apply,
          child: StreamBuilder(
              stream: _list_of_movies_bloc.outputStateStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  movies_list = snapshot.data as List<String>;
                  if (constrains.maxWidth < 400) {//change
                    return ListView.builder(
                        itemCount: movies_list.length,
                        itemBuilder: (context, index) {
                          final item = movies_list[index];
                          movies_list = snapshot.data as List<String>;
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Route_name.info_block,
                                  arguments: item);
                            },
                          );
                        });
                  } else {
                    return Row(
                      children: [
                        Container(
                          width: 300,
                          child: builtListView((value) {
                            setState(() {
                              _selection.value = value;
                            });
                          }),
                        ),
                        Expanded(   //scroll
                            child: ValueListenableBuilder<String>(//ValueListenableBuilder read
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
                            } else {//all number to const
                              return Container(
                                child: Stack(
                                  children: [
                                    StreamBuilder(
                                        stream:
                                            _check_info_bloc.outputStateStream,
                                        builder: (context, snapshot) {
                                          _check_info_bloc.inputIndexSink
                                              .add(name);
                                          if (snapshot.data == null) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          _movie = snapshot.data as Movie;
                                          return Stack(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 250),
                                                  child: Center(
                                                      child: Text(
                                                    _movie.name_of_movie,
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                    key: UniqueKey(),
                                                  ))),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 80, left: 10),
                                                child: SizedBox(
                                                  width: 150,
                                                  child: CachedNetworkImage(
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    imageUrl: _movie.img,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 80, left: 190),
                                                  child: SizedBox(
                                                      width: 300,
                                                      child: Text(_movie
                                                          .description_of_movie)))
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              );
                            }
                          },
                        ))
                      ],
                    );
                  }
                }
              }),
        );
      }

      return Scaffold(
          appBar: AppBar(
            title: Text("Movie list BloC"),
          ),
          body: buildList());
    });
  }

  Widget builtListView(ValueChanged onSelect) {
    return ListView.builder(
        itemCount: movies_list.length,
        itemBuilder: (context, index) {
          final item = movies_list[index];
          return ListTile(title: Text(item), onTap: () => onSelect(item));
        });
  }
}
