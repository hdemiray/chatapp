import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/firebase_options.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Bildirim kanalı
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Yüksek Önemli Bildirimler',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Bildirimleri başlat
  Future<void> initNotifications() async {
    print("🔔 NOTIFICATION SERVICE: Bildirimler başlatılıyor");

    // FCM başlatma
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

    // Bildirim izinlerini isteme
    await _firebaseMessaging.requestPermission();

    // Bildirim kanalını oluşturma
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Ön planda bildirim ayarları
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    print("🔔 NOTIFICATION SERVICE: Bildirimler başlatıldı");
  }

  // Bildirim gönder
  Future<void> sendNotification({
    required String receiverUserId,
    required String message,
    required String senderName,
    required String senderId,
  }) async {
    try {
      print("🔔 NOTIFICATION SERVICE: Bildirim gönderme başladı");

      // Alıcının token'ını al
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(receiverUserId).get();

      if (!userDoc.exists) {
        print("❌ NOTIFICATION SERVICE: Kullanıcı dökümanı bulunamadı!");
        return;
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String? receiverToken = userData['fcmToken'] as String?;

      if (receiverToken == null || receiverToken.isEmpty) {
        print("❌ NOTIFICATION SERVICE: Token bulunamadı veya boş!");
        return;
      }

      // Firestore'da notifications koleksiyonuna bildirim ekle
      String senderName2 = senderName.split("@")[0];
      await _firestore.collection('notifications').add({
        'token': receiverToken,
        'title': '$senderName2\'den yeni mesaj',
        'body': message,
        'receiverId': receiverUserId,
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("✅ NOTIFICATION SERVICE: Bildirim başarıyla oluşturuldu!");
    } catch (e) {
      print("❌ NOTIFICATION SERVICE HATASI: ${e.toString()}");
    }
  }

  // Kullanıcının FCM tokenını kaydet
  Future<void> saveUserToken(String userId) async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print("🔔 NOTIFICATION SERVICE: Token alındı => $token");

      await _firestore.collection('Users').doc(userId).set({
        'fcmToken': token,
      }, SetOptions(merge: true));

      print("✅ NOTIFICATION SERVICE: Token başarıyla kaydedildi!");
    } catch (e) {
      print("❌ NOTIFICATION SERVICE HATASI: ${e.toString()}");
    }
  }

  // Arka plan mesaj işleyici
  Future<void> _backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print(
        '🔔 NOTIFICATION SERVICE: Arka planda mesaj alındı: ${message.messageId}');
  }
}
