import 'package:alfairouzlab/views/QRScannerView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/SpecimenSearchController.dart';
import '../routes/app_pages.dart';
import 'LoginView.dart';
import 'PdfView.dart';



class SpecimenSearchView extends GetView<SpecimenSearchController> {
  final QRScannerView qrScannerView = Get.put(const QRScannerView());


  SpecimenSearchView({Key? key}) : super(key: key);

  final List<String> statusOrder = [
    'RECEIVED',
    'GROSSING',
    'PROCESSING',
    'DIAGNOSING',
    'TYPING',
    'REVISION',
    'READY',
  ];

  @override
  Widget build(BuildContext context) {
    final context = Get.context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("مختبر الفيروز",style: TextStyle(color: Colors.white),),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'), // Replace 'assets/logo.png' with your logo image path
            radius: 20, // Adjust the radius as needed for the circular shape
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person,color: Colors.white,),
            onPressed: () => Get.to(const LoginView()),
          ),
        ],
      ),
      body: GetBuilder<SpecimenSearchController>(
        init: SpecimenSearchController(),
        initState: (_) {},
        builder: (searchController) {

          bool isCompleted(String status) {
            final currentStatusIndex = statusOrder.indexOf(searchController.specimen.specimenStatus??"");
            final statusIndex = statusOrder.indexOf(status);
            return statusIndex <= currentStatusIndex;
          }

          return Obx(()=>
              GestureDetector(
                onTap: () {
                  // Unfocus the text field when tapped outside svx zz
                  FocusScope.of(context!).unfocus();
                },
               child: ListView(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'الاستعلام عن العينة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        border:  OutlineInputBorder(), // Set border to OutlineInputBorder
                        hintText: "ادخل كود العينة",
                        suffixIcon: IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.QR_SCANNER);
                          },
                          icon: const Icon(Icons.qr_code_outlined),
                        ),
                      ),
                      controller: searchController.labQr,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor:MaterialStateColor.resolveWith((states) => Colors.green),),
                      onPressed: () async {
                        // Hide the keyboard
                        FocusScope.of(context!).unfocus();

                        // Perform the search
                        await searchController.findSpecimenByLabQr();

                        // Check if the request was bad
                        if (searchController.isRequestBad) {
                          showDialog(
                            context: context!,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('خطأ'),
                                content: Text('رقم التسجيل غير صحيح'),
                                actions: [
                                  TextButton(
                                    child: Text('موافق'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('بحث',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                SizedBox(height:10),

                  searchController.loading.value
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox(),
                  searchController.specimen.id != null
                      ? Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(enabled: false,

                      title: Row(
                        children: [
                          Text(
                            searchController.specimen.patient?.nameAr ?? "",
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                                const Spacer(),
                          searchController.specimen.specimenStatus == 'READY'?
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // downloadPdf();


                                      searchController.specimen.specimenStatus == 'READY'?
                                          Get.to(PdfView())
                                          :Null;


                                    },
                                    child: const Text('التقرير'),
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.lightGreen, backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          side: BorderSide(
                                            color: Colors.lightGreen,
                                            width: 1.0,
                                          ),
                                        ),
                                    ),
                                  ),
                                )
                            : const SizedBox(child: Text('')),
                        ],
                      ),
                    ),
                  )
                      : const SizedBox(child: Text('')),
//dd
                  searchController.specimen.id != null
                 ? SizedBox(height: Get.height/2,
                    child:
           Stepper(
            type: StepperType.vertical,
            // currentStep: currentStep,


             controlsBuilder: (context, details) {
               return Container();
             },
             steps: statusOrder.map((status) {
               final index = statusOrder.indexOf(status);

               return Step(
                 state: isCompleted(status, )  ? StepState.complete :StepState.indexed,
                 isActive:true &&
                  isCompleted(status, ),
                 title:  Text(
                   status,
                   style: const TextStyle(fontSize: 16),
                 ),
                 content: const SizedBox(),
               );
             }).toList(),
           ),)
                  :  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SizedBox(child: Column( children: [
                      Icon(Icons.qr_code_scanner_rounded,color: Colors.black12,size: 100,),
                      Text('امسح كود العينة',style: TextStyle(color: Colors.black38,fontSize: 20),)],),),
                  ),
                ],
            ),
             ),
          );
        },
      ),
    );
  }
}



