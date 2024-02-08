import 'package:flutter/foundation.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends ChangeNotifier {
  String id_user;
  String nama;
  int usia;
  String jenis_Kelamin;
  String tanggal_lahir;
  String image;

  void setid(String uid) {
    id_user = uid;
  }

  Profile(
      {this.id_user = "",
      this.nama = "",
      this.usia = 0,
      this.jenis_Kelamin = "",
      this.tanggal_lahir = "",
      this.image =
          "https://firebasestorage.googleapis.com/v0/b/cookos.appspot.com/o/profile%2Fprofile-default.jpg?alt=media&token=38acbbcf-98f5-4530-af90-3a16d1be875e"});

  Future<void> changeProfile(
      {required String n,
      required int u,
      required String jk,
      required String tl,
      required String img}) async {
    final docprofile = FirebaseFirestore.instance.collection('profile');
    nama = n;
    usia = u;
    jenis_Kelamin = jk;
    tanggal_lahir = tl;
    image = img;
    final data = {
      'nama': n,
      'usia': u,
      'jenis_Kelamin': jk,
      'tanggal_lahir': tl,
      'image': img,
    };
    await docprofile.doc(id_user).update(data);
    notifyListeners();
  }

  void setuser(String uid) {
    id_user = uid;
  }

  String getnama() {
    return nama;
  }

  Future<void> fetchprofile(String id) async {
    try {
      final docprofile = FirebaseFirestore.instance.collection('profile');
      var doc = await docprofile.doc(id).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data()!;
        id_user = id;
        nama = data['nama'];
        usia = data['usia'];
        jenis_Kelamin = data['jenis_Kelamin'];
        tanggal_lahir = data['tanggal_lahir'];
        image = data['image'];
        notifyListeners();
        print("imageee");
        print(image);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> createprofile(String uid) async {
    try {
      final docprofile = FirebaseFirestore.instance.collection('profile');
      final data = {
        'nama': "",
        'usia': 0,
        'jenis_Kelamin': "",
        'tanggal_lahir': "",
        'image':
            "https://firebasestorage.googleapis.com/v0/b/cookos.appspot.com/o/profile%2Fprofile-default.jpg?alt=media&token=38acbbcf-98f5-4530-af90-3a16d1be875e",
      };
      await docprofile.doc(uid).set(data);
    } on FirebaseException catch (error) {
      print(error);
    }
  }
}
