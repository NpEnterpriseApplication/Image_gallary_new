// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.type,
    this.tital,
    this.id,
    this.businessId,
    this.senderId,
  });

  String? type;
  String? tital;
  String? id;
  int? businessId;
  String? senderId;


  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        type: json["type"],
        tital: json["tital"],
        id: json["id"],
        businessId: json["businessId"],
        senderId: json["senderId"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "tital": tital,
        "id": id,
        "senderId": senderId,
      };
}
//
// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

// To parse this JSON data, do
//
//     final notificationResponce = notificationResponceFromJson(jsonString);
