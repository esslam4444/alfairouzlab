part of 'app_pages.dart';

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const SPECIMENS = _Paths.SPECIMENS;
  static const SPECIMEN_DETAILS = _Paths.SPECIMEN_DETAILS;
  static const Pdf_View = _Paths.Pdf_View;
  static const Home_Pdf_View = _Paths.Home_Pdf_View;
  static const SPECIMEN_SEARCH = _Paths.SPECIMEN_SEARCH;
  static const SEARCH_HOME_SPECIMEN = _Paths.SEARCH_HOME_SPECIMEN;

  static const QR_SCANNER = _Paths.QR_SCANNER;
}

abstract class _Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SPECIMENS = '/specimens';
  static const SPECIMEN_DETAILS = '/specimen-details';
  static const Pdf_View = '/pdf-view';
  static const Home_Pdf_View = '/home-pdf-view';
  static const SPECIMEN_SEARCH = '/specimen-search';
  static const SEARCH_HOME_SPECIMEN = '/search-home-specimen';
  static const QR_SCANNER = '/qr-scanner';
}
