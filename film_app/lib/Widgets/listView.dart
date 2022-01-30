import 'package:film_app/Model/movieModel.dart';
import 'package:flutter/material.dart';

class movieListView extends StatelessWidget {
  final List<String> movies_list;
  final Function(String) onSelect;

  const movieListView(
      {Key? key, required this.movies_list, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies_list.length,
        itemBuilder: (context, index) {
          final item = movies_list[index];
          return ListTile(title: Text(item), onTap: () => onSelect(item));
        });
  }
}
