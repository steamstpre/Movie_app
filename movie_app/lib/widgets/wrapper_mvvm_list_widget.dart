import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_info_model.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/view_model/list_Movie_View_Model.dart';
import 'package:movie_app/widgets/wrapper_mvvm_description_widget.dart';

import 'list_view_widget.dart';

class WrapperMvvMList extends StatefulWidget with Wrapper {
  String? selectedMovie;
  List<String> moviesList = [];

  WrapperMvvMList({Key? key}) : super(key: key);

  @override
  _WrapperMvvMListState createState() => _WrapperMvvMListState();
}

class _WrapperMvvMListState extends State<WrapperMvvMList> {
  ListMovieViewModel listMovieViewModel = ListMovieViewModel();
  late MovieInfo _movieInfo;
  final _selection = ValueNotifier<String?>(null);
  late Widget _listView;

  Future loadData() async {
    this.widget.moviesList = await listMovieViewModel.applyRandomList();

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
      moviesList: this.widget.moviesList,
      onSelect: (item) {
        setState(() {
          this._selection.value = item;

          this.widget.selectedMovie = item;
          this._movieInfo = new MovieInfo("MvvM", item);
        });
        if (MediaQuery.of(context).orientation ==
            Orientation.portrait) {
          Navigator.of(context)
              .pushNamed(DetailScreen.route, arguments: this._movieInfo);
        }
      },
    );
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return RefreshIndicator(
        onRefresh: loadData,
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
        ],
      );
    }
  }
}
