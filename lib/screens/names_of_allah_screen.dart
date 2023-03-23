import 'package:flutter/material.dart';

class NamesScreen extends StatefulWidget {
  static const routeName = "/names-screen";

  @override
  State<NamesScreen> createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  List<dynamic>? names;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        names = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "أسماء الله الحسني",
          style: TextStyle(shadows: [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
          ]),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/ok.jpg"),
                    fit: BoxFit.fill)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, i) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              color: Color(0xFFFCDDB0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  names?[i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            itemCount: names?.length,
          ),
        ],
      ),
    );
  }
}
