
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {
  final List<String> moviesList;
  final Function(String) onSelect;

  const MovieListView(
      {Key? key, required this.moviesList, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: moviesList.length,
        itemBuilder: (context, index) {
          final item = moviesList[index];
          return ListTile(title: Text(item), onTap: () => onSelect(item));
        });
  }
}
