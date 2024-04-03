import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/HomeController.dart';
import '../controllers/HomePdfViewController.dart';
import '../controllers/LoginController.dart';
import '../controllers/SpecimenDetailsController.dart';
import '../controllers/SpecimensController.dart';
import '../routes/app_pages.dart';
import 'HomePdfView.dart';
import 'SpecimenDetailsView.dart';

class HomeView extends GetView<HomeController> {

  final HomePdfViewController homePdfViewController =
  Get.put(HomePdfViewController());

  // final LoginController loginController =
  // Get.put(LoginController());

  final SpecimensController specimensController =
  Get.put(SpecimensController());

  final SpecimenDetailsController specimenDetailsController =
  Get.put(SpecimenDetailsController());
final ScrollController scrollController = ScrollController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
   // listen to scroll event
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){specimensController.findAllSpecimens();}},);
    //final accountTry = loginController.account.firstName;
    return GetBuilder<SpecimensController>(
      init: SpecimensController(),
      initState: (_) {},
      builder: (_) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar:  AppBar(backgroundColor: Colors.green,
              iconTheme: const IconThemeData(
              color: Colors.white, // Set the color of the drawer icon to white
            ),
              title: const Center(
                child: Text(
                  'العينات',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                ),
              ),
              actions: [
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Navigate to the search route

                    Get.toNamed(Routes.SEARCH_HOME_SPECIMEN);
                  },
                ),

              ],
            ),
            drawer: Obx(() => Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _.firstName.value.toString() ?? '',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading:  Icon(Icons.logout),
                    title:  Text('تسجيل خروج'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text('هل تريد الخروج '),
                            actions: <Widget>[
                              TextButton(
                                child:  Text('الغاء'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog

                                },
                              ),
                              TextButton(
                                child:  Text(
                                  'خروج',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  // SystemNavigator.pop(); // Exit the application
                                  Get.toNamed(Routes.SPECIMEN_SEARCH);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),),
            body:  Padding(
        padding: const EdgeInsets.all(16.0),

      child:      Obx(
                  () {
                if (_.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: _.specimens.length + (_.hasReachedEnd.value ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index >= _.specimens.length) {
                        // Show the circular progress indicator at the bottom
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        final specimen = _.specimens[index];
                        return GestureDetector(
                          onTap: () {
                            final controller = Get.find<SpecimenDetailsController>();
                            controller.specimenId.value = specimen?.id ?? 0;
                            controller.findBySpecimenId();
                            Get.to(SpecimenDetailsView());
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                tileColor: Colors.white,
                                leading: Text((index + 1).toString()),
                                title: Text(
                                  specimen?.patient?.nameAr ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(specimen?.specimenStatus.toString() ?? ''),
                                trailing: specimen?.specimenStatus == 'READY'
                                    ? ElevatedButton(
                                  onPressed: () {
                                    final controller = Get.find<HomePdfViewController>();
                                    controller.specimenId.value = specimen?.id ?? 0;
                                    controller.downloadFile();
                                    Get.to(HomePdfView());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.lightGreen,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'التقرير',
                                    style: TextStyle(color: Colors.lightGreen),
                                  ),
                                )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            )

       ),
          ) );
      },
    );
  }
}