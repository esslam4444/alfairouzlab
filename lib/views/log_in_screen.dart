// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LoginController extends GetxController {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void login() {
//     String username = usernameController.text.trim();
//     String password = passwordController.text.trim();
//
//     // Example validation
//     if (username == 'admin' && password == 'admin') {
//       // Successful login
//       Get.snackbar('Login Successful', 'welcome');
//       ;
//     } else {
//       // Invalid credentials
//       Get.snackbar('Invalid Credentials', 'Please try again');
//
//     }
//   }//this is a simple validation controller for the prototype
// }
//
//
//
//
// class LoginScreen extends StatelessWidget {
//
//   final LoginController _loginController = Get.put(LoginController());
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Directionality(textDirection: TextDirection.rtl,
//
//       child: Scaffold(
//         body: ListView(
//           children: [
//              Positioned(
//                 top: 0,
//                 left: 0,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_forward),
//                   onPressed: () {
//                     // Handle back button press
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'تسجيل الدخول',
//                     style: TextStyle(
//                       fontSize: 32.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     '',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                     ),
//                   ),
//                   SizedBox(height: 32.0),
//                   TextField(
//                     controller: _loginController.usernameController,
//                     decoration: InputDecoration(
//                       hintText: 'الاسم المستخدم',
//                       prefixIcon: Icon(Icons.person),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   TextField(
//                     controller: _loginController.passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'كلمة المرور',
//                       prefixIcon: Icon(Icons.lock),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   Container(
//                     width: double.infinity,
//                     height: 48.0,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // TODO: Implement login button functionality
//                         _loginController.login();
//                         print('Login Button Pressed');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Text('دخول'),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   GestureDetector(
//                     onTap: () {
//                       // TODO: Implement forgot password functionality
//                       print('Forgot Password');
//                     },
//                     child: Text(
//                       'نسيت كلمة المرور',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),],
//         ),
//       ),
//     );
//   }
// }
//
