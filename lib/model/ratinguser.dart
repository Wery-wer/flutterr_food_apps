import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class RatingUser extends ChangeNotifier {
  String id_resep;
  int bintang;
  String nama;
  String komentar;

  RatingUser({
    this.id_resep = "",
    this.bintang = 0,
    this.komentar = "",
    this.nama = "",
  });

  Map<String, dynamic> toJson() => {
        'id_resep': id_resep,
        'bintang': bintang,
        'nama': nama,
        'komentar': komentar,
      };

  RatingUser.fromSnapshot(snapshot)
      : id_resep = snapshot.data()['id_resep'],
        bintang = snapshot.data()['bintang'],
        nama = snapshot.data()['nama'],
        komentar = snapshot.data()['komentar'];

  void setid_resep(String id) {
    id_resep = id;
  }

  String getid_resep() {
    return id_resep;
  }

  void inputrating(String id, int bintang, String nama, String komentar) async {
    try {
      final docrating = FirebaseFirestore.instance.collection('ratingreview');
      final data = {
        'id_resep': id,
        'bintang': bintang,
        'nama': nama,
        'komentar': komentar,
      };
      await docrating.add(data);
    } catch (error) {}
  }
}

List<RatingUser> ratingusers = [
  RatingUser(id_resep: "1", bintang: 4, komentar: "komentar", nama: "W**y"),
  RatingUser(id_resep: "1", bintang: 4, komentar: "komentar", nama: "W**y"),
  RatingUser(id_resep: "1", bintang: 4, komentar: "komentar", nama: "W**y"),
];
