import 'package:flutter/material.dart';
import 'package:movie_app/screens/list_view_screen.dart';

class HomeScreen extends StatelessWidget {
  late String? id;
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
                  onPressed: () {
                    this.id = "Bloc";
                    Navigator.of(context)
                        .pushNamed(ListViewScreen.route, arguments: id);
                  },
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
                    this.id = "Mvvm";
                    Navigator.of(context)
                        .pushNamed(ListViewScreen.route, arguments: id);
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
