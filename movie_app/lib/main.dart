import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app/screens/home_Screen.dart';
import 'navigator/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: HomeScreen.route,
    onGenerateRoute: RouteGenerator.onGenerateRoute,
    onUnknownRoute: RouteGenerator.onUnknownRoute,
  ));
}
