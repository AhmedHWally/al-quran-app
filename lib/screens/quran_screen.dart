import 'dart:async';

import 'package:azkar/screens/sura_screen.dart';
import 'package:flutter/material.dart';
import '../data/suras_list.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class QuranScreen extends StatefulWidget {
  static const routeName = "/quran-page";
  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<Map<String, Object>> filterdData = surasData;
  final controller = TextEditingController();
  ArabicNumbers arabicNumber = ArabicNumbers();

  void searchSurah(String value) {
    final data = surasData.where((surah) {
      final surahTitle = surah["name"] as String;
      return surahTitle.contains(value);
    }).toList();
    setState(() {
      filterdData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "القرآن الكريم",
          style: TextStyle(shadows: [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
          ]),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/ok.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  controller: controller,
                  onTap: () {
                    if (controller.selection ==
                        TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length - 1))) {
                      setState(() {
                        controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: controller.text.length));
                      });
                    }
                  },
                  onChanged: (value) {
                    searchSurah(value);
                  },
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(SuraScreen.routeName,
                          arguments: {
                            "name": filterdData[i]["name"],
                            "pages": filterdData[i]["images"]
                          });
                      FocusManager.instance.primaryFocus?.unfocus();
                      Timer(const Duration(milliseconds: 300), () {
                        controller.text = "";
                        searchSurah("");
                      });
                    },
                    child: Card(
                      color: Color(0xFFFCDDB0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ListTile(
                        leading: filterdData[i]["type"] == "Madaniyah"
                            ? const Text(
                                '\u{1F54C}',
                                style: TextStyle(fontSize: 30),
                              )
                            : const Text(
                                '\u{1F54B}',
                                style: TextStyle(fontSize: 30),
                              ),
                        title: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            filterdData[i]["name"] as String,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "أياتها ${arabicNumber.convert(filterdData[i]["count"])}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            )),
                      ),
                    ),
                  ),
                  itemCount: filterdData.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
