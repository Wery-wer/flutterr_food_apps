import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/model/ratinguser.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:flutter_dev/screen/homepage.dart';
import 'package:flutter_dev/screen/meilhat_resep.dart';
import 'package:flutter_dev/screen/meilhat_resep_senior.dart';
import 'package:provider/provider.dart';

class filterResep extends StatefulWidget {
  const filterResep({super.key});

  @override
  State<filterResep> createState() => _filterResepState();
}

class _filterResepState extends State<filterResep> {
  List<Resep> result = [];
  List<Resep> filtered = [];
  List<Resep> resep = [];
  List<RatingUser> listrating = [];
  bool isButton1Pressed = false;
  bool isButton2Pressed = false;
  bool isButton3Pressed = false;
  bool isButton4Pressed = false;
  bool isButton5Pressed = false;
  bool isButton6Pressed = false;
  bool isButton7Pressed = false;
  bool isButton8Pressed = false;
  bool filter = false;

  TextEditingController cariresepController = TextEditingController();
  TextEditingController harga1Controller = TextEditingController();
  TextEditingController harga2Controller = TextEditingController();
  TextEditingController harga3Controller = TextEditingController();
  TextEditingController harga4Controller = TextEditingController();
  TextEditingController harga5Controller = TextEditingController();
  TextEditingController harga6Controller = TextEditingController();
  TextEditingController harga7Controller = TextEditingController();
  TextEditingController harga8Controller = TextEditingController();

  @override
  void initState() {
    initresep();
    fetchrating();
    super.initState();
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

  void initresep() async {
    if (context.read<user>().tipe_user == "Cooker") {
      var data = await FirebaseFirestore.instance
          .collection('resep')
          .where('verifikasi', isEqualTo: true)
          .get();
      setState(() {
        resep = List.from(data.docs.map((doc) => Resep.fromSnapshot(doc)));
      });
    } else {
      var data = await FirebaseFirestore.instance
          .collection('resep')
          .where('verifikasi', isEqualTo: false)
          .get();
      setState(() {
        resep = List.from(data.docs.map((doc) => Resep.fromSnapshot(doc)));
      });
    }
  }

  void search(String value, String tipe) async {
    if (tipe == "Cooker") {
      var data = await FirebaseFirestore.instance
          .collection('resep')
          .where('verifikasi', isEqualTo: true)
          .get();

      setState(() {
        if (filter == false) {
          filtered = resep;
        }
        result = filtered
            .where((element) => element.Nama_Masakan
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        if (filter == false) {
          filtered = resep;
        }
        result = filtered
            .where((element) => element.Nama_Masakan
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  void _harga1() {
    setState(() {
      isButton1Pressed = !isButton1Pressed;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton1Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 8000 && element.Budget < 15000)
            .toList();
        result = filtered;
        filter = true;
        print(resep);
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga2() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = !isButton2Pressed;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton2Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 15000 && element.Budget < 30000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga3() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = !isButton3Pressed;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton3Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 30000 && element.Budget < 40000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga4() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = !isButton4Pressed;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton4Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 40000 && element.Budget < 50000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga5() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = !isButton5Pressed;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton5Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 50000 && element.Budget < 60000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga6() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = !isButton6Pressed;
      isButton7Pressed = false;
      isButton8Pressed = false;

      if (isButton6Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 60000 && element.Budget < 70000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga7() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = !isButton7Pressed;
      isButton8Pressed = false;

      if (isButton7Pressed == true) {
        filtered = resep
            .where(
                (element) => element.Budget >= 70000 && element.Budget < 80000)
            .toList();
        result = filtered;
        filter = true;
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  void _harga8() {
    setState(() {
      isButton1Pressed = false;
      isButton2Pressed = false;
      isButton3Pressed = false;
      isButton4Pressed = false;
      isButton5Pressed = false;
      isButton6Pressed = false;
      isButton7Pressed = false;
      isButton8Pressed = !isButton8Pressed;

      if (isButton8Pressed == true) {
        filtered = resep.where((element) => element.Budget > 80000).toList();
        result = filtered;
        filter = true;
        print(resep);
      } else {
        filter = false;
        filtered = resep;
        result = resep;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const homepage()));
          },
        ),
        backgroundColor: const Color(0xffe5737d),
        centerTitle: true,
        title: const Text(
          'Mencari Resep',
          style: TextStyle(
              color: Color.fromRGBO(236, 236, 236, 1),
              fontFamily: 'Rubik',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          (Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(50, 0, 0, 0), width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 6),
                          child: const Icon(
                            Icons.search,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) =>
                                  search(value, context.read<user>().tipe_user),
                              decoration: const InputDecoration(
                                hintText: 'eg : Baso Ikan',
                                hintStyle: TextStyle(
                                  color: Color(0xFFD9D9D9),
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                            ))
                      ],
                    ),
                  ),
                  //========container logo filter resep (pink)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                              builder: (BuildContext context) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 8),
                                  height: 250,
                                  width: 350,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    color: Color(0xFFE9E9E9),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 10),
                                        child: Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 7),
                                                child: Text(
                                                  'Harga',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //Row harga
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // container harga1
                                                Column(
                                                  children: [
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 25,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga1();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton1Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              child: Text(
                                                                'Rp.8000 - Rp15.Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton1Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    //container harga 3
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga3();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton3Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              child: Text(
                                                                'Rp.30rb - Rp15Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton3Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga5();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton5Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              child: Text(
                                                                'Rp.50rb - Rp59Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton5Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 5,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga7();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton7Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              child: Text(
                                                                'Rp.70rb - Rp79Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton7Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                  ],
                                                ),
                                                // ROW 2
                                                Column(
                                                  children: [
                                                    // container harga 2
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 19,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga2();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton2Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              child: Text(
                                                                'Rp.15 rb - Rp29 Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton2Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 19,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga4();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton4Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              child: Text(
                                                                'Rp.40 rb - Rp49 Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton4Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 19,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga6();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton6Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              child: Text(
                                                                'Rp.60 rb - Rp69 Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton6Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                    Container(
                                                        width: 141,
                                                        height: 30,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                                horizontal: 19,
                                                                vertical: 10),
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              _harga8();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor:
                                                                  Colors.black, backgroundColor: isButton8Pressed
                                                                  ? const Color(
                                                                      0xffe5737d)
                                                                  : Colors
                                                                      .white, // Set the shadow color
                                                              elevation:
                                                                  5, // Adjust the elevation to control the shadow intensity
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              minimumSize:
                                                                  const Size(150, 40),
                                                            ),
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              child: Text(
                                                                '> Rp 80 Rb',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        13,
                                                                    color: isButton8Pressed
                                                                        ? Colors
                                                                            .white
                                                                        : const Color(
                                                                            0xff393939)),
                                                              ),
                                                            ))),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe5737d),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Container(
                          child: Image.asset('assets/images/filter.png'),
                        )),
                  ),
                ],
              ),
            ],
          )),
          //buat list view builder filter resep
          Expanded(
            child: result.isEmpty
                ? const Center(
                    child: Text(
                      "Resep Tidak Ada",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff393939)),
                    ),
                  )
                : ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            final iniresep = result[index];
                            if (context.read<user>().tipe_user == "Cooker") {
                              if (index <= result.length) {
                                final totalrating = listrating
                                    .where((element) => element.id_resep
                                        .contains(result[index].id))
                                    .length;
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return melihatResep(
                                    iniresep: iniresep,
                                    totalrating: totalrating,
                                  );
                                }));
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return melihatResepSenior(iniresep: iniresep);
                                }));
                              }
                            }
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 3.0, left: 10),
                            title: Text(
                              result[index].Nama_Masakan,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff393939)),
                            ),
                            subtitle: Text(
                              result[index].Deskripsi_Masakan,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff393939)),
                            ),
                            leading: Container(
                              width: 130,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(result[index].image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        )),
          )
        ],
      ),
    ));
  }
}
