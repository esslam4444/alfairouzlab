import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/specimen_model.dart';
import '../repositories/specimen_repository.dart';
import 'SpecimenSearchController.dart';

class SpecimenDetailsController extends GetxController {
  var storage = GetStorage();
  final specimenRepository = Get.find<SpecimenRepository>();

  final loading = false.obs;

  final Rx<Specimen> _specimen = Specimen().obs;

  Specimen get specimen => _specimen.value;

  final  specimenId =0.obs;

  bool storedAuthorityCheck = false;

  @override
  void onInit() {
    super.onInit();



  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  findBySpecimenId() async {
    try {
      loading.value = true;

      // Check the value of "firstAuthority" from local storage
      final storage = GetStorage();
      final List<String> firstAuthority = storage.read('firstAuthority') ?? [];

      storedAuthorityCheck = firstAuthority.contains("ROLE_ADMIN") || firstAuthority.contains("ROLE_REFERRING_CENTER");



      _specimen.value = await specimenRepository.findBySpecimenId(specimenId);

      update();
    } finally {
      loading.value = false;
    }
  }


}



class SpecimenDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecimenDetailsController>(
      () => SpecimenDetailsController(),
    );
  }
}
