
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  Rx<int> currentIndex = Rx<int>(0);

  void changePage(int index) =>
    currentIndex.value = index;
 
}
