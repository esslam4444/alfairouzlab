import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/LoginController.dart';
import '../controllers/SpecimensController.dart';
import '../utils/consts.dart';

class LoginView extends GetView<LoginController> {
  //final SpecimensController specimensController = Get.put(SpecimensController());

   const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar:AppBar(
            title: const Text(
              'تسجيل الدخول',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false, // Set this to false to hide the back arrow
            actions: [
              IconButton(color: Colors.white,
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
      
            body: GetBuilder<LoginController>(
            init: LoginController(),
            initState: (_) {},
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Form(
                  key: _.loginFormKey,
                  child: ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: SizedBox(
                                  height: Get.height * .065,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      color: Const.primaryColor,
                                    ),
                                    cursorColor: Const.primaryColor,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      hintText: ' البريد الالكتروني',
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'يجب عليك إدخال البريد الالكتروني'.tr;
                                      }
                                      return null;
                                    },
                                    controller: _.loginEmail,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: SizedBox(
                                  height: Get.height * .065,
                                  child: TextFormField(
                                    obscureText: true,
                                    style: const TextStyle(color: Const.primaryColor),
                                    cursorColor: Const.primaryColor,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      hintText: 'كلمة المرور',
                                      prefixIcon: const Icon(Icons.lock),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'يجب عليك إدخال كلمة المرور'.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _.loginPassword,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Container(
                                width: double.infinity,
                                height: 48.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _.login();
      
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: const Text('دخول',style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              // GestureDetector(
                              //   onTap: () {
                              //
                              //   },
                              //   child: const Text(
                              //     'نسيت كلمة المرور',
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Colors.blue,
                              //       decoration: TextDecoration.underline,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
