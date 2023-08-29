import 'dart:async';
import 'dart:convert' as convert;

import 'package:demo_test/main.dart';
import 'package:demo_test/show_snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// {receiver: 51, sender: 55, screen: chat_page}
FirebaseMessaging messaging = FirebaseMessaging.instance;


String firebaseNotificationAppId = 'AAAAgvv2l-c:APA91bFURNnCYIKsk5miheXXqsWujj_Bzh_1JicDrzr3Wo3kgFlN-l7htSrGTpT5UGgaiudcxu5QA4uZwf1n9o9kChvNET6w7G4VwhQgvvikK3hn5pIJTSlVgTkUpxX2lH90hVBHTQzv';
// String firebaseNotificationAppId = 'AAAAKmYwVpM:APA91bGucpumVhZPkJeWTAMvEIXlkCRLdiVCFFRwqyGU4Tf2zGWWTR_Oxumxk4-8d4cCNMvqh1GBewGQOoHnlR8lcioFMC8SLcyaHPgr2zG_ZJte6nXTamM8lENgeRuU6hWmArDUTD0_';
const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel',  'High Importance Notifications', importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
InitializationSettings initializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  print('${message.data}');
  if(message.data['screen']=='booking'){
  print('firebase notification is called now callled ');
    try{
      // MyGlobalKeys.navigatorKey.currentState!.setState(() {
      //
      // });
      // Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${message.data['other']['booking_id']}');
      // push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
    }catch(e){
      print('error in updating notifications count');
    }
  }
}


class FirebasePushNotifications{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  // );
  ///step 1: Add this to main

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//   onSelectNotification: (payload)async{
//   print('the notification is selected $payload');
//   // {booking_id: 8, user_type: 3, user_id: 9, screen: booking}
//   if(payload!=null){
//   try{
//   Map data = jsonDecode(payload);
//   if(data['screen']=='booking'){
//   Map bookingInformation = await Webservices.getMap(ApiUrls.getBookingById + '${data['booking_id']}');
//   push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: BookingInformationPage(bookingInformation: bookingInformation));
//   }
//   }catch(e){
//   print('Error in catch block 332 $e');
//   }
//
//   }
// }
// await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  // alert: true,
  // badge: true,
  // sound: true,
  //
  // );
  // await FirebasePushNotifications.firebaseSetup();
  /// step 2:
  ///Create certificate Key from here
  /// https://console.firebase.google.com/project/cycle-up-338208/settings/cloudmessaging

  /// step 3 :
  /// get permission
  /// step 4 :
  /// get token and then store it to database, so that we can send notification to that specific
  /// android token.

  static const String webPushCertificateKey = 'BPE6NfMirgOcbGrnJJ-NvlXwMpRnWm_Df0UNwLSxFXshKgAUNF-HjNmbgye_knKsbZxmTEOQz6w10Mm9TVcibO4';
  /// this token is used to send notification // use the returned token to send messages to users from your custom server
  static String? token;



  static Future<NotificationSettings> getPermission()async{
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
    return settings;
  }


  static Future<String?> getToken()async{
    token = await messaging.getToken(
        vapidKey: webPushCertificateKey
    );
    return token;
  }


  static Future<void> firebaseSetup()async {
    // FirebaseMessaging.onBackgroundMessage((message)async{
    //   print)
    // })

    print('Initializing local firebase setup');
    log('log Initializing local firebase setup');
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      print('firebase messaging is being listened');
      try{
        RemoteNotification? notification = message.notification;
        var data = message.data;

        // log('notidata+--'+data.toString());
        AndroidNotification? android = message.notification?.android;
        log('this is notification bb bb ---  ');
        print('___________${notification.toString()}');
        print('________________');
        print(message.data);
        print('________________');
        if (notification != null && android != null) {
          if(message.data['screen']=='post_action'){

            //
            // try{
            //   push(context: MyGlobalKeys.navigatorKey.currentContext!, screen: IndexPage(selectedIndex: 2,));
            // }catch(e){
            //   print('error in updating notifications count');
            // }
          }
          // }else if(message.data['screen']=='tour_request_accepted'){
          //   int count = int.parse(tourRequestCount);
          //   count++;
          //   newAcceptedToursCount = count.toString();
          //
          //   try{
          //     MyGLobalKeys.navigatorKey.currentState!.setState(() {
          //
          //     });
          //   }catch(e){
          //     print('error in updating notifications count');
          //   }
          // }

          // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;
          await flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              // null,
              notification.title,
              notification.body,

              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
              payload:convert.jsonEncode(data)
          );
          print('the payLoad is $data');
        }
      }catch(e){
        print('error in listening notifications $e');
      }
    });


    FirebaseMessaging.onBackgroundMessage((message)async{
      print('Background notification is received ${message.notification?.title}');
      log('log Background notification is received ${message.notification?.title}');
      // showSnackBar(context, text: 'log Background notification is received ');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      print('A new onMessageOpenedApp event was published!');
      print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String title = "";
      log('this is notification aa aa ---  ');

      if(notification!=null){
        title = notification.title.toString();
      }
      if (notification != null && android != null) {
        log('this is notification ---  ');

        try{

          // {booking_id: 6, user_type: 3, user_id: 9, screen: booking}
          if(message.data['screen']=='post_action') {
            ///screen work
          }

          else{
        print('Some other screen');
        print(message.data);
      }
        }catch(e){
          print('Error in Inside catch block $e');
        }

      }
    });

    // FirebaseMessaging.instance.getToken().then((value)async{
    //   if(value!=null){
    //     print('the device token is $value');
    //     if(userDataNotifier.value!=null) {
    //       // print('the user data is ${userData}');
    //       await ManishWebservices.updateDeviceToken(
    //           userId: userDataNotifier.value!.id, token: value);
    //     }else{
    //       print('device token not updated');
    //     }
    //   }
    //   // log("token-------"+value.toString());
    // });

  }


  static Future sendPushNotifications(BuildContext context,
      {required List tokens, required Map data, required String body,required String title,String? user_id,})async{
    var request = {
      "notification":{
        "body":body,
        "title":title,
      },
      "registration_ids":tokens,
      "data":data,
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization":"key=$firebaseNotificationAppId",
    };

    var response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: headers,body: convert.jsonEncode(request));
    print('the response is ${response.statusCode}.... ${response.body}');
    if(response.statusCode==200){
      print('notification sent to ${tokens.length} devices');
      showSnackBar(context,text: 'notification sent to ${tokens.length} devices');
    }

  }




}