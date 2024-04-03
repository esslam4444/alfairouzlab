

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import '../models/account.dart';
import '../models/specimen_model.dart';

import '../repositories/specimen_repository.dart';
import 'PdfViewController.dart';

class SpecimensController extends GetxController {
 //  final Rx<Specimen> _specimen = Get.put(Specimen()).obs;
  final specimenRepository = Get.find<SpecimenRepository>();

  final loading = false.obs;
  final specimens = <Specimen>[].obs;
  var page = 0.obs;
  var hasReachedEnd = false.obs;

  final patient = <Patient>[].obs;

   PdfViewController? pdfViewController;

  var firstName = ''.obs;



  @override
  void onInit() {

    // Attempt to retrieve firstName from GetStorage
    final storage = Get.find<GetStorage>();
    firstName.value = storage.read('firstName') ?? '';

    findAllSpecimens();
    super.onInit();
  }

  Future<void> findAllSpecimens() async {
    if (loading.value || hasReachedEnd.value) {
      // Return early if loading is already in progress or reached the end
      return;
    }

    try {
     // loading.value = true;
   //   firstName = Get.find<GetStorage>().read("firstName");
          if(specimens.isEmpty){
            loading.value = true;
          }
      final response = await specimenRepository.findAllSpecimen(page);

      if (response.isNotEmpty) {
        specimens.addAll(response);
        page.value++;
      } else {
        hasReachedEnd.value = true;
      }

      update();
    } finally {
      loading.value = false;
    }
  }

  //=========================================

  // void search(RxString query) async {
  //   if (query.isEmpty) {
  //     results.clear();
  //     return;
  //   }
  //
  //   loading.value = true;
  //   isError.value = false;
  //
  //   try {
  //     if(results.isEmpty){
  //       loading.value = true;
  //     }
  //     final response = await specimenRepository.searchPatientSpecimen(query as RxString);
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

}

class SpecimensBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecimensController>(
      () => SpecimensController(),
    );
  }
}
