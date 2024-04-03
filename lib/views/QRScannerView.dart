import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/SpecimenSearchController.dart';


class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  Barcode? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SizedBox(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomAppBar(
      child: ElevatedButton.icon(

        onPressed: () async {
          await controller?.toggleFlash();
          setState(() {});
        },
        icon: const Icon(

          Icons.flash_on,

          color: Colors.white,
        ),
        label: const Text(
          'Flash',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          elevation: 0.0,
        ),
      ),
    ),
  );
}


  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
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
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      // Update the labQr value in SpecimenSearchController
      final specimenSearchController = Get.find<SpecimenSearchController>();

      specimenSearchController.labQr.text = scanData.code!;
      // Navigate back to SpecimenSearchView
      Get.back();
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
}




//=========  الكود الاصلي =======

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       children: <Widget>[
//         Expanded(flex: 4, child: _buildQrView(context)),
//         // Expanded(
//         //   flex: 1,
//         //   child: FittedBox(
//         //     fit: BoxFit.contain,
//         //     child: Column(
//         //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //       children: <Widget>[
//         //         if (result != null)
//         //           Text(
//         //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//         //         else
//         //           const Text('Scan a code'),
//         //         Row(
//         //           mainAxisAlignment: MainAxisAlignment.center,
//         //           crossAxisAlignment: CrossAxisAlignment.center,
//         //           children: <Widget>[
//         //             Container(
//         //               margin: const EdgeInsets.all(8),
//         //               child: ElevatedButton(
//         //                 onPressed: () async {
//         //                   await controller?.toggleFlash();
//         //                   setState(() {});
//         //                 },
//         //                 child: FutureBuilder(
//         //                   future: controller?.getFlashStatus(),
//         //                   builder: (context, snapshot) {
//         //                     return Text('Flash: ${snapshot.data}');
//         //                   },
//         //                 ),
//         //               ),
//         //             ),
//         //             // Container(
//         //             //   margin: const EdgeInsets.all(8),
//         //             //   child: ElevatedButton(
//         //             //     onPressed: () async {
//         //             //       await controller?.flipCamera();
//         //             //       setState(() {});
//         //             //     },
//         //             //     child: FutureBuilder(
//         //             //       future: controller?.getCameraInfo(),
//         //             //       builder: (context, snapshot) {
//         //             //         if (snapshot.data != null) {
//         //             //           return Text(
//         //             //               'Camera facing ${describeEnum(snapshot.data!)}');
//         //             //         } else {
//         //             //           return const Text('loading');
//         //             //         }
//         //             //       },
//         //             //     ),
//         //             //   ),
//         //             // )
//         //           ],
//         //         ),
//         //         // Row(
//         //         //   mainAxisAlignment: MainAxisAlignment.center,
//         //         //   crossAxisAlignment: CrossAxisAlignment.center,
//         //         //   children: <Widget>[
//         //         //     Container(
//         //         //       margin: const EdgeInsets.all(8),
//         //         //       child: ElevatedButton(
//         //         //         onPressed: () async {
//         //         //           await controller?.pauseCamera();
//         //         //         },
//         //         //         child: const Text('Pause',
//         //         //             style: TextStyle(fontSize: 20)),
//         //         //       ),
//         //         //     ),
//         //         //     Container(
//         //         //       margin: const EdgeInsets.all(8),
//         //         //       child: ElevatedButton(
//         //         //         onPressed: () async {
//         //         //           await controller?.resumeCamera();
//         //         //         },
//         //         //         child: const Text('Resume',
//         //         //             style: TextStyle(fontSize: 20)),
//         //         //       ),
//         //         //     ),
//         //         //   ],
//         //         // ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ],
//     ),
//   );
// }
