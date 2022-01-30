import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'navigator/routeGenerator.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    onGenerateRoute: Route_Generator.onGenerateRoute,
    onUnknownRoute: Route_Generator.onUnknownRoute,
  ));
}

