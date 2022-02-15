import 'package:flutter/material.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
<<<<<<< Updated upstream
import 'package:movie_app/screens/landscape_screen.dart';
=======
>>>>>>> Stashed changes
import 'package:movie_app/widgets/wrapper_bloc_list_widget.dart';
import 'package:movie_app/widgets/wrapper_mvvm_list_widget.dart';

class ListViewScreen extends StatelessWidget {
<<<<<<< Updated upstream
  late Wrapper _wrapperList;
  static const route = "ListViewScreen";
  String idArchitecture;

  ListViewScreen({Key? key, required this.idArchitecture}) : super(key: key) {
    if (this.idArchitecture == "Bloc") {
      _wrapperList = WrapperBlocList();
    } else {
      _wrapperList = WrapperMvvMList();
    }
  }
=======
  static const route = "ListViewScreen";
  String idArchitecture;

  ListViewScreen({Key? key, required this.idArchitecture}) : super(key: key) {}
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie list"),
        ),
<<<<<<< Updated upstream
        body: _wrapperList as Widget
    );}
  }

=======
        body: (this.idArchitecture == "Bloc")
            ? WrapperBlocList()
            : WrapperMvvMList());
  }
}
>>>>>>> Stashed changes
