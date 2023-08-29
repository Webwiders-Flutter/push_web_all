
import 'dart:convert';

import 'package:demo_test/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}




class _Application extends State<NotificationPage> {
  String? _token;
  Stream<String>? _tokenStream;
  int notificationCount = 0;

  void setToken(String token) {
    print('FCM TokenToken: $token');
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('setting token to $token manish')));
    showSnackBar(context, text: 'setting token to $token manish');
    // FirebaseFirestore.instance.collection('tokens').add({
    //   'token': _token,
    // });
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();

    //get token
    FirebaseMessaging.instance
        .getToken(
        vapidKey:
        'BM24UIn7_ipy-QH-_-krNOU81fnsyP5101c9NDgfPeiClF2ebtcqgwXiGY6LJy2xtBRwmgr8cpxqnmzMDjvH_oo')
        .then((String? token) => {setToken(token!)});

    FirebaseMessaging.instance.isSupported().then((value){
      showSnackBar(context, text: 'the firebase support is $value');
    });

    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen((e){

      showSnackBar(context, text: 'token stream is listened then settled');
      setToken(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase push notification'),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(10),
                elevation: 10,
                child: ListTile(
                  title: Center(
                    child: OutlinedButton.icon(
                      label: Text('Push Notification',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      onPressed: () {
                        if(_token==null){
                          FirebaseMessaging.instance
                              .getToken(
                              vapidKey:
                              'BM24UIn7_ipy-QH-_-krNOU81fnsyP5101c9NDgfPeiClF2ebtcqgwXiGY6LJy2xtBRwmgr8cpxqnmzMDjvH_oo')
                              .then((String? token) => {setToken(token!)});
                        }
                        sendPushMessageToWeb();
                      },
                      icon: Icon(Icons.notifications),
                    ),
                  ),
                ),
              ),
              SelectableText('${_token}')
            ],
          ),
        ));
  }
  String firebaseNotificationAppId = 'AAAAikk8uXk:APA91bFOyQyJmS7dvikNr74hMf4SlQGMieDg_TWhfdVbUwGlvcvE0Ar9mv-52aOroYukYmWMZwZb36m5hwKtG06-6_ycyVU8FSJYY4vXciEJHsdznG9EOVuZLww_PrsGuaO7fdIxtwIz';

  sendPushNotificationM()async{
    var request = {
      "notification":{
        "body":'this is the body',
        "title":'Thos os tje toe;e',
      },
      "registration_ids":[_token,],
      "data": {"screen": 'temp'},
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "authorization":"key=$firebaseNotificationAppId",
    };
    var response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: headers,body: jsonEncode(request));
    print('the response is ${response.statusCode}.... ${response.body}');
    if(response.statusCode==200){
      print('notification sent to ${_token} device');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('notification sent to ${_token} device')));
    }


  }
  //send notification
  sendPushMessageToWeb() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      showSnackBar(context, text: 'No Token');
      return;
    }
    try {
      // await http
      //     .post(
      //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
      //       headers: <String, String>{
      //         'Content-Type': 'application/json',
      //         'Authorization':
      //             'key=AAAAikk8uXk:APA91bFOyQyJmS7dvikNr74hMf4SlQGMieDg_TWhfdVbUwGlvcvE0Ar9mv-52aOroYukYmWMZwZb36m5hwKtG06-6_ycyVU8FSJYY4vXciEJHsdznG9EOVuZLww_PrsGuaO7fdIxtwIz'
      //       },
      //       body: json.encode({
      //         'to': _token,
      //         'message': {
      //           'token': _token,
      //         },
      //         "notification": {
      //           "title": "Push Notification",
      //           "body": "Firebase  push notification"
      //         }
      //       }),
      //     )
      //     .then((value) => print(value.body));
      sendPushNotificationM();
      print('FCM request for web sent!');
    } catch (e) {
      print(e);
    }
  }
}
