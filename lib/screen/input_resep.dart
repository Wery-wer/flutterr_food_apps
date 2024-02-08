import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dev/model/Profile.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:flutter_dev/screen/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:provider/provider.dart';

class inputPage extends StatefulWidget {
  const inputPage({super.key});

  @override
  State<inputPage> createState() => _inputPageState();
}

class _inputPageState extends State<inputPage> {
  TextEditingController judulController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController bahanController = TextEditingController();
  TextEditingController caraController = TextEditingController();
  String imageurl = '';
  File? image;

  @override
  void initState() {
    super.initState();
    imageurl = context.read<Resep>().image;
  }

  Future getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imagePicked =
          await picker.pickImage(source: ImageSource.gallery);
      image = File(imagePicked!.path);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _unggah(File? file) async {
    print(context.read<user>().tipe_user);
    String judul = judulController.text;
    int harga = int.parse(hargaController.text);
    String bahan = bahanController.text;
    String cara = caraController.text;

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImg = referenceRoot.child('resep');
    Reference uploadimg = referenceDirImg.child(judul);
    try {
      await uploadimg.putFile(File(file!.path));
      print("berhasil");
      imageurl = await uploadimg.getDownloadURL();
      print("berhasil2");
    } catch (error) {}
    context.read<Resep>().uploadResep(
        judul: judul,
        harga: harga,
        bahan: bahan,
        cara: cara,
        uid: context.read<Profile>().nama,
        image: imageurl);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xffe5737d),
            centerTitle: true,
            title: const Text(
              'Input Resep',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                'Foto',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Nuito Sans',
                                    fontWeight: FontWeight.bold),
                              )),
                          image != null
                              ? Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      image!,
                                      width: 120,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 110,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(10, 0, 0, 0),
                                      border: Border.all(
                                          color:
                                              const Color.fromARGB(15, 0, 0, 0),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.image_outlined,
                                      color: Color(0xffe5737d),
                                    ),
                                    onPressed: () async {
                                      await getImage();
                                    },
                                    iconSize: 90,
                                  ),
                                )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              'Judul',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nuito Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          customTextField(
                              controller: judulController,
                              hintText: 'Masukkan Judul Makanan'),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Text(
                              'Harga',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Nuito Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          customTextField(
                              controller: hargaController,
                              hintText: 'Masukkan Harga Makanan'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                child: (const Text(
                  'Bahan - bahan',
                  style: TextStyle(
                    fontFamily: 'Nuito Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              Container(
                width: 360,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: bahanController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: const Color.fromARGB(20, 0, 0, 0),
                      filled: true,
                      hintText: 'Masukkan alat dan bahan makanan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                child: (const Text(
                  'Cara Memasak',
                  style: TextStyle(
                    fontFamily: 'Nuito Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              Container(
                width: 360,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: caraController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: const Color.fromARGB(20, 0, 0, 0),
                      filled: true,
                      hintText: 'Masukkan langkah-langkah membuat makanan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 90,
                child: ElevatedButton(
                  onPressed: () {
                    _unggah(image);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color(0xffe5737d), // Ubah warna teks
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(150, 40),
                  ),
                  child: Container(
                    child: const Text('Unggah'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class customTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const customTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: controller,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xffA9A9A9),
                      )),
                  hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}
