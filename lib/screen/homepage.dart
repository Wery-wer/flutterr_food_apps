import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/model/ratinguser.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:flutter_dev/screen/Melihat_profile.dart';
import 'package:flutter_dev/screen/filter_resep.dart';
import 'package:flutter_dev/screen/input_resep.dart';
import 'package:flutter_dev/screen/meilhat_resep.dart';
import 'package:flutter_dev/screen/meilhat_resep_senior.dart';
import 'package:flutter_dev/screen/alertLogout.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController profileController = TextEditingController();
  List<Resep> listresep = [];
  List<RatingUser> listrating = [];
  String tipe = "";
  String greeting = "";

  @override
  void initState() {
    updateGreeting();
    super.initState();
  }

  void updateGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 11) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour < 15) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else if (hour < 20) {
      setState(() {
        greeting = 'Good Evening';
      });
    } else {
      setState(() {
        greeting = 'Good Night';
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchresep();
    fetchrating();
    print(context.watch<user>().tipe_user);
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

  void fetchresep() async {
    final collectionresep = FirebaseFirestore.instance.collection('resep');
    //tipe = await context.read<user>().getTipe();
    if (context.watch<user>().tipe_user == "Cooker") {
      var data =
          await collectionresep.where("verifikasi", isEqualTo: true).get();
      if (mounted) {
        setState(() {
          listresep =
              List.from(data.docs.map((doc) => Resep.fromSnapshot(doc)));
        });
      }
    } else {
      var data =
          await collectionresep.where("verifikasi", isEqualTo: false).get();
      if (mounted) {
        setState(() {
          listresep =
              List.from(data.docs.map((doc) => Resep.fromSnapshot(doc)));
        });
      }
    }
  }

  void _profile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const seeProfile()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            Container(
              height: 130,
              width: 420,
              decoration: const BoxDecoration(
                  color: Color(0xFFE5737D),
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 10, left: 20),
                                child: const Icon(
                                  color: Color(0xFFFFFFFF),
                                  Icons.sunny_snowing,
                                ),
                              ),
                              Container(
                                child: Text(
                                  greeting,
                                  style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24),
                          child: Text(
                            "Welcome ${context.watch<user>().username}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const seeProfile())));
                        },
                        child: Image.asset(
                          "assets/images/people.png",
                          height: 30,
                          width: 27,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 140,
        backgroundColor: const Color(0xffe5737d),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        )),
      ),
      //===============================body==================================
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const homepage()));
        },
        child: Column(
          children: [
            //=====================================================food1================================================
            Expanded(
              child: ListView.builder(
                  itemCount: listresep.length,
                  itemBuilder: (context, index) {
                    if (index <= listresep.length) {
                      final totalrating = listrating
                          .where((element) =>
                              element.id_resep.contains(listresep[index].id))
                          .length;
                      final iniresep = listresep[index];
                      return tampilanfood(
                        iniresep: iniresep,
                        totalrating: totalrating,
                      );
                    }
                    return null;
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF), // Warna latar belakang
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0), // Radius untuk membuat ujung atas bulat
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: Offset(0, 2), // Atur offset bayangan sesuai kebutuhan
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 40,
                  color: Color(0xFFE5737D),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const inputPage()));
                }),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE5737D),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 40,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const filterResep()));
                  }),
            ),
            IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  size: 40,
                  color: Color(0xFFE5737D),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const alertLogout();
                      });
                })
          ],
        ),
      ),
    ));
  }
}

class tampilanfood extends StatelessWidget {
  final int totalrating;
  final Resep iniresep;
  const tampilanfood(
      {Key? key, required this.iniresep, required this.totalrating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (context.read<user>().tipe_user == "Cooker") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return melihatResep(
                iniresep: iniresep,
                totalrating: totalrating,
              );
            }));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return melihatResepSenior(iniresep: iniresep);
            }));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
          width: 350,
          height: 174,
          decoration: BoxDecoration(
            //color: Colors.black,
            image: DecorationImage(
                image: NetworkImage(iniresep.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.multiply)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                //margin: EdgeInsets.only(top: 110, left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 200,
                      child: Text(
                        iniresep.Nama_Masakan,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Popins",
                          fontSize: 19.78,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Text(
                        iniresep.Deskripsi_Masakan,
                        style: const TextStyle(
                          color: Color(0xFFA9A9A9),
                          fontFamily: "Popins",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 20),
                    width: 68,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.39),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                        Text(
                          (iniresep.bintang / totalrating).isNaN
                              ? "0"
                              : (iniresep.bintang / totalrating)
                                  .toStringAsFixed(1),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.38,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
