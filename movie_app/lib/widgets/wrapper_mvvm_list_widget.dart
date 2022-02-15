import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/view_model/list_Movie_View_Model.dart';
import 'package:movie_app/widgets/wrapper_mvvm_description_widget.dart';

import 'list_view_widget.dart';

<<<<<<< Updated upstream
class WrapperMvvMList extends StatefulWidget with Wrapper {
  String? selectedMovie;
  List<String> moviesList = [];

=======
class WrapperMvvMList extends StatefulWidget {
>>>>>>> Stashed changes
  WrapperMvvMList({Key? key}) : super(key: key);

  @override
  _WrapperMvvMListState createState() => _WrapperMvvMListState();
}

class _WrapperMvvMListState extends State<WrapperMvvMList> {
  ListMovieViewModel listMovieViewModel = ListMovieViewModel();
  late MovieInfo _movieInfo;
<<<<<<< Updated upstream
  final _selection = ValueNotifier<String?>(null);
  late Widget _listView;

  Future loadData() async {
    this.widget.moviesList = await listMovieViewModel.applyRandomList();
=======
  String? selectedMovie;
  late Widget _listView;
  late List<String> moviesList;

  Future<void> loadData() async {
    this.moviesList = await listMovieViewModel.applyRandomList();
>>>>>>> Stashed changes

    setState(() {
      this.listMovieViewModel = listMovieViewModel;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._listView = MovieListView(
<<<<<<< Updated upstream
      moviesList: this.widget.moviesList,
      onSelect: (item) {
        setState(() {
          this._selection.value = item;

          this.widget.selectedMovie = item;
          this._movieInfo = new MovieInfo("MvvM", item);
        });
        if (MediaQuery.of(context).orientation ==
            Orientation.portrait) {
=======
      moviesList: this.moviesList,
      onSelect: (item) {
        setState(() {
          //this._selection.value = item;

          this.selectedMovie = item;
          this._movieInfo = new MovieInfo("MvvM", item);
        });
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
>>>>>>> Stashed changes
          Navigator.of(context)
              .pushNamed(DetailScreen.route, arguments: this._movieInfo);
        }
      },
    );
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return RefreshIndicator(
<<<<<<< Updated upstream
        onRefresh: loadData,
=======
        onRefresh: () async {
          this.moviesList = await listMovieViewModel.applyRandomList();
        },
>>>>>>> Stashed changes
        child: _listView,
      );
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
                      return WrapperMvvMDescription(
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
                      String movie = this.selectedMovie as String;
                     // this.selectedMovie = null;
                      return WrapperMvvMDescription(
                        nameOfMovie: this.selectedMovie,
                      );
                    }))
>>>>>>> Stashed changes
        ],
      );
    }
  }
}
