import 'package:eat_more_app/api/restaurants_api_model.dart';
import 'package:eat_more_app/color.dart';
import 'package:eat_more_app/helper/app_theme.dart';
import 'package:eat_more_app/model/arguments/check_out_argument.dart';
import 'package:eat_more_app/model/arguments/item_detail_argument.dart';
import 'package:eat_more_app/model/order_response.dart';
import 'package:eat_more_app/screens/branch_screen.dart';
import 'package:eat_more_app/screens/checkout_screen.dart';
import 'package:eat_more_app/screens/contact_us_screen.dart';
import 'package:eat_more_app/screens/delivery_ways_screen.dart';
import 'package:eat_more_app/screens/edit_profile_screen.dart';
import 'package:eat_more_app/screens/faq_screen.dart';
import 'package:eat_more_app/screens/favorite_screen.dart';
import 'package:eat_more_app/screens/home_screen.dart';
import 'package:eat_more_app/screens/item_detail_screen.dart';
import 'package:eat_more_app/screens/login_screen.dart';
import 'package:eat_more_app/screens/order_detail_screen.dart';
import 'package:eat_more_app/screens/restuerant_screen.dart';
import 'package:eat_more_app/screens/splash_screen.dart';
import 'package:eat_more_app/screens/verification_code_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'helper/app_localization.dart';
import 'helper/helper.dart';
import 'helper/shared_preference.dart';
import 'model/arguments/restaurent_argument.dart';
import 'screens/order_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UtilSharedPreferences.load();
  final apiModel = RestaurantsApiModel();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(ScopedModel(
    child: MyApp(),
    model: apiModel,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final _homeKey = GlobalKey<HomeScreenState>();

  @override
  void initState() {
    // TODO: implement initState
    if (!ScopedModel.of<RestaurantsApiModel>(context).isLoggedIn()) {
      FirebaseMessaging.instance.getToken().then((value) {
        Helper.fcmToken = value;
        print("token" + value);
      });
    }

    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background.xml',
              ),
            ));
      }
    });
    setupInteractedMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return ScopedModelDescendant<RestaurantsApiModel>(
        builder: (context, child, model) {
      return MaterialApp(

        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child);
        },
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar'),
          Locale('en'),
        ],
        locale: Locale(model.language == 0 ? "en" : "ar"),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.white,
            unselectedWidgetColor: black,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: primaryIconColor
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: AppThemeData.elevatedButtonStyle()
            ),
            textButtonTheme: TextButtonThemeData(
              style: AppThemeData.textButtonStyle()
            ),
            outlinedButtonTheme:OutlinedButtonThemeData(
                style:AppThemeData.buttonStyle(),
            ) ,

            // <-- your colorprimaryIconTheme: IconThemeData(color: background),
            scaffoldBackgroundColor: background),
        initialRoute: '/',
          routes: {
            "/": (context) => SplashScreen(),
            "/login": (context) => LoginScreen(),
          },
        onGenerateRoute: (setting){
          if(setting.name=='/code'){
            final arguments = setting.arguments as Map;
            return MaterialPageRoute(builder: (_)=>VerificationCodeScreen(phone: arguments['phone'], memberCase: arguments['member_case'],));
          }
          else if(setting.name=='/deliveryMethod'){
            final arguments = setting.arguments as int;
            return MaterialPageRoute(builder: (_)=>DeliveryMethodsScreen(id:arguments));
          }
          else if(setting.name=='/branch'){
            final arguments  = setting.arguments as Map;
            return MaterialPageRoute(builder: (_)=>BranchScreen(idWay: arguments['idWay'],id: arguments['id']));
          }
          else if(setting.name=='/restaurant'){
            final arguments = setting.arguments as RestaurantArgument;
            return MaterialPageRoute(builder: (_)=>RestaurantScreen(arguments));
          }
          else if(setting.name=='/checkOut'){
            final arguments = setting.arguments as CheckOutArgument;
            return MaterialPageRoute(builder: (_)=>CheckOutScreen(arguments));
          }
          else if(setting.name=='/productDetail'){
            final arguments = setting.arguments as ItemDetailsArgument;
            return MaterialPageRoute(builder: (_)=>ItemDetailsScreen(arguments));
          }
          else if(setting.name=='/OrderDetails'){
            final arguments = setting.arguments as Order;
            return MaterialPageRoute(builder: (_)=>OrderDetailsScreen(order: arguments,));
          }
          else if(setting.name=='/home'){
            return MaterialPageRoute(builder: (_)=>HomeScreen(key: _homeKey,callBack:_updateLanguageCallBack));
          }
          else if(setting.name=='/profile'){
            final argument = setting.arguments as String;
            return MaterialPageRoute(builder: (_)=>EditProfileScreen(title: argument,));
          }
          else if(setting.name=='/order'){
            final argument = setting.arguments as String;
            return MaterialPageRoute(builder: (_)=>OrderScreen(title: argument,));
          }
          else if(setting.name=='/favourite'){
            final argument = setting.arguments as String;
            return MaterialPageRoute(builder: (_)=>FavoriteScreen(title: argument,));
          }
          else if(setting.name=='/contact'){
            final argument = setting.arguments as String;
            return MaterialPageRoute(builder: (_)=>ContactUsScreen(title: argument,));
          }
          else if(setting.name=='/faq'){
            final argument = setting.arguments as String;
            return MaterialPageRoute(builder: (_)=>FAQScreen(title: argument,));
          }





          return null;
        },

      );
    });
  }


  void setupInteractedMessage() async{
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  _updateLanguageCallBack() async{
    _homeKey.currentState.getHomeProduct();
  }
  void _handleMessage(RemoteMessage initialMessage) {
    print(initialMessage.data);
  }
}
