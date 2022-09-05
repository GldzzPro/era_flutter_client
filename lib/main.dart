import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/configs/config.dart';
import 'package:flutter_login_register_nodejs/pages/Home.dart';
import 'package:google_fonts/google_fonts.dart';

import 'configs/app_colors.dart';
import 'pages/home-pages/home/home_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'services/shared_service.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  // IO.Socket socket = IO.io("https://neuralnet-server-2.herokuapp.com/");
  // print("heyyy");
  // print(IO.io("https://neuralnet-server-2.herokuapp.com/"));
  // socket.onConnect((_) {
  //   print('connect');
  //   socket.emit('msg', 'test');
  // });
  // socket.on('controle request', (data) => print(data));
  // socket.onDisconnect((_) => print('disconnect'));

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const Mainpage();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // IO.Socket? socket;

  // @override
  // void initState() {
  //   initSocket();
  //   super.initState();
  // }

  // initSocket() {
  //   socket =
  //       IO.io("https://neuralnet-server-2.herokuapp.com/", <String, dynamic>{
  //     'autoConnect': false,
  //     'transports': ['websocket'],
  //   });
  //   print(socket.runtimeType);
  //   socket?.connect();
  //   socket?.onConnect((_) {
  //     print('Connection established');
  //   });
  //   socket?.on('controle request', (newMessage) {
  //     print(newMessage);
  //   });
  //   socket?.onDisconnect((_) => print('Connection Disconnection'));
  //   socket?.onConnectError((err) => print(err));
  //   socket?.onError((err) => print(err));
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
