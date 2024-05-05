import 'dart:async';

import 'package:flutter/foundation.dart';
//==============================================================================
// ** Search Debounce **
//==============================================================================
class Debounce {
  Duration delay;
  Timer? timer;

  Debounce(
      this.delay,
      );

  call(void Function() callback) {
    timer?.cancel();
    timer = Timer(delay, callback);
  }

  dispose() {
    timer?.cancel();
  }
}

appPrint(str){
  if (kDebugMode) {
    print(str);
  }
}