import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/configs/config.dart';
import 'package:flutter_login_register_nodejs/pages/Home.dart';
import 'package:flutter_login_register_nodejs/providers/alarm.dart';
import 'package:flutter_login_register_nodejs/providers/home.dart';
import 'package:flutter_login_register_nodejs/providers/profile.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'configs/app_colors.dart';
import 'pages/home-pages/home/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'services/shared_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // IO.Socket socket = IO.io(
  //     "https:neuralnet-server-2.herokuapp.com/",
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect()
  //         .setQuery({
  //           'id': "aecazcùzmecùzpeoc,zedc",
  //           'eraId': "parejo",
  //           'type': "client"
  //         })
  //         .build());
  // print(socket.runtimeType);
  // socket?.connect();
  // socket?.onConnect((_) {
  //   print(_);
  //   print('Connection established');
  // });
  // socket?.on('controle request', (newMessage) {
  //   print(newMessage);
  // });
  // socket?.onDisconnect((_) => print('Connection Disconnection'));
  // socket?.onConnectError((err) => print(err));
  // socket?.onError((err) => print(err));
  // print("zeite und zeite ");
  // IO.Socket socket = IO.io(
  //     "https://neuralnet-server-2.herokuapp.com/",
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect()
  //         .setQuery({
  //           'id': "bayernmeingusseliebe",
  //           'eraId': "parejo",
  //           'type': "client"
  //         })
  //         .build());
  // socket.connect();
  // // ignore: avoid_print
  // print("%bayern grosse libe");
  // print(socket.connect());
  // print("%Meine grosse libe");

  // print(socket);
  // print(socket.query);
  // print(socket.acks);
  // print(socket.flags);
  // print(socket.runtimeType);

  // socket.onError((data) => print(data));
  // socket.onConnect((_) {
  //   print('connect');
  //   print(_.toString());
  // });
  // socket.on('controle request', (data) => print("the data is here ${data}"));
  // socket.onDisconnect((_) => print('disconnect'));

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const Mainpage();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AlarmProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IO.Socket _socket;
  // final TextEditingController _messageInputController = TextEditingController();

  // _sendMessage() {
  //   _socket.emit('message', {
  //     'message': _messageInputController.text.trim(),
  //     'sender': widget.username
  //   });
  //   _messageInputController.clear();
  // }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
  }

  @override
  void dispose() {
    super.dispose();
  }

  //call init socket before doing anything

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Era APP',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: AppColors.lightTextColor),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.buttonColor),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: AppColors.lightTextColor)),
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3, color: AppColors.orange)),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColors.orange),
          fontFamily: GoogleFonts.poppins().fontFamily,
          backgroundColor: AppColors.containerBackground,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  primary: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))))),
      theme: _buildShrineTheme(),
      //home: const LoginPage(),
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => const Mainpage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    toggleableActiveColor: shrinePink400,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
    colorScheme: _shrineColorScheme.copyWith(secondary: shrineBrown900),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color.fromARGB(255, 83, 83, 83);

const Color shrineBrown900 = Color.fromARGB(255, 30, 7, 163);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
