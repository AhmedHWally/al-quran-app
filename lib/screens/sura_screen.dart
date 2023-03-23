import 'package:flutter/material.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class SuraScreen extends StatefulWidget {
  static const routeName = "sura-screen";

  @override
  State<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool isInit = true;
  Map<String, dynamic> sura = {};
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        sura =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  AppBar appbar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        sura["name"],
        style: const TextStyle(shadows: [
          Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        appbar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(),
      body: InteractiveViewer(
        panEnabled: true,
        maxScale: 1.5,
        child: SingleChildScrollView(
            child: Column(
          children: (sura["pages"] as List<int>)
              .map((e) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 5)),
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/quran/page$e.png",
                          fit: BoxFit.fill,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "(${arabicNumber.convert(e)})",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "",
                                    color: Colors.red[800],
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        )),
      ),
    );
  }
}
