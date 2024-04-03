import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/specimen_model.dart';
import '../repositories/specimen_repository.dart';
import 'PdfViewController.dart';

class SpecimenSearchController extends GetxController {
  final specimenRepository = Get.find<SpecimenRepository>();

  final loading = false.obs;
  var labQr = TextEditingController();

  final Rx<Specimen> _specimen = Specimen().obs;

  Specimen get specimen => _specimen.value;

  final Rx<Patient> _patient = Patient().obs;

  Patient get patient => _patient.value;

  PdfViewController? pdfViewController;

  // Define the getter for isRequestBad
  bool get isRequestBad => _isRequestBad.value;

  final _isRequestBad = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    labQr.dispose();

    super.onClose();
  }

  Future<void> findSpecimenByLabQr() async {
    try {
      loading.value = true;
      // Reset the isRequestBad state to false before making a new request
      _isRequestBad.value = false;
      final _firebaseMessaging = FirebaseMessaging.instance;
     final FCMToken = await _firebaseMessaging.getToken();
      _specimen.value = await specimenRepository.findBySpecimenLabQr(labQr.text,
          FCMToken!
      );

    } catch (e) {
      // Handle the error
      _isRequestBad.value = true;
    } finally {
      loading.value = false;
    }
  }
}

class SpecimenSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecimenSearchController>(() => SpecimenSearchController());
  }
}