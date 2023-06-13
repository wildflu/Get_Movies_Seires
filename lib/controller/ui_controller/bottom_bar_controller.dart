

import 'package:get/get.dart';

class BottomBarController extends GetxController {
  RxInt theIndex = 0.obs;
  void incrementIndex(int newindex) {
    theIndex.value = newindex;
  }

  RxBool catyMovies = true.obs;
  void inmovies() {
    catyMovies.value = true;
  }
  void insires() {
    catyMovies.value = false;
  }
}