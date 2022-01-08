import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_codigo4_sqflite_qr/pages/register_page.dart';
import 'package:flutter_codigo4_sqflite_qr/ui/general/colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQRPage extends StatefulWidget {
  const ScannerQRPage({Key? key}) : super(key: key);

  @override
  _ScannerQRPageState createState() => _ScannerQRPageState();
}

class _ScannerQRPageState extends State<ScannerQRPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? urlCarnet = "";
  bool isUrl = false;
  String pattern =
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    RegExp regExp = RegExp(pattern);
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          urlCarnet = result!.code;
          // identificamos si es o no un url
          isUrl = regExp.hasMatch(urlCarnet!);
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Carnet escaneado",
                    style: TextStyle(
                      color: COLOR_FONT_PRIMARY,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      isUrl ? urlCarnet! : "Por favor escanea un carnet",
                      maxLines: 2,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  /*urlCarnet != ""
                      ? Text(urlCarnet!)
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Por favor escanea un carnet",
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),*/
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    height: 54.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffF45E29),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      // si isUrl es true, se habilita el boton
                      onPressed: true
                          ? () {
                              // para cerrar la camara y evitar que siga consumiendo recursos
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                    url:
                                        "https://satechi.net/collections/stands",
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Text(
                        "Registrar carnet",
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
          ),
        ],
      ),
    );
  }
}

// web de pub.dev
// https://pub.dev/packages/qr_code_scanner/example
