import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< Updated upstream
import 'package:movie_app/screens/home_Screen.dart';
import 'navigator/route_generator.dart';

void main() async {
=======
import 'package:movie_app/bloc/bloc_observer.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'navigator/route_generator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
>>>>>>> Stashed changes
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: HomeScreen.route,
    onGenerateRoute: RouteGenerator.onGenerateRoute,
    onUnknownRoute: RouteGenerator.onUnknownRoute,
  ));
}
