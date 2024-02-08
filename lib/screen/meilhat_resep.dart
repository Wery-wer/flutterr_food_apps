import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:flutter_dev/screen/rating_review.dart';
import 'package:provider/provider.dart';

class melihatResep extends StatefulWidget {
  Resep iniresep;
  int totalrating;

  melihatResep({Key? key, required this.iniresep, required this.totalrating})
      : super(key: key);

  @override
  State<melihatResep> createState() => _melihatResepState();
}

class _melihatResepState extends State<melihatResep> {
  bool isBookmarked = false;
  List<Resep> bookmark = [];

  @override
  void initState() {
    context.read<user>().fetchbookmark(context.read<user>().id_user);
    setState(() {
      bookmark = context
          .read<user>()
          .bookmark
          .where((resep) => resep.id.contains(widget.iniresep.id))
          .toList();
      isBookmarked = cekbookmark(bookmark);
    });
    super.initState();
  }

  bool cekbookmark(List<Resep> book) {
    return book.isNotEmpty;
  }

  void menujuRating() {
    context.read<Resep>().fetchresep(widget.iniresep.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RatingPage(iniresep: widget.iniresep);
    }));
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;

      if (isBookmarked) {
        context.read<user>().addbookmark(widget.iniresep);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Resep berhasil di tambahkan ke bookmark"),
          behavior: SnackBarBehavior.floating,
        ));
      } else {
        context.read<user>().removebookmark(widget.iniresep);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Resep berhasil di hapus dari bookmark"),
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
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
                    height: 370,
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
                                  margin: const EdgeInsets.only(
                                      left: 20, top: 5, bottom: 5),
                                  child: Text(
                                    widget.iniresep
                                        .Deskripsi_Masakan, //disi nama uploader
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(10, 0, 0, 0),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          (widget.iniresep.bintang /
                                                      widget.totalrating)
                                                  .isNaN
                                              ? "0"
                                              : (widget.iniresep.bintang /
                                                      widget.totalrating)
                                                  .toStringAsFixed(1),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(right: 20, bottom: 10),
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: isBookmarked
                                        ? const Icon(Icons.bookmark_outlined)
                                        : const Icon(Icons.bookmark_border_rounded),
                                    color: Colors.white,
                                    iconSize: 40,
                                    onPressed: toggleBookmark,
                                  ),
                                ),
                              ],
                            )
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
                        Icons.arrow_back_ios_outlined,
                        color: Color(0xffe5737d),
                      ),
                      onPressed: () {
                        Navigator.pop(context, "bookmark");
                      },
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Column(
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
                          child: Text(
                              widget.iniresep.Cara_Membuat)) //isi dari database
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                Container(
                  height: 50,
                  width: 350,
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: ElevatedButton(
                      onPressed: menujuRating,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text('Tambahkan Rating'),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Row(
                                children: List.generate(5, (index) {
                                  return const Icon(Icons.star_border_outlined,
                                      color: Colors.amber);
                                }),
                              ))
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
