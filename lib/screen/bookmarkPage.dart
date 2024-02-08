import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/model/ratinguser.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dev/model/Profile.dart';
import 'package:flutter_dev/widget/thumbnail_resep.dart';

class bookmarkPage extends StatefulWidget {
  const bookmarkPage({Key? key}) : super(key: key);

  @override
  State<bookmarkPage> createState() => _bookmarkPage();
}

class _bookmarkPage extends State<bookmarkPage> {
  List<Resep> listbookmark = [];
  List<RatingUser> listrating = [];
  File? image;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchrating();
      context.read<user>().fetchbookmark(context.read<user>().id_user);
    });
  }

  void fetchrating() async {
    final ratingreviewcollection =
        FirebaseFirestore.instance.collection('ratingreview');
    var data = await ratingreviewcollection.get();
    if (mounted) {
      setState(() {
        listrating =
            List.from(data.docs.map((doc) => RatingUser.fromSnapshot(doc)));
      });
    }
  }

  // void getbookmark() async {
  //   List<dynamic> bookmarktemp = [];
  //   final usercollection = FirebaseFirestore.instance.collection('user');
  //   var doc = await usercollection.doc(context.read<user>().id_user).get();
  //   if (doc.exists) {
  //     Map<String, dynamic> data = doc.data()!;
  //     bookmarktemp = data['bookmark'];
  //     print(bookmarktemp);

  //     if (bookmarktemp.isEmpty) {
  //       setState(() {
  //         listbookmark = [];
  //         print(listbookmark);
  //       });
  //     } else {
  //       final resepcollection = FirebaseFirestore.instance.collection('resep');
  //       QuerySnapshot resepsnapshot = await resepcollection
  //           .where(FieldPath.documentId, whereIn: bookmarktemp)
  //           .get();
  //       setState(() {
  //         listbookmark = List.from(
  //             resepsnapshot.docs.map((doc) => Resep.fromSnapshot(doc)));
  //         print(listbookmark);
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xffe5737d),
          centerTitle: true,
          title: const Text(
            'Bookmark',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Rubik',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffe5737d),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(14)),
                    ),
                    child: (Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      context.watch<Profile>().image),
                                  fit: BoxFit.cover),
                            ))
                      ],
                    )),
                  ),
                ],
              ),
              Container(
                child: Expanded(
                  child: ListView.builder(
                      itemCount: context.watch<user>().bookmark.length,
                      itemBuilder: (context, index) {
                        if (index <= context.watch<user>().bookmark.length) {
                          final totalrating = listrating
                              .where((element) => element.id_resep.contains(
                                  context.watch<user>().bookmark[index].id))
                              .length;
                          final iniresep =
                              context.watch<user>().bookmark[index];
                          return thumbnailResep(
                            iniresep: iniresep,
                            rating: totalrating,
                          );
                        }
                        return null;
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
