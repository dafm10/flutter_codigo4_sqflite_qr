import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/list_card_page.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Tu Carnet de vacunación",
              style: TextStyle(
                height: 1,
                fontSize: 46.0,
                fontWeight: FontWeight.w800,
                color: COLOR_FONT_PRIMARY,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
              style: TextStyle(
                height: 1.5,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: COLOR_FONT_PRIMARY.withOpacity(0.7),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Container(
              width: double.infinity,
              height: 54.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF45E29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ListCardPage()));
                },
                child: const Text(
                  "Explorar ahora",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
