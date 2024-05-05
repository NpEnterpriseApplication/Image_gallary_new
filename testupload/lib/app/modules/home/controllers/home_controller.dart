import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:testupload/app/constants/string.dart';
import '../../../data/repo/repo.dart';
import '../../../model/image_response_model.dart';
import '../../../reusable/index.dart';

class HomeController extends GetxController {
  //==============================================================================
  // * Properties *
  //==============================================================================
  var isLoading = false.obs;
  Rx<ImageResponseModel> imgDataResponse = ImageResponseModel().obs;
  Rx<ImageResponseModel> filteredImgData = ImageResponseModel().obs;
  final Debounce debounce = Debounce(const Duration(milliseconds: 700));
  var searchController = TextEditingController();
  late FirebaseMessaging _firebaseMessaging;

  //==============================================================================
  // * GetX Life cycle *
  //==============================================================================

  @override
  void onInit() {
    initializeFirebaseMessaging();
    getImageData().then((value) => filterImages(emptyString));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    debounce.dispose();
    super.onClose();
  }

  //==============================================================================
  // * Helper *
  //==============================================================================

  void initializeFirebaseMessaging() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request notification permissions
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');
      // Listen for incoming messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });
    } catch (e) {
      print('Error initializing Firebase Messaging: $e');
      // Handle error appropriately
    }
  }

  Future<void> getImageData() async {
    try {
      isLoading(true);
      final response = await Repo.getInstance().getImageData();
      imgDataResponse.value = response;
      await storeLocalData(response);
      await getLocalDb();
      isLoading(false);
      // });
    } catch (e) {
      isLoading(false);
    }
  }

  void filterImages(String? query) {
    if (query == null || query.isEmpty) {
      filteredImgData.value = imgDataResponse.value;
    } else {
      filteredImgData.value = ImageResponseModel(
        hits: imgDataResponse.value.hits?.where((image) {
              return (image.tags != null &&
                  image.tags!.toLowerCase().contains(query.toLowerCase()));
            }).toList() ??
            [],
      );
    }
  }

  Future<void> storeLocalData(ImageResponseModel imageData) async {
    try {
      final box = await Hive.openBox<Map>('imageData');
      if (box != null) {
        await box.clear(); // Clear existing data
        await box.put('data', imageData.toJson()); // Store new data
        print('Image data stored successfully: $imageData');
      } else {
        throw 'Error: Failed to open Hive box.';
      }
    } catch (e) {
      throw 'Error storing image data: $e';
    }
  }

  Future<void> getLocalDb() async {
    try {
      final box = await Hive.openBox<Map>('imageData');
      if (box != null) {
        final jsonData = box.get('data');
        if (jsonData != null) {
          final imageData =
              ImageResponseModel.fromJson(jsonData.cast<String, dynamic>());
          print('Retrieved Image Data: $imageData');
          imgDataResponse.value = imageData;
        } else {
          throw 'No data found in Hive box.';
        }
      } else {
        throw 'Error: Failed to open Hive box.';
      }
    } catch (e) {
      throw 'Error retrieving image data: $e';
    }
  }

  Future<void> toggleLike(int imageId) async {
    try {
      final box = await Hive.openBox<Map>('imageData');
      final imageDataMap = box.get('data');

      if (imageDataMap != null) {
        if (imageDataMap.containsKey(imageId.toString())) {
          final Map<String, dynamic> updatedImage =
              imageDataMap[imageId.toString()];

          // Toggle the 'isLiked' status
          final bool currentLikeStatus = updatedImage['isLiked'] ?? false;
          updatedImage['isLiked'] = !currentLikeStatus;

          // Update the image in the map
          imageDataMap[imageId.toString()] = updatedImage;

          // Save the updated map back to Hive
          await box.put('data', imageDataMap);

          print(
              'Toggle like for imageId: $imageId, isLiked: ${updatedImage['isLiked']}');
        } else {
          throw 'Image with ID $imageId not found in Hive box.';
        }
      } else {
        throw 'No data found in Hive box.';
      }
    } catch (e) {
      throw 'Error toggling like: $e';
    }
  }
}
