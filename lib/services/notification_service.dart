import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> inializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('icon');
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {},
    );
  }

  NotificationDetails notificationDetails() {
    const sound = 'sound.mp3';
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            //importance: Importance.max,
            priority: Priority.high,
            icon: 'icon',
            sound: RawResourceAndroidNotificationSound(sound.split('.').first),
            playSound: true);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(presentSound: true);
    return NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  Future<void> repeatNotification({
    int id = 0,
  }) async {
    final details = notificationDetails();
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      'صلي علي محمد',
      'إِنَّ اللَّهَ وَمَلائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ يَا أَيُّهَا الَّذِينَ آمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا',
      RepeatInterval.hourly,
      details,
    );
  }

  Future<void> stopRepeatNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}
