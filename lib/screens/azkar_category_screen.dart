import './azkar_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/button_widget.dart';

class AzkarCategoryScreen extends StatefulWidget {
  static const routeName = "/azkar-category";
  @override
  State<AzkarCategoryScreen> createState() => _AzkarCategoryScreenState();
}

class _AzkarCategoryScreenState extends State<AzkarCategoryScreen> {
  List<dynamic>? azkar;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        azkar = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/ok.jpg"), fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.2, bottom: height * 0.2),
            child: SizedBox(
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: CustomButton(
                          screen: AzkarScreen.routeName,
                          arguments: {
                            "data": azkar!
                                .where((element) =>
                                    element.category == "أذكار الصباح")
                                .toList(),
                            "title": "أذكار الصباح"
                          },
                          title: "أذكار الصباح"),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: CustomButton(
                          screen: AzkarScreen.routeName,
                          arguments: {
                            "data": azkar!
                                .where((element) =>
                                    element.category == "أذكار المساء")
                                .toList(),
                            "title": "أذكار المساء"
                          },
                          title: "أذكار المساء"),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: CustomButton(
                          screen: AzkarScreen.routeName,
                          arguments: {
                            "data": azkar!.where((element) {
                              if (element.category ==
                                      "أذكار الذهاب الي النوم" ||
                                  element.category ==
                                      "أذكار الاستيقاظ من النوم") {
                                return true;
                              }
                              return false;
                            }).toList(),
                            "title": "أذكار النوم"
                          },
                          title: "أذكار النوم"),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: CustomButton(
                          screen: AzkarScreen.routeName,
                          arguments: {
                            "data": azkar!.where((element) {
                              if (element.category != "أذكار الصباح" &&
                                  element.category != "أذكار المساء" &&
                                  element.category !=
                                      "أذكار الذهاب الي النوم" &&
                                  element.category !=
                                      "أذكار الاستيقاظ من النوم") {
                                return true;
                              }
                              return false;
                            }).toList(),
                            "title": "أذكار متنوعة"
                          },
                          title: "أذكار متنوعة"),
                    ),
                    FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        label: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.amber,
                              size: 30,
                            ),
                            Text(
                              "العودة الي الخلف",
                              style: TextStyle(color: Colors.white, shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 1)
                              ]),
                            ),
                          ],
                        ))
                  ]),
            ),
          )),
    );
  }
}
