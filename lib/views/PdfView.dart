
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/PdfViewController.dart';
import '../controllers/SpecimenSearchController.dart';


class PdfView extends GetView<PdfViewController> {
  final PdfViewController pdfViewController = Get.put(PdfViewController());
  final SpecimenSearchController specimenSearchController = Get.put(SpecimenSearchController());
   PdfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نتيجة تحليل العينة",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the color of the drawer icon to white
        ),
        backgroundColor: Colors.green,
        actions: [    IconButton(
          icon: const Icon(Icons.file_download),
          onPressed: () async {
            var specimenId=  specimenSearchController.specimen.id;
            final url = 'https://app.alfairouz.ly/api/public/specimen/report-colored/$specimenId'; // Replace with your PDF URL
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw Exception('Could not launch $url');
            }
          },
        ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final state = pdfViewController.downloadState.value;
          print('this is the state state ${state}');
          if (state is DownloadingState) {
            return Container(
              height: 120.0,
              width: 200.0,
              child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Downloading File: ${state.progressString}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CompletedState) {
            return PDFView(
              filePath: state.localFilePath,
            );
          } else {
            return Text("No Data");
          }
        }),
      ),
    );
  }
}

