import 'package:flutter/material.dart';
import 'package:movie_app/models/wrraper_list_intarface.dart';
import 'package:movie_app/widgets/wrapper_bloc_description_widget.dart';
import 'package:movie_app/widgets/wrapper_bloc_list_widget.dart';
import 'package:movie_app/widgets/wrapper_mvvm_description_widget.dart';
import 'package:movie_app/widgets/wrapper_mvvm_list_widget.dart';

class LandScapeScreen extends StatefulWidget {
  static const route = "LandScapeScreen";
  String idArchitecture;
  String? selectedMovie;
  late Widget _wrapperDesc;
  late Wrapper _wrapperList;

  LandScapeScreen({Key? key, required this.idArchitecture, this.selectedMovie})
      : super(key: key) {
    if (this.idArchitecture == "Bloc") {
      _wrapperList = WrapperBlocList();
    } else {
      _wrapperList = WrapperMvvMList();
    }
  }

  @override
  _LandScapeScreenState createState() => _LandScapeScreenState();
}

class _LandScapeScreenState extends State<LandScapeScreen> {
  final _selection = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 300,
        child: this.widget._wrapperList as Widget,
      )
    ]);
  }
}
