import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../firebase_options.dart';
import '../../model/notification_model.dart';
import '../index.dart';
import 'local_notification_service.dart';
import 'notification_navigation.dart';

class FirebaseNotification {
  static final FirebaseNotification instance = FirebaseNotification._internal();

  factory FirebaseNotification() {
    return instance;
  }

  FirebaseNotification._internal();

//==============================================================================
// ** Initialize Firebase App Function **
//==============================================================================

  NotificationData notificationData = NotificationData();

  void getAndroidPermissions() {
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  initializeApp() async {
    if (Platform.isIOS) {
      // please add this ids accordint to the option file
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBm2nz07NAa8N-75Lz7ExoDa80JY7jDrU8',
          appId:'1:545894903810:android:b88bd9eb3cafd2a3b6b71b',
          messagingSenderId: '545894903810',
          projectId: 'orbaic-6832f',
          storageBucket: 'orbaic-6832f.appspot.com',
          iosBundleId: 'orbaic-6832f.appspot.com',
        ),
      );
      getIosPermissions();
    } else {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      getAndroidPermissions();
    }

    getNotification();
  }

//==============================================================================
// ** Notification State Handler Function **
//==============================================================================

  getNotification() async {
    await FirebaseMessaging.instance.getAPNSToken();
    FirebaseMessaging.instance.getToken().then((fcmToken) async {
      appPrint(" FCM TOKEN: \n $fcmToken");



      // await FirebaseMessaging.instance
      //     .subscribeToTopic("grabDeals")
      //     .then((value) => print("Topic subscribed"));
    }).catchError((onError) {
      // appPrint("FCM TOKEN: ERROR $onError");
    });

/*  (1). This method call when app in terminated state and you get a notification
         when you click on notification app open from terminated state
         and you can get notification data in this method.*/
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );

/*  (2). This method only call when App in foreground it mean app must be opened.*/
    FirebaseMessaging.onMessage.listen(
      (message) {
        String body, title;
        if (message.notification != null) {
          title = message.notification!.title.toString();
          body = message.notification!.body.toString();
          notificationData = NotificationData(
            type: message.data['type'],
            id: message.data['id'],
            senderId: message.data['sender_business_id'],
          );

          LocalNotificationService.instance.createAndDisplayNotification(
            title,
            body,
            notificationData,
          );
          // _handleNavigation(notificationData);
        }
      },
    );

/* (3). This method only call when App in background and not terminated(not closed).*/
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          notificationData = NotificationData(
            tital: message.notification?.title,
            type: message.data['type'],
            id: message.data['id'],
            senderId: message.data['sender_business_id'],
          );
          String? type = message.data['sender_business_id'];
          NotificationNavigation.instance
              .onSelectNotification(notificationData);
        }
      },
    );
  }

  Future<void> getIosPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
      announcement: true,
      badge: false,
      provisional: true,
      carPlay: false,
      criticalAlert: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await handleNotificationPermission(true);
    } else {
      await handleNotificationPermission(false);
      getIosPermissions();
    }
  }

  Future<void> handleNotificationPermission(bool granted) async {
    if (granted) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      String? fCMToken = await FirebaseMessaging.instance.getToken();
      // await FirebaseMessaging.instance
      //     .subscribeToTopic("load_shedding")
      //     .then((value) => print("ios Topic subscribed"));
      print("IOS FCM TOKEN : -\n$apnsToken\n$fCMToken");
    }
  }

  // Future<void> _handleNavigation(NotificationData payload) async {
  //   if (payload.senderId != null) {
  //     await PreferenceHelper.instance
  //         .setData(Pref.businessId, payload.senderId);
  //
  //     // Check if the app is in the foreground before navigating
  //     if (!kIsWeb && Get.context != null) {
  //       onPage(Routes.DETAIL_PAGE);
  //     }
  //   } else {
  //     Get.toNamed(Routes.NOTIFICATION);
  //   }
  // }
}

onPage(String page, {dynamic arguments}) {
  Get.toNamed(page, arguments: arguments);
}
