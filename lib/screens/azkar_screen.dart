import 'package:flutter/material.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class AzkarScreen extends StatefulWidget {
  static const routeName = "/azkar-screen";

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool isInit = true;
  Map<String, Object> azkarType = {};

  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        azkarType =
            ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${azkarType["title"]}",
            style: const TextStyle(shadows: [
              Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
            ]),
          ),
          centerTitle: true,
        ),
        body: InteractiveViewer(
          panEnabled: true,
          maxScale: 1.5,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/ok.jpg"),
                        fit: BoxFit.fill)),
              ),
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: (azkarType["data"] as List)
                        .map((e) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            color: Color(0xFFFCDDB0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Column(
                                children: [
                                  Text(
                                    e.category,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.red[800]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    e.zekr,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (e.count != "")
                                    Text(
                                      "عدد مرات التكرار ${arabicNumber.convert(int.parse(e.count))} مرة",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.red[800]),
                                    )
                                ],
                              ),
                            )))
                        .toList()),
              ),
            ],
          ),
        ));
  }
}
