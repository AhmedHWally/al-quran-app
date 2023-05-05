import 'dart:async';

import 'package:azkar/screens/custom_drawer.dart';
import 'package:azkar/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './screens/azkar_category_screen.dart';
import './screens/quran_screen.dart';
import 'package:flutter/material.dart';
import './screens/azkar_screen.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import './screens/sura_screen.dart';
import 'models/azkar.dart';
import 'widgets/button_widget.dart';
import './screens/names_of_allah_screen.dart';
import './screens/masbha_screen.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AzkarScreen.routeName: (ctx) => AzkarScreen(),
          QuranScreen.routeName: (ctx) => QuranScreen(),
          SuraScreen.routeName: (ctx) => SuraScreen(),
          NamesScreen.routeName: (ctx) => NamesScreen(),
          AzkarCategoryScreen.routeName: (ctx) => AzkarCategoryScreen(),
          MasbhaScreen.routeName: (ctx) => MasbhaScreen()
        },
        theme: ThemeData(
            fontFamily: "Tajawal",
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
            ).copyWith(primary: Colors.blueGrey, secondary: Colors.grey)),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? azkar;
  List<dynamic>? names;
  int? i;
  late final NotificationService notificationService;
  @override
  void initState() {
    getAzkar();
    getNames();
    loadImage();
    notificationService = NotificationService();
    notificationService.inializeNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        drawer: CustomDrawer(notificationService: notificationService),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: CustomButton(
                        screen: AzkarCategoryScreen.routeName,
                        arguments: azkar,
                        title: "اختيار الأذكار"),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: CustomButton(
                      screen: QuranScreen.routeName,
                      title: "القرآن الكريم",
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: ElevatedButton(
                      onPressed: () async {
                        await getPrefs();
                      },
                      child: const Text(
                        "المسبحة",
                        style: TextStyle(shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 1)
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: CustomButton(
                      screen: NamesScreen.routeName,
                      arguments: names,
                      title: "أسماء الله الحسني",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void loadImage() {
    Timer(const Duration(seconds: 1), () => FlutterNativeSplash.remove());
  }

  Future<void> getPrefs() async {
    final sharedpref = await SharedPreferences.getInstance();
    if (sharedpref.getInt("key") == null) {
      i = 0;
    }
    i = sharedpref.getInt("key");
    Navigator.of(context).pushNamed(MasbhaScreen.routeName, arguments: i);
  }

  Future<void> getAzkar() async {
    final response = await rootBundle.loadString("assets/azkar.json");
    final data = json.decode(response);

    setState(() {
      azkar = data.map((e) => Zekr.fromJson(e)).toList();
    });
  }

  Future<void> getNames() async {
    final response = await rootBundle.loadString("assets/names_of_allah.json");
    final data = json.decode(response);

    setState(() {
      names = data["data"].map((e) => e["name"]).toList();
    });
  }
}
