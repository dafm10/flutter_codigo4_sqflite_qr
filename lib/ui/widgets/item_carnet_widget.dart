
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCarnetWidget extends StatefulWidget {
  int id;
  String fullName;
  String dni;
  String url;
  Function onDeleted;
  Function onUpdate;

  ItemCarnetWidget(
      {required this.id,
      required this.fullName,
      required this.dni,
      required this.url,
      required this.onUpdate,
      required this.onDeleted});

  @override
  State<ItemCarnetWidget> createState() => _ItemCarnetWidgetState();
}

class _ItemCarnetWidgetState extends State<ItemCarnetWidget> {

  showDeleteBook(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF45E29),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: const Padding(
            padding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Text(
              "¿Deseas eliminar el enlace del carnet?",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      DBAdmin.db.deleteCarnet(id).then((value) {
                        setState(() {});
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 5.0,
          ),
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            offset: Offset(4, 4),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nombre:",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: COLOR_FONT_PRIMARY.withOpacity(0.6),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/bx-user.svg",
                      color: COLOR_FONT_PRIMARY.withOpacity(0.72),
                      height: 16.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      widget.fullName,
                      style: TextStyle(
                        color: COLOR_FONT_PRIMARY.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Número de DNI:",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: COLOR_FONT_PRIMARY.withOpacity(0.6),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/bx-card.svg",
                      color: COLOR_FONT_PRIMARY.withOpacity(0.72),
                      height: 12.0,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Text(
                      widget.dni,
                      style: TextStyle(
                        color: COLOR_FONT_PRIMARY.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              await launch(widget.url);
            },
            icon: SvgPicture.asset(
              "assets/icons/bx-link.svg",
              color: COLOR_FONT_PRIMARY,
            ),
          ),
          IconButton(
            onPressed: () {
              showDeleteBook(widget.id);
              setState(() {

              });
            },
            icon: SvgPicture.asset(
              "assets/icons/trash.svg",
              color: COLOR_FONT_PRIMARY,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
