import 'package:alfairouzlab/models/account.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/login.dart';
import '../utils/consts.dart';

class AuthRepository {
  final _dio = Get.find<Dio>();

  Future<bool> authorize(LoginVM login) async {
    try {
      final response = await _dio.post('authenticate', data: login.toJson());
      if (response.data.containsKey('id_token')) {
        await Get.find<GetStorage>().write("id_token", response.data['id_token']);
      }
      return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 401 || e.response!.statusCode == 400) {
        Get.snackbar('خطأ في التسجيل الدخول', 'البريد الإلكتروني/رمز السري خاطئ',
            titleText: null, backgroundColor: Const.redColor.withOpacity(0.4), colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
      return false;
    }
  }


  Future<int?> isAuthenticated() async {
    try {
      final response = await _dio.get('authenticate',);
      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }





  Future<Account> account() async {

    try {

      final response = await _dio.get('account');

      final firstName = response.data['firstName'] as String?;

      // Store firstName in local storage if it's not null
      if (firstName != null) {
        Get.find<GetStorage>().write('firstName', firstName);
      }
      //=====================
      final authorities = List<String>.from(response.data['authorities']);
      // Access the first string inside the 'authorities' list
      final firstAuthority = authorities.isNotEmpty ? authorities : null;

      // Store the first string in local storage

      Get.find<GetStorage>().write('firstAuthority', firstAuthority);

      // Check if the data is stored in local storage
     // checkLocalStorage();

      return Account.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // void checkLocalStorage() {
  //   final box = GetStorage();
  //   final storedAuthority = box.read('firstAuthority');
  //
  //   if (storedAuthority != null) {
  //     print('Stored Authority: $storedAuthority');
  //     // Perform any additional actions with the stored value
  //   } else {
  //     print('No authority stored in local storage.');
  //   }
  // }
}
