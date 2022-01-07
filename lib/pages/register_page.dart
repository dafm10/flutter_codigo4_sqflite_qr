import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // para identificar de forma global el formulario usado dentro del padding
  final _keyForm = GlobalKey<FormState>();

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
            "Agregar Carnet",
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nombre Completo:",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: COLOR_FONT_PRIMARY,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 12.0,
                            offset: Offset(4,4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Nombre Completo",
                            hintStyle: TextStyle(
                              color: COLOR_FONT_PRIMARY.withOpacity(0.3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Número de DNI:",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: COLOR_FONT_PRIMARY,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 12.0,
                            offset: Offset(4,4),
                          ),
                        ],
                      ),
                      child: TextField(
                        // para habilitar solo teclado de numeros
                        keyboardType: TextInputType.number,
                        maxLength: 8, // el maximo de caracteres
                        // hacemos que solo se ingresen números
                        // usando expresiones regulares
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                            hintText: "Número de DNI",
                            hintStyle: TextStyle(
                              color: COLOR_FONT_PRIMARY.withOpacity(0.3),
                            ),
                            counterText: "", // para quitar el contador de caracteres
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 54.0,
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffF45E29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Agregar Carnet",
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
