import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterBackgroundService().on("messageReceive").listen((event) {
      print("messageReceive: " + event.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Home"),
          Center(
              child: StreamBuilder<Map<String, dynamic>?>(
            stream: FlutterBackgroundService().on("update"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('داده ای دریافت نشده...');
              }

              final data = snapshot.data!;
              return Text(data.toString());
            },
          )),
          ElevatedButton(
            child: Text("Foreground Mode"),
            onPressed: () {
              FlutterBackgroundService()
                  .invoke("setAsForeground", {"prop": "val"});
            },
          ),
          ElevatedButton(
            child: Text("Background Mode"),
            onPressed: () {
              FlutterBackgroundService().invoke("setAsBackground");
            },
          ),
          ElevatedButton(
            child: Text("Stop"),
            onPressed: () {
              FlutterBackgroundService().invoke("stopService");
            },
          ),
          ElevatedButton(
            child: Text("Start"),
            onPressed: () {
              FlutterBackgroundService().startService();
            },
          ),
          ElevatedButton(
            child: Text("Custom Event"),
            onPressed: () {
              FlutterBackgroundService()
                  .invoke("messageReceive", {"prop": "test"});
            },
          ),
          ElevatedButton(
            child: Text("Show Notify"),
            onPressed: () {
              FlutterLocalNotificationsPlugin().show(
                  3,
                  'title',
                  'body',
                  const NotificationDetails(
                    android: AndroidNotificationDetails(
                      'Custom Notify',
                      'MY custom notify',
                      icon: 'ic_bg_service_small',
                      ongoing: false,
                    ),
                  ),
                  payload: 'test payload');
            },
          ),
        ],
      ),
    );
  }
}
