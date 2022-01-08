import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_qr/mdels/carnet_model.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/scanner_qr_page.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/widgets/item_carnet_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListCardPage extends StatefulWidget {
  const ListCardPage({Key? key}) : super(key: key);

  @override
  _ListCardPageState createState() => _ListCardPageState();
}

class _ListCardPageState extends State<ListCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: COLOR_FONT_PRIMARY,
        ),
        title: const Center(
          child: Text(
            "VacunApp",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: COLOR_FONT_PRIMARY,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/bx-hive.svg",
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: DBAdmin.db.getCarnetList(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  List<CarnetModel> carnetList = snap.data;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mis Carnets Registrados",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: COLOR_FONT_PRIMARY,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: carnetList.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return ItemCarnetWidget(
                                  fullName: carnetList[index].fullName,
                                  dni: carnetList[index].dni,
                                  url: carnetList[index].url);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xffF45E29),
                      ),
                    ],
                  ),
                );
              }),
          const SizedBox(
            height: 100.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 54.0,
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF45E29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScannerQRPage()));
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text(
                  "Escanear QR",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
