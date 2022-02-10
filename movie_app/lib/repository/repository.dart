import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

//delete import
class DataNetwork {
  final CollectionReference _movieCollection =
      FirebaseFirestore.instance.collection('descript_list');
  final CollectionReference _descCollection =
      FirebaseFirestore.instance.collection('description_of_movie');
  final CollectionReference _imgCollection =
      FirebaseFirestore.instance.collection('movie_img');
  List<String> _nameOfMovie = [];
  Map<String, dynamic> _decsOfMovie = {};
  Map<String, dynamic> _imgOfMovie = {};

  DataNetwork() {
    initFireBase();
  }

  Future initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future<List<String>?> getMovieList() async {
    try {
      var querySnapshot = await _movieCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data.forEach((key, value) {
          this._nameOfMovie.add(value);
        });
        return this._nameOfMovie;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getDescMap() async {
    try {
      var querySnapshot = await _descCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        this._decsOfMovie = data;
      }
      return this._decsOfMovie;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getImgMap() async {
    try {
      var querySnapshot = await _imgCollection.get();
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        _imgOfMovie = data;
      }
      return this._imgOfMovie;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  List<String> get nameOfMovie => _nameOfMovie;

  Map<String, dynamic> get decsOfMovie => _decsOfMovie;

  Map<String, dynamic> get imgOfMovie => _imgOfMovie;
}
