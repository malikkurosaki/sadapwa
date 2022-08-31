import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:menyadapwa/pref.dart';
import 'package:menyadapwa/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:http/http.dart' as http;

// barner ads ca-app-pub-2622751365523301/8852544507
// Interstitial ca-app-pub-2622751365523301/8911382117

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // MobileAds.instance
  //   ..initialize()
  //   ..updateRequestConfiguration(
  //     RequestConfiguration(
  //       testDeviceIds: ["1B030295E62883ACDDBA081E32131B77"],
  //     ),
  //   );

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

class MyHome extends StatefulWidget {
  MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _datanya = {}.val("MyHome._datanya").obs;
  final _barnerAdsIsReady = false.obs;
  final _interasialIsReady = false.obs;
  final _hitung = 0.obs;

  late BannerAd _myBanner;
  late InterstitialAd _interstitialAd;

  _loadBarnerAdd() async {
    _myBanner = BannerAd(
      adUnitId: 'ca-app-pub-2622751365523301/8852544507',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => _barnerAdsIsReady.value = true,
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          _barnerAdsIsReady.value = false;
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
      ),
    );

    await _myBanner.load();
  }

  _createInterasialAds() async {
    _interasialIsReady.value = false;
    await InterstitialAd.load(
      adUnitId: "ca-app-pub-2622751365523301/8911382117",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interasialIsReady.value = true;
          _hitung.value += 1;
        },
        onAdFailedToLoad: (err) {
          debugPrint(err.toString());
          _interasialIsReady.value = false;
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadBarnerAdd();
    _createInterasialAds();
  }

  // _onLoad() async {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (c, media) {
        // _onLoad();
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
                      Builder(builder: (context) {
                        return SizedBox(
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
                                        // if (s.connectionState != ConnectionState.done) {
                                        //   return Center(
                                        //     child: CircularProgressIndicator(),
                                        //   );
                                        // }

                                        // if (s.data == null) return Text((s.data).toString());

                                        if (s.connectionState == ConnectionState.done) {
                                          _datanya.value.val = jsonDecode(s.data!.body);
                                        }

                                        return Builder(builder: (context) {
                                          return Obx(() => _datanya.value.val.isEmpty
                                              ? Center(
                                                  child: CircularProgressIndicator(),
                                                )
                                              : ListView(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            _datanya.value.val['title'],
                                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                                          ),
                                                          Obx(
                                                            () => !_interasialIsReady.value
                                                                ? SizedBox.shrink()
                                                                : Row(
                                                                    children: [
                                                                      MaterialButton(
                                                                        child: Text("Munculkan"),
                                                                        onPressed: () async {
                                                                          if (_interasialIsReady.value) {
                                                                            await _interstitialAd.show();
                                                                            await _createInterasialAds();
                                                                            return;
                                                                          }

                                                                          debugPrint("error interasial ads");
                                                                        },
                                                                      ),
                                                                      Text(_hitung.value.toString())
                                                                    ],
                                                                  ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 460,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: CachedNetworkImage(
                                                            width: double.infinity,
                                                            fit: BoxFit.contain,
                                                            imageUrl: "${Pref.host}/img/${_datanya.value.val['img']}"),
                                                      ),
                                                    ),
                                                    MarkdownWidget(
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      data: _datanya.value.val['data'],
                                                    ),
                                                  ],
                                                ));
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Obx(() {
                  if (!_barnerAdsIsReady.value) return const SizedBox.shrink();
                  return Container(
                    alignment: Alignment.center,
                    width: _myBanner.size.width.toDouble(),
                    height: _myBanner.size.height.toDouble(),
                    child: AdWidget(ad: _myBanner),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
