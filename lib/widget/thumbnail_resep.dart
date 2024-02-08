import 'package:flutter/material.dart';
import 'package:flutter_dev/model/Resep.dart';
import 'package:flutter_dev/model/user.dart';
import 'package:flutter_dev/screen/meilhat_resep.dart';
import 'package:provider/provider.dart';

class thumbnailResep extends StatefulWidget {
  final Resep iniresep;
  final int rating;
  const thumbnailResep({Key? key, required this.iniresep, required this.rating})
      : super(key: key);

  @override
  State<thumbnailResep> createState() => _thumbnailResepState();
}

class _thumbnailResepState extends State<thumbnailResep> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          String status = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return melihatResep(
              iniresep: widget.iniresep,
              totalrating: widget.rating,
            );
          }));
          if (status == "bookmark") {
            context.read<user>().fetchbookmark(context.read<user>().id_user);
          }
        },
        child: Container(
            margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
            width: 350,
            height: 174,
            decoration: BoxDecoration(
              //color: Colors.black,
              image: DecorationImage(
                  image: NetworkImage(widget.iniresep.image),
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
                          widget.iniresep.Nama_Masakan,
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
                          widget.iniresep.Deskripsi_Masakan,
                          style: const TextStyle(
                            color: Color(0xFFA9A9A9),
                            fontFamily: "Popins",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, left: 270),
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
                          (widget.iniresep.bintang / widget.rating).isNaN
                              ? "0"
                              : (widget.iniresep.bintang / widget.rating)
                                  .toStringAsFixed(1),
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14.38,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ],
            )));
  }
}
