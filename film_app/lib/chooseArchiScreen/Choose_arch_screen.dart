import 'package:film_app/BloC/Consts/routeNameConst.dart';
import 'package:film_app/BloC/uiForBlock/Screens/listMoviesViewBlock.dart';
import 'package:film_app/MVVM/View/List_of_movies.dart';
import 'package:film_app/Storage/Data.dart';
import 'package:film_app/repositories/repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const route = "HomeScreen";
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choose arch"),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 130),
              child: SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(Movies_list.route),
                  child: Text("BloC"),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 130),
              child: SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Movies_list_MvvM.route);
                  },
                  child: Text("MVVM"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
