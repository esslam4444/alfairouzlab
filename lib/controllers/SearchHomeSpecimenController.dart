

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../models/specimen_model.dart';
import '../repositories/specimen_repository.dart';
import 'PdfViewController.dart';

class SearchHomeSpecimenController extends GetxController {


  final specimenRepository = Get.find<SpecimenRepository>();
  final loading = false.obs;
  final isRequestBad = false.obs;
  var query = TextEditingController();

  final RxList<Specimen> _specimens = <Specimen>[].obs;

  List<Specimen> get specimens => _specimens;

  final RxList<Patient> _patient = <Patient>[].obs;

  List<Patient> get patient => _patient;

  //final patient = <Patient>[].obs;

  // final Rx<Specimen> _specimen = Specimen().obs;
  //
  // Specimen get specimen => _specimen.value;
  //
  // final Rx<Patient> _patient = Patient().obs;
  //
  // Patient get patient => _patient.value;


  PdfViewController? pdfViewController;

  var page = 0.obs;
  var hasReachedEnd = false.obs;

  // Define the getter for isRequestBad



 
  


  @override
  void onInit() {
  //  search();
    super.onInit();
  }

  @override
  void onClose() {
    query.dispose();

    super.onClose();
  }

//=========================================

  Future<void> search() async {
    try {
      loading.value = true;
      // Reset the isRequestBad state to false before making a new request
      isRequestBad.value = false;

      final response = await specimenRepository.searchPatientSpecimen(query.text);


      if (response.isNotEmpty) {
        _specimens.assignAll(response);
      } else {
        // Handle the case when response is empty
      }

      update();
    } catch (e) {
      // Handle the error
      isRequestBad.value = true;

    } finally {
      loading.value = false;
    }
  }
}


//
// Future <void> search( ) async {
//
//
//   loading.value = true;
//   isError.value = false;
//
//   try {
//     if(_results.isEmpty){
//       loading.value = true;
//     }
//     final response = await specimenRepository.searchPatientSpecimen(query.text );
//
//
//     // Assuming the API response is a list of objects with 'name' and 'description' fields
//     response.isNotEmpty?
//     results.addAll(response):null;
//   } catch (e) {
//     isError.value = true;
//   } finally {
//     loading.value = false;
//   }
// }



class SearchHomeSpecimenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchHomeSpecimenController>(
          () => SearchHomeSpecimenController(),
    );
  }
}
