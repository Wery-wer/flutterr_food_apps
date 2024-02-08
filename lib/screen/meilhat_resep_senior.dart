import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/screen/homepage.dart';

class melihatResepSenior extends StatefulWidget {
  Resep iniresep;
  melihatResepSenior({Key? key, required this.iniresep}) : super(key: key);

  @override
  State<melihatResepSenior> createState() => _melihatResepSeniorState();
}

class _melihatResepSeniorState extends State<melihatResepSenior> {
  bool isBookmarked = false;

  void _verificate() async {
    final ResepCollection =
        FirebaseFirestore.instance.collection('resep').doc(widget.iniresep.id);
    ResepCollection.update({'verifikasi': true});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe5737d),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0,
                              4), // Horizontal and vertical offset of the shadow
                          blurRadius: 6, // Spread of the shadow
                          spreadRadius:
                              0, // Positive value will expand the shadow, negative value will shrink it
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      widget.iniresep
                                          .Nama_Masakan, //diisi nama resep
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                                  child: Text(
                                    widget.iniresep
                                        .Deskripsi_Masakan, //disi nama uploader
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: _verificate,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xffe5737d), backgroundColor: const Color.fromARGB(255, 255, 255,
                                      255), // Ubah warna teks
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: const Size(100, 40),
                                ),
                                child: const Text(
                                  'Verificate',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 260,
                      width: double.infinity,
                      child: Image.network(
                        widget.iniresep.image,
                        fit: BoxFit.fill,
                      ) //Diisi gambar resep database
                      ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 10, top: 20),
                    height: 100,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context, "");
                      },
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 350,
                    constraints: const BoxConstraints(maxHeight: double.infinity),
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(70, 0, 0, 0), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 350,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(50, 0, 0, 0),
                                      width: 2))),
                          child: Container(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: const Text(
                                'Bahan - bahan',
                                style: TextStyle(
                                    fontFamily: 'Nuito Sans',
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child:
                                Text(widget.iniresep.Bahan)) //isi dari database
                      ],
                    ),
                  ),
                  Container(
                    width: 350,
                    constraints: const BoxConstraints(maxHeight: double.infinity),
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(70, 0, 0, 0), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 350,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(50, 0, 0, 0),
                                      width: 2))),
                          child: Container(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: const Text(
                                'Cara Memasak',
                                style: TextStyle(
                                    fontFamily: 'Nuito Sans',
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Text(widget
                                .iniresep.Cara_Membuat)) //isi dari database
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(70, 0, 0, 0), width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset('assets/images/money.png'),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Text(
                                    'Estimasi Harga',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Text(
                              'Rp ${widget.iniresep.Budget},-',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
