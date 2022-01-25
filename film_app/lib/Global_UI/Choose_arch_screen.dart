import 'package:film_app/BloC/Consts/Route_name_const.dart';
import 'package:film_app/Storage/Data.dart';
import 'package:film_app/Networking/Network.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  Data_networking data = Data_networking();
  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choose arch"),
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
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Route_name.movie_list_block),
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
                    Navigator.of(context).pushNamed(Route_name.movie_list_mvvm);
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
