import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menyadapwa/content.dart';
import 'package:menyadapwa/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [GetPage(name: '/', page: () => Val.isSplash.val ? Splash() : MyHome())],
      // home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  _onLoad() async {
    await 3.delay();
    Get.offAll(MyHome());
    Val.isSplash.val = false;
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return Material(
      child: Center(
        child: Text("Makuro Studio"),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (c, media) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: !media.isMobile,
                          child: Material(child: Center(child: Text("Makuro Studio"))),
                        ),
                      ),
                      SizedBox(
                        width: media.isMobile ? Get.width : 460,
                        child: Card(
                          child: Column(
                            children: [
                              Flexible(
                                child: FutureBuilder<http.Response>(
                                  future: http.get(Uri.parse("https://raw.githubusercontent.com/malikkurosaki/sadapwa/main/content.json")),
                                  builder: (c, s) {
                                    if (s.connectionState != ConnectionState.done)
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    
                                    final listData = jsonDecode(s.data!.body);

                                    return ListView(
                                      children: [
                                        ...listData.map(
                                          (e) => Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    e['title'].toString(),
                                                  ),
                                                  Text(e['img'].toString())
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
