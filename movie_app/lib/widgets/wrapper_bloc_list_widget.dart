import 'package:flutter/material.dart';
import 'package:movie_app/bloc/list_Movies_Bloc.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/widgets/info_view_widget.dart';
import 'package:movie_app/widgets/list_view_widget.dart';
import 'package:movie_app/widgets/wrapper_bloc_description_widget.dart';

<<<<<<< Updated upstream
class WrapperBlocList extends StatefulWidget with Wrapper {
  String? selectedMovie;
  List<String> moviesList = [];

=======
class WrapperBlocList extends StatefulWidget {
>>>>>>> Stashed changes
  WrapperBlocList({Key? key}) : super(key: key);

  @override
  _WrapperBlocListState createState() => _WrapperBlocListState();
}

class _WrapperBlocListState extends State<WrapperBlocList> {
  ListOfMoviesBloc _listOfMoviesBloc = new ListOfMoviesBloc();
  late MovieInfo _movieInfo;
  late Widget _listView;
<<<<<<< Updated upstream
  final _selection = ValueNotifier<String?>(null);
=======
  late List<String> moviesList;
  String? selectedMovie;
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
          this.widget.moviesList = snapshot.data as List<String>;
          this._listView = MovieListView(
              moviesList: this.widget.moviesList,
              onSelect: (item) {
                setState(() {
                  this.widget.selectedMovie = item;
                  this._movieInfo = new MovieInfo("Bloc", item);
                  this._selection.value = item;
=======
          this.moviesList = snapshot.data as List<String>;
          this._listView = MovieListView(
              moviesList: this.moviesList,
              onSelect: (item) {
                setState(() {
                  this.selectedMovie = item;
                  this._movieInfo = new MovieInfo("Bloc", item);
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
                    child: (this.selectedMovie == null)
                        ? Stack(
                            children: [
                              Center(
                                child: Text("select item"),
                              )
                            ],
                          )
                        : LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                            try {
                              String movie = this.selectedMovie as String;
                              return WrapperBlocDescription(
                                nameOfMovie: movie,
                              );
                            } catch (e) {
                              return Center(
                                child: Text("select item"),
                              );
                            }
                            selectedMovie = null;
                          }))
>>>>>>> Stashed changes
              ],
            );
          }
        }
      },
      stream: _listOfMoviesBloc.outputStateStream,
    );
  }
}
