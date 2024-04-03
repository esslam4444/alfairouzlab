import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/HomeController.dart';
import '../controllers/HomePdfViewController.dart';
import '../controllers/SearchHomeSpecimenController.dart';
import '../controllers/SpecimenDetailsController.dart';
import '../controllers/SpecimensController.dart';
import '../routes/app_pages.dart';
import 'HomePdfView.dart';
import 'PdfView.dart';
import 'QRScannerView.dart';
import 'SpecimenDetailsView.dart';

class SearchHomeSpecimenView extends GetView<SearchHomeSpecimenController> {
  final HomePdfViewController homePdfViewController =
  Get.put(HomePdfViewController());
  final SpecimenDetailsController specimenDetailsController =
  Get.put(SpecimenDetailsController());

  final SearchHomeSpecimenController searchHomeSpecimenController =
  Get.put(SearchHomeSpecimenController());

  final ScrollController scrollController = ScrollController();

  SearchHomeSpecimenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapped outside the TextField
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<SearchHomeSpecimenController>(
        init: SearchHomeSpecimenController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, // Set the color of the drawer icon to white
              ),
              backgroundColor: Colors.green,
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSearchBar(),
              ),
            ),
            body: Obx(() {
              if (_.loading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_.isRequestBad.value) {
                return  Center( child:
                Text('  الشخص او العينة غير متوفران',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red),));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _.specimens.length,
                    itemBuilder: (context, index) {
                      final specimen = _.specimens[index];
                      return GestureDetector(
                        onTap: () {
                          final controller = Get.find<SpecimenDetailsController>();
                          controller.specimenId.value = specimen?.id ?? 0;
                          controller.findBySpecimenId();
                          Get.to(SpecimenDetailsView());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                tileColor: Colors.white,
                                leading: Text((index + 1).toString()),
                                title: Text(
                                  specimen?.patient?.nameAr ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(specimen?.specimenStatus.toString() ?? ''),
                                trailing: specimen?.specimenStatus == 'READY'
                                    ? ElevatedButton(
                                  onPressed: () {
                                    final controller = Get.find<HomePdfViewController>();
                                    controller.specimenId.value = specimen?.id ?? 0;
                                    controller.downloadFile();
                                    Get.to(HomePdfView());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.lightGreen,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'التقرير',
                                    style: TextStyle(color: Colors.lightGreen),
                                  ),
                                )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'ابحث هنا',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the border radius
          borderSide: BorderSide.none, // Remove the border
        ),
        filled: true,
        fillColor: Colors.grey[200], // Set the background color
        prefixIcon: Icon(Icons.search, color: Colors.grey), // Add a search icon
        contentPadding: EdgeInsets.symmetric(vertical: 12.0), // Adjust the vertical padding
        isDense: true, // Reduce the height of the TextField
      ),
      style: TextStyle(color: Colors.black),
      controller: searchHomeSpecimenController.query,
      onSubmitted: (_) async {
        // Hide the keyboard
       // FocusScope.of(context).unfocus();

        // Perform the search
        await searchHomeSpecimenController.search();

        // Add any additional logic you need after search is performed
      },
      textInputAction: TextInputAction.done, // Optionally set the keyboard action to Done
    );
  }

}