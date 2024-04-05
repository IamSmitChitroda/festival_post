import 'package:festival_post/headers.dart';

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  String splashScreen = "/";
  String homePage = "home_page";
  String detailPage = "detail_page";

  Map<String, WidgetBuilder> appRoute = {
    "/": (context) => const SplashScreen(),
    "home_page": (context) => const HomePage(),
    "detail_page": (context) => const DetailPage(),
  };
}
