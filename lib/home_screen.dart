// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
//
// void main() async{
//   runApp(const MyApp());
//
//   await Firebase.initializeApp(
//     options: FirebaseOptions(
//         apiKey: "AIzaSyD0oWpmKczpKrHlwJUDcCnp1Ut8wIziTVo",
//         authDomain: "testweb-66f9a.firebaseapp.com",
//         projectId: "testweb-66f9a",
//         storageBucket: "testweb-66f9a.appspot.com",
//         messagingSenderId: "593934203257",
//         appId: "1:593934203257:web:eb1b85f0ed0485a284d7a8",
//         measurementId: "G-R7EED08BC0"
//     ),
//   );
//   print('firebase init success.');
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:demo_test/show_snackbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dynamic_dialog.dart';
import 'notifications_page.dart';


class PushNotificationApp extends StatefulWidget {
  static const routeName = "/firebase-push";

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    getPermission();
    messageListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyD0oWpmKczpKrHlwJUDcCnp1Ut8wIziTVo",
          authDomain: "testweb-66f9a.firebaseapp.com",
          projectId: "testweb-66f9a",
          storageBucket: "testweb-66f9a.appspot.com",
          messagingSenderId: "593934203257",
          appId: "1:593934203257:web:eb1b85f0ed0485a284d7a8",
          measurementId: "G-R7EED08BC0",

        ),
      ),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('android firebase initiated');
          return NotificationPage();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

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
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      print('Got a message whilst in the foreground!');
      showSnackBar( context,text: 'Message data: ${message.data}');
      log('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.body}');
        showDialog(
            context: context,
            builder: ((BuildContext context) {
              return DynamicDialog(
                  title: message.notification?.title,
                  body: message.notification?.body);
            }));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
      print('A new onMessageOpenedApp event was published!');
      showSnackBar(context, text: 'A new onMessageOpenedApp event was published!');
      log('log A new onMessageOpenedApp event was published!');
      print(message.data);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      String title = "";
      log('log this is notification aa aa ---  ');
      print('this is notification aa aa ---  ');

      if(notification!=null){
        title = notification.title.toString();
      }
      if (notification != null && android != null) {
        log('this is notification ---  ');

        try{
          // BuildContext context = MyGlobalKeys.navigatorKey.currentContext!;
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
  }
}