import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:menyadapwa/pref.dart';
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FutureBuilder<http.Response>(
                                    future: http.get(Uri.parse("${Pref.host}/ctn")),
                                    builder: (c, s) {
                                      if (s.connectionState != ConnectionState.done)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );

                                      final data = jsonDecode(s.data!.body);
                                      return ListView(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data['title'],
                                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 460,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                  width: double.infinity,
                                                  fit: BoxFit.contain,
                                                  imageUrl: "${Pref.host}/img/${data['img']}"),
                                            ),
                                          ),
                                          MarkdownWidget(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            data: data['data'],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
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
