import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

class Data_networking {
  final CollectionReference _MovieCollection =
      FirebaseFirestore.instance.collection('descript_list');
  final CollectionReference _DescCollection =
      FirebaseFirestore.instance.collection('description_of_movie');
  final CollectionReference _ImgCollection =
      FirebaseFirestore.instance.collection('movie_img');
  List<String> _name_of_movie = [];
  Map<String, dynamic> _decs_of_movie = {};
  Map<String, dynamic> _img_of_movie = {};

  Data_networking() {
    init_fire_base();
  }

  Future init_fire_base() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future getMovieList() async {
    try {
      var querySnapshot = await _MovieCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data.forEach((key, value) {
          this._name_of_movie.add(value);
        });
          return this._name_of_movie;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDescMap() async {
    try {
      var querySnapshot = await _DescCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        this._decs_of_movie = data;
      }
      return this._decs_of_movie;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getImgMap() async {
    try {
      var querySnapshot = await _ImgCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        _img_of_movie = data;
      }
      return this._img_of_movie;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<String> get name_of_movie => _name_of_movie;

  Map<String, dynamic> get decs_of_movie => _decs_of_movie;

  Map<String, dynamic> get img_of_movie => _img_of_movie;
}
