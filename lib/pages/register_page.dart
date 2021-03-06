import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo4_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo4_sqflite_qr/mdels/carnet_model.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  String url;

  RegisterPage({required this.url});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // para identificar de forma global el formulario usado dentro del padding
  final _keyForm = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _dniController = TextEditingController();

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
                // añadirmos el key para identificar el formulario
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 12.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      // cambiamos los TextField por TextFormField
                      child: TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          hintText: "Nombre Completo",
                          hintStyle: TextStyle(
                            color: COLOR_FONT_PRIMARY.withOpacity(0.3),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xffF45E29),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // atributo del TextFormField
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "El campo no deb estar vacío";
                          }
                          return null;
                        },
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.04),
                            blurRadius: 10.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _dniController,
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
                          filled: true,
                          fillColor: Colors.white,
                          counterText:
                              "", // para quitar el contador de caracteres
                          errorStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xffF45E29),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // atributo del TextFormField
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "El campo no puede estar vación";
                          }
                          if (value.length < 8) {
                            return "Ingrese como mínimo 8 caracteres";
                          }
                          return null;
                        },
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
                onPressed: () {
                  // se ejecuta esto siempre y cuando la validación sea correcta
                  if (_keyForm.currentState!.validate()) {
                    CarnetModel carnet = CarnetModel(
                      fullName: _fullNameController.text,
                      dni: _dniController.text,
                      url: widget.url,
                    );
                    DBAdmin.db.insertCarnet(carnet).then((value) {
                      if (value >= 0) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Color(0xff02c39a),
                            elevation: 5,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Carnet Agregado con éxito",
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
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
