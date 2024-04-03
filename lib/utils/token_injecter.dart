import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_pages.dart';
import 'consts.dart';

class TokenInjecter extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (Get.find<GetStorage>().hasData('token')) {
      options.headers["Authorization"] = "Bearer " + Get.find<GetStorage>().read('token');
    }
    check().then((intenet) {
      if (intenet != null && intenet) {
        if (Get.find<GetStorage>().hasData('token')) {
          options.headers["Authorization"] = "Bearer " + Get.find<GetStorage>().read('token');
        }
      } else {
        Get.snackbar(
          'خطأ في الإنترنت ',
          'قم بتوصيل بالانترنت ثم حاول مره اخرى',
          duration: Duration(seconds: 5),
          backgroundColor: Const.primaryColor.withOpacity(0.4),
          colorText: Colors.white,
        );
      }
    });

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is Map<String, dynamic>) {
      Map<String, dynamic> data = response.data;
      if (data.containsKey('id_token')) {
        await Get.find<GetStorage>().write("token", data['id_token']);
        Get.offAllNamed(Routes.HOME);
      }
    }
    super.onResponse(response, handler);
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}