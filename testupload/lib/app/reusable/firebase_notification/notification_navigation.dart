import 'package:get/get.dart';

import '../../model/notification_model.dart';


class NotificationNavigation {
  static final NotificationNavigation instance =
      NotificationNavigation._internal();

  factory NotificationNavigation() {
    return instance;
  }

  NotificationNavigation._internal();

  Future onSelectNotification(NotificationData payload) async {
    if (payload != null) {
      getPageOnNotificationTap(payload);
    }
  }

  onPage(String page, {dynamic arguments}) {
    Get.toNamed(page, arguments: arguments);
  }

  getPageOnNotificationTap(NotificationData payload) async {
    // var homeController = Get.find<HomeTabController>();
    // if (payload.senderId != null) {
    //   await PreferenceHelper.instance
    //       .setData(Pref.businessId, payload.senderId);
    //   homeController.businessTitle.value = payload.tital ?? "";
    //   // await PreferenceHelper.instance
    //   //     .setData(Pref., payload.senderId);
    //   onPage(
    //     Routes.DETAIL_PAGE, /*arguments: payload.senderId)*/
    //   );
    // } else {
    //   Get.toNamed(Routes.NOTIFICATION);
    // }

    // switch (payload.senderId) {
    //   case "1":
    //     // Get.toNamed(Routes.NOTIFICATION);
    //     onPage(
    //       Routes.DETAIL_PAGE, /*arguments: payload.senderId)*/
    //     );
    //     break;
    //   default:
    //     Get.toNamed(Routes.NOTIFICATION);
    // }
  }
}
