import 'package:flutter/material.dart';
import 'package:movie_app/bloc/list_Movies_Bloc.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/widgets/info_view_widget.dart';
import 'package:movie_app/widgets/list_view_widget.dart';
import 'package:movie_app/widgets/wrapper_bloc_description_widget.dart';

class WrapperBlocList extends StatefulWidget with Wrapper {
  String? selectedMovie;
  List<String> moviesList = [];

  WrapperBlocList({Key? key}) : super(key: key);

  @override
  _WrapperBlocListState createState() => _WrapperBlocListState();
}

class _WrapperBlocListState extends State<WrapperBlocList> {
  ListOfMoviesBloc _listOfMoviesBloc = new ListOfMoviesBloc();
  late MovieInfo _movieInfo;
  late Widget _listView;
  final _selection = ValueNotifier<String?>(null);

  @override
  void dispose() {
    this._listOfMoviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          this.widget.moviesList = snapshot.data as List<String>;
          this._listView = MovieListView(
              moviesList: this.widget.moviesList,
              onSelect: (item) {
                setState(() {
                  this.widget.selectedMovie = item;
                  this._movieInfo = new MovieInfo("Bloc", item);
                  this._selection.value = item;
                });
                if (MediaQuery.of(context).orientation ==
                    Orientation.portrait) {
                  Navigator.of(context).pushNamed(DetailScreen.route,
                      arguments: this._movieInfo);
                }
              });
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return RefreshIndicator(
                onRefresh: _listOfMoviesBloc.refreshList, child: _listView);
          } else {
            return Row(
              children: [
                Container(
                  child: SizedBox(
                    child: _listView,
                    width: 300,
                    height: 400,
                  ),
                ),
                Expanded(
                    child: ValueListenableBuilder<String?>(
                        valueListenable: _selection,
                        builder: (context, name, child) {
                          if (name == null) {
                            return Stack(
                              children: [
                                Center(
                                  child: Text("select item"),
                                )
                              ],
                            );
                          } else {
                            this._selection.value = null;
                            return WrapperBlocDescription(
                              nameOfMovie: name,
                            );
                          }
                        }))
              ],
            );
          }
        }
      },
      stream: _listOfMoviesBloc.outputStateStream,
    );
  }
}
