import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasbhaScreen extends StatefulWidget {
  static const routeName = "/masbha-screen";

  @override
  State<MasbhaScreen> createState() => _MasbhaScreenState();
}

class _MasbhaScreenState extends State<MasbhaScreen> {
  int number = 0;
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          number = ModalRoute.of(context)?.settings.arguments as int;
        });
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void add() {
    setState(() {
      number++;
    });
  }

  void reset() {
    setState(() {
      number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFFCDDB0),
                  child: Text(
                    "$number",
                    style: const TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                              offset: Offset(1, 1),
                              color: Colors.white,
                              blurRadius: 1)
                        ],
                        fontFamily: ""),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    onPressed: () {
                      add();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "سبح",
                      style: TextStyle(fontSize: 20, shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ]),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                    onPressed: () async {
                      reset();
                      final sharedpref = await SharedPreferences.getInstance();
                      sharedpref.setInt("key", number);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "اعادة ضبط",
                      style: TextStyle(fontSize: 20, shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ]),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              FloatingActionButton.extended(
                  onPressed: () async {
                    final sharedpref = await SharedPreferences.getInstance();
                    sharedpref.setInt("key", number);
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
            ],
          )
        ],
      ),
    );
  }
}
