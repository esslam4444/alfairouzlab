// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// import 'LoginView.dart';
// import 'log_in_screen.dart';
//
// class SpecimenScreen extends StatelessWidget {
//
//   final TextEditingController specimenQrController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(backgroundColor:Colors.green, title: const Text('مختبر الفيروز'),actions: [  IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {
//                 // log In
//                 Get.to(LoginView());
//               },
//             ),],),
//         body: Obx(() {
//           return
//             Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'استعلام عن العينة',
//                   style: TextStyle(
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 32.0),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           hintText: 'ادخل كود العينة',
//                           prefixIcon: Icon(Icons.search),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8.0),
//                       Text(
//                         'ادخل كود العينة ثم اضغط بحث',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 32.0),
//                 Container(
//                   width: 200.0,
//                   height: 48.0,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // TODO: Implement search button functionality
//                       // specimenController.findByspecimenQr(TextEditingController());
//                       print('Search Button Pressed');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     icon: Icon(Icons.search),
//                     label: Text('بحث'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//           } ,
//         ),
//       ),
//     );
//   }
// }