import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_login_register_nodejs/configs/app_colors.dart';

import '../../../models/message.dart';
import '../../../providers/home.dart';

class ShowDevices extends StatefulWidget {
  const ShowDevices({Key? key}) : super(key: key);

  @override
  State<ShowDevices> createState() => _ShowDevicesState();
}

class _ShowDevicesState extends State<ShowDevices> {
  late IO.Socket _socket;

  _sendMessage(String message) {
    print("rani taw ki lansset el msg dyelli eli housa ${message}");

    _socket.emit('message', {'message': message, 'sender': "BEDROOM Lamp"});
  }

  _connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on('message', (data) {
      print("wsselni message");
      print("data dyel msg $data");
    });
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = IO.io(
      "https://neuralnet-server-2.herokuapp.com/",
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'id': "BedRoomLamp", 'eraId': "messi", 'type': "client"}).build(),
    );
    _connectSocket();
  }

  bool clicked = false;
  bool firstClick = false;
  bool toggleLamp = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => Edit(),
      //     ));
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: AppColors.white,
      //   ),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Devices",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            AnimatedButton(
              height: 70,
              width: size.width * 0.8,
              text: clicked ? '▲ TOGGLE YOUR LAMPS' : '▼ SHOW YOUR LAMPS',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
              onPress: (() => setState(() {
                    clicked = !clicked;
                    firstClick ? null : firstClick = true;
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: !clicked ? 1.0 : 0.0, end: !clicked ? 0.0 : 1.0),
              duration: Duration(milliseconds: firstClick ? 600 : 0),
              curve: Curves.linearToEaseOut,
              child: Container(),
              builder: (BuildContext context, double val, Widget? child) {
                return Container(
                  width: size.width * 0.8,
                  height: size.height * 0.2 * val,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: AssetImage("assets/lamps.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    width: size.width * 0.8 * val,
                    height: size.height * 0.2 * val,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                _sendMessage(
                                    toggleLamp ? "turn off" : "turn on");
                                toggleLamp = !toggleLamp;
                              }),
                              child: Container(
                                width: size.width * 0.15 * val,
                                height: size.width * 0.15 * val,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF222222),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.lightbulb,
                                    size: size.width * 0.1 * val,
                                    color: toggleLamp
                                        ? Colors.white
                                        : AppColors.scaffoldBackground,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Beedroom Lamp',
                              style: TextStyle(
                                  fontSize: 15 * val,
                                  color: AppColors.buttonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {}),
                              child: Container(
                                width: size.width * 0.15 * val,
                                height: size.width * 0.15 * val,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF222222),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.lightbulb,
                                    size: size.width * 0.1 * val,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Kitchen Lamp       ',
                              style: TextStyle(
                                  fontSize: 15 * val,
                                  color: AppColors.buttonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedButton(
              height: 70,
              width: size.width * 0.8,
              text: 'SHOW YOUR CAMERAS',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.LEFT_TO_RIGHT,
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderRadius: 50,
              borderWidth: 2,
              onPress: (() => setState(() {})),
            ),
            const SizedBox(
              height: 20,
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: !clicked ? 1.0 : 0.0, end: !clicked ? 0.0 : 1.0),
              duration: Duration(milliseconds: 20),
              curve: Curves.linear,
              child: Container(),
              builder: (BuildContext context, double val, Widget? child) {
                return Container(
                  width: size.width * 0,
                  height: size.height * 0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                          image: AssetImage("assets/lamps.jpg"),
                          fit: BoxFit.fill)),
                  child: child!,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
