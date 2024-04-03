import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/specimen_model.dart';
import '../repositories/specimen_repository.dart';
import 'SpecimensController.dart';

import 'SpecimenSearchController.dart';
import 'package:path_provider/path_provider.dart';

import 'SpecimenSearchController.dart';

class HomePdfViewController extends GetxController {
  //SpecimensController? specimensController;

 // final SpecimensController specimensController = Get.put(SpecimensController());
  final downloadState = Rx<DownloadState>(NoDataState());
  final dio = Dio();
 // final RxInt? specimenId = RxInt(0); // Use RxInt instead of int
 // (( RxInt )) This will allow the value to be reactive and automatically update when changed.
 final  specimenId =0.obs;

  @override
  void onInit() {
    super.onInit();

    // specimensController =
    //     Get.find<SpecimensController>();


    downloadFile();

  }

  Future<void> downloadFile() async {
    final dir = await getApplicationDocumentsDirectory();

    // final specimenId =
    //     //specimenId2;
    //     specimensController?.specimens[0].id;

    if (specimenId != null) {
      print('from controller this is the ID ID ${specimenId}');
      final savePath = '${dir.path}/sample.pdf';
      final pdfUrl = 'https://app.alfairouz.ly/api/public/specimen/report-colored/$specimenId';

      downloadState.value = DownloadingState(progressString: '0%');

      try {
        await dio.download(
          pdfUrl,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              final progress = ((received / total) * 100).toStringAsFixed(0) + '%';
              downloadState.value = DownloadingState(progressString: progress);
            }
          },
        );

        downloadState.value = CompletedState(localFilePath: savePath);
        print("Download completed");
      } catch (e) {
        print(e);
        downloadState.value = ErrorState();
      }
    }
  }
}

abstract class DownloadState {}

class NoDataState extends DownloadState {}

class DownloadingState extends DownloadState {
  final String progressString;

  DownloadingState({required this.progressString});
}

class CompletedState extends DownloadState {
  final String localFilePath;

  CompletedState({required this.localFilePath});
}

class ErrorState extends DownloadState {}



class HomePdfViewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePdfViewController>(
          () => HomePdfViewController(),
    );
  }
}

