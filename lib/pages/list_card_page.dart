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
                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Mis Carnets Registrados",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                color: COLOR_FONT_PRIMARY,
                              ),
                            ),
                            carnetList.length > 0
                                ? RefreshIndicator(
                                    onRefresh: () async {
                                      setState(() {});
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: carnetList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ItemCarnetWidget(
                                          fullName: carnetList[index].fullName,
                                          dni: carnetList[index].dni,
                                          url: carnetList[index].url,
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.8,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/bx-box.svg",
                                          height: MediaQuery.of(context).size.height * 0.15,
                                          color: COLOR_FONT_PRIMARY,
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Text(
                                          "Aún no hay carnets registrados",
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 60.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        color: Color(0xffF45E29),
                      ),
                    ],
                  ),
                );
              }),
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
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text(
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
