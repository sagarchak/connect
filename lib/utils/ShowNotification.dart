import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:connect/database/DBHelper.dart';
import 'package:connect/database/entity/user_entity.dart';
import 'package:connect/main.dart';
import 'package:connect/utils/SharedPrefer.dart';
import 'package:connect/utils/app_constants.dart';
import 'package:connect/utils/common_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app_constants.dart';

class ShowNotification {

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  bool isApplicationLaunchedViaNotification = false;

  ShowNotification._privateConstructor();

  static final ShowNotification instance = ShowNotification._privateConstructor();

  initNotifications() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (!isApplicationLaunchedViaNotification) {
      if (notificationAppLaunchDetails != null && notificationAppLaunchDetails.notificationResponse != null) {
        //processInitialRoute(notificationAppLaunchDetails.notificationResponse!.payload);
      }
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_notification');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
        });


    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse? details) {
      if (details != null && details.payload != null) {
        debugPrint('notification payload: ${details.payload}');
      }
      //processRedirection(details!.payload);
    });
  }

  getLastFirebaseMessage(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        //redirectPage(message);
      }
    });
  }

  initFirebaseMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showMessage(message, true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //redirectPage(message);
    });
  }

  showMessage(RemoteMessage message, bool isForeground) async {
    debugPrint('Data ${(message.data != null) ? message.data.toString() : 'No Data'}');

    UserEntity? mUser = await DBHelper.mInstance.getMainUser();
    if (mUser != null && CommonUtils.checkIfNotNull(mUser.mobile)) {
      RemoteNotification? notification = message.notification;

      var androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'ic_stat_notification',
      );

      var iOSDetails = const DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);
      isApplicationLaunchedViaNotification = false;
      String title = 'Pariwar Notification';
      String body = 'There is an update from admin in your company data.';
      if(notification != null) {
        if (notification != null && CommonUtils.checkIfNotNull(notification.title)) {
          title = notification.title!;
        }
        if (notification != null && CommonUtils.checkIfNotNull(notification.body)) {
          body = notification.body!;
        }
      }

      if (CommonUtils.checkIfNotNull(message.data.toString())) {
        /*{
          "title":"sasas",
          "text":"cccc",
          "page_type":"roaster",
          "visible":false,
          "thumbnail":"",
          "param":{
          "id":1,
          "name":"joydeep"
                 }
           }*/

        Map<String, dynamic> resMap = message.data;

        if(resMap != null) {
          if(CommonUtils.checkIfNotNull(resMap['title'])){
            title =  resMap['title'];
          }
          if(CommonUtils.checkIfNotNull(resMap['text'])){
            body =  resMap['text'];
          }
        }
      } else if (notification != null && Platform.isIOS) {
        await flutterLocalNotificationsPlugin.show(
          GENERAL_NOTIFICATION_ID,
          title,
          body,
          NotificationDetails(android: androidDetails, iOS: iOSDetails),
        );
      }
      if (kDebugMode) {
        debugPrint('Notification title:  $title');
        debugPrint('Notification body:  $body');
      }
    }
  }

  showNotification(String pageType, String title, String body, Map<String, dynamic> resMap, bool isForeground) async {
    if ((resMap['visible'] == "true") && !Platform.isIOS && isForeground && CommonUtils.checkIfNotNull(title) && CommonUtils.checkIfNotNull(body)) {
      var iOSDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true, subtitle: body);

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(channel.id, channel.name, icon: 'ic_stat_notification', importance: Importance.max, priority: Priority.high, ticker: 'ticker');

      NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSDetails);

      await flutterLocalNotificationsPlugin.show(GENERAL_NOTIFICATION_ID, title, body, platformChannelSpecifics, payload: pageType);
    }
  }

 

  showString(String title, String body) async {
    if (CommonUtils.checkIfNotNull(title)) {
      var androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: 'ic_stat_notification',
      );

      var iOSDetails = const DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

      await flutterLocalNotificationsPlugin.show(101, title, body, NotificationDetails(android: androidDetails, iOS: iOSDetails));
    }
  }


  unsubscribeFromTopics() async {
    SharedPrefer.saveBoolean(SharedPrefer.SUBSCRIBED, false);
    await FirebaseMessaging.instance.subscribeToTopic(DEFAULT_TOPIC_NAME);
  }

  subscribeToTopics() async {
    SharedPrefer.saveBoolean(SharedPrefer.SUBSCRIBED, true);
    await unsubscribeFromTopics();
    await FirebaseMessaging.instance.subscribeToTopic(DEFAULT_TOPIC_NAME);
  }
}
