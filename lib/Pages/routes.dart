import 'package:get/get.dart';
import '../Pages/Homepage.dart';
import '../Pages/Login.dart';
import '../Pages/ProfilePage.dart';
import '../Pages/EventsPage.dart';
import '../Pages/ReachEventPage.dart';
import '../Pages/UserAccountPage.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () =>Homepage()),
    GetPage(name: '/home', page: () =>Homepage()),
    GetPage(name: '/Login', page: () =>Login()),
    GetPage(name: '/ProfilePage', page: () =>ProfilePage()),
    GetPage(name: '/EventsPage', page: () =>EventsPage()),
    GetPage(name: '/UserAccount', page: () =>UserAccountPage()),
  ];
}