import 'package:admobflutter_app/admob_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<String> allItem;
  late List<Object> admobItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allItem = [];
    for (int i = 0; i <= 20; i++) {
      allItem.add("Card $i");
    }
    admobItem = List.from(allItem);
    for (int i = admobItem.length - 3; i >= 1; i -= 3) {
      admobItem.insert(i, AdMobServices.createBannerAd()..load());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Google Admob"),
          centerTitle: true,
        ),
        body: ListView.builder(
            addAutomaticKeepAlives: true,
            itemCount: admobItem.length,
            itemBuilder: (context, index) {
              if (admobItem[index] is String) {
                return ListTile(
                  title: Text(admobItem[index].toString()),
                );
              } else {
                final Container adContainer = Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: AdWidget(
                      key: UniqueKey(), ad: admobItem[index] as BannerAd),
                );
                return adContainer;
              }
            }));
  }
}
