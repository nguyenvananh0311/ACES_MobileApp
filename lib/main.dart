import 'package:ems/services/apiService.dart';
import 'package:ems/services/notification/localNotificationService.dart';
import 'package:ems/services/permission/requestPermission.dart';
import 'package:ems/services/signalR/signalrServiceProvider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activities/scanLoginQRcode.dart';
import 'assets/widget_component/languege.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'mainscreen.dart';
import 'models/notification/subscription.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RequestPermission().requestNotificationPermission();
  await LocalNotificationService().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? companyId = prefs.getString('companyId');
  String? employeeName = prefs.getString('name') ?? '';
  int? employeeId = prefs.getInt('employeeId');
  String? localeCode = prefs.getString('locale');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignalRServiceProvider(),
        ),
      ],
      child: MyApp(
        companyId: companyId,
        employeeId: employeeId,
        localeCode: localeCode,
        analytics: analytics,
        employeeName: employeeName,
      ),
    ),
  );
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  if(message.notification?.title != null) {
    LocalNotificationService().showNotificationAndroid('${message.notification?.title}', '${message.notification?.body}');
    // LocalNotificationService().showNotificationIos('${message.notification?.title}', '${message.notification?.body}');


  }

}
class MyApp extends StatefulWidget {
  final String? companyId;
  final int? employeeId;
  final String? localeCode;
  final String? employeeName;
  final FirebaseAnalytics? analytics;

  const MyApp({super.key, this.companyId, this.employeeId, this.localeCode, this.analytics, this.employeeName});

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late Locale _locale;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.localeCode ?? 'en');
    if (widget.employeeId != null && widget.companyId != null) {
      final signalRServiceProvider = Provider.of<SignalRServiceProvider>(context, listen: false);
      signalRServiceProvider.initialize(widget.employeeId!, widget.companyId!);
    }
    // if (widget.employeeId != null && widget.companyId != null) {
    //   final signalRServiceProvider = Provider.of<SignalRServiceProvider>(context, listen: false);
    //   signalRServiceProvider.initialize(widget.employeeId!, widget.companyId!);
    // }
    // _firebaseMessaging.requestPermission();
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // print('Nhận được thông báo: ${message.notification?.title}');
    //   LocalNotificationService().showNotificationAndroid('${message.notification?.title}', '${message.notification?.body}');
    //   // LocalNotificationService().showNotificationIos('${message.notification?.title}', '${message.notification?.body}');
    //
    // });
    //
    // _firebaseMessaging.getToken().then((token) {
    //   print('FCM Token: $token');
    //   Subscription subscription = Subscription(id: widget.employeeId!, token: token!);
    //   ApiService().subscribe(subscription, widget.companyId!);
    // });
  }

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('vi', ''),
        Locale('km', ''),
      ],
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: widget.analytics!), // Thêm observer cho Firebase Analytics
      ],
      home: widget.companyId != null && widget.employeeId != null && widget.employeeId != 0
          ? MainScreen(
        companyId: widget.companyId!,
        employeeId: widget.employeeId!,
        employeeName: widget.employeeName,
        onLocaleChange: _setLocale,
      )
          : InitialScreen(
        onLocaleChange: _setLocale,
      ),
    );
  }
}


class InitialScreen extends StatelessWidget {
  final Function(Locale) onLocaleChange;
  const InitialScreen({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return WillPopScope(
        onWillPop: () async => false, // Ngăn chặn việc quay lại
        child:  Scaffold(
        appBar: AppBar(
          actions: [
            LanguageSelector (onLocaleChange: onLocaleChange),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/images/mekongnet.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 50,),
          Card(
            margin: const EdgeInsets.all(20.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.blue,
            child: ListTile(
              title: Text(localization!.scanQRCodeToLogin, style: const TextStyle(color: Colors.white),),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  ScanLoginQRScreen(onLocaleChange:  onLocaleChange ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
