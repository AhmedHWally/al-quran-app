import 'package:azkar/services/notification_service.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.notificationService});
  final NotificationService notificationService;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool data = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width * 0.6,
      child: Column(children: [
        Container(
          height: height * 0.15,
          color: Colors.grey,
          width: width,
          child: const SafeArea(
            child: Center(
                child: Text(
              'القرآن الكريم',
              style: TextStyle(shadows: [
                Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)
              ], fontSize: 22, color: Colors.white),
            )),
          ),
        ),
        Expanded(
          child: ListView(padding: const EdgeInsets.only(top: 10), children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.notification_add),
                  onPressed: () {
                    widget.notificationService.repeatNotification();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'تم تشغيل الاشعارات',
                      style: TextStyle(shadows: [
                        Shadow(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ], fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.end,
                    )));
                  },
                  label: const Text(
                    'تشغيل الإشعارات',
                    style: TextStyle(shadows: [
                      Shadow(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          offset: Offset(1, 1),
                          blurRadius: 1)
                    ], fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton.icon(
                  icon: const Icon(Icons.notifications_off),
                  onPressed: () {
                    widget.notificationService.stopRepeatNotification();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'تم إيقاف الاشعارات',
                      style: TextStyle(shadows: [
                        Shadow(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ], fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.end,
                    )));
                  },
                  label: const Text(
                    'إيقاف الإشعارات',
                    style: TextStyle(shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 1)
                    ], fontSize: 20, color: Colors.white),
                  )),
            )
          ]),
        )
      ]),
    );
  }
}
