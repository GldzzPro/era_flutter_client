// import 'package:flutter/material.dart';
// import 'package:flutter_login_register_nodejs/models/auth/login_response_model.dart';
// import 'package:flutter_login_register_nodejs/models/auth/profile_response_model.dart';
// import 'package:flutter_login_register_nodejs/pages/home-pages/home/alarms/alarm.dart';
// import 'package:flutter_login_register_nodejs/pages/home-pages/home/alarms/alarmbeta.dart';
// import 'package:flutter_login_register_nodejs/providers/alarm.dart';

// import 'package:flutter_login_register_nodejs/services/api_service.dart';
// import 'package:flutter_login_register_nodejs/services/shared_service.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../../../configs/app_colors.dart';
// import '../../../providers/home.dart';
// import 'alarms/allview.dart';
// import 'chat/Chat.dart';
// import '../settings/settings.dart';
// import 'notes_views/home_view.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   LoginResponseModel? loginDetails;
//   void getUserID() async {
//     loginDetails = await SharedService.loginDetails();
//   }

//   @override
//   Widget build(BuildContext context) {
//     getUserID();
//     return Center(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           const Text("Conected successufully"),
//           const SizedBox(
//             height: 20,
//           ),
//           const Text("your devices"),
//           TextButton(
//             style: TextButton.styleFrom(
//               padding: const EdgeInsets.all(16.0),
//               primary: Colors.lightGreen,
//               textStyle: const TextStyle(fontSize: 20),
//             ),
//             onPressed: () => APIService.addEraMacAdress("fghoiuhygtfrs"),
//             child: const Text("add era"),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 32,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const HomeView(),
//                   ));
//                 },
//                 child: Text(
//                   'show my notes',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//               const SizedBox(
//                 height: 32,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => AlarmAllView(),
//                   ));
//                 },
//                 child: Text(
//                   'show alarm',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//               const SizedBox(
//                 height: 32,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => HomeScreen(
//                       username: loginDetails!.idUser!,
//                     ),
//                   ));
//                 },
//                 child: Text(
//                   'chat with era',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget userProfile() {
//   //   return FutureBuilder(
//   //     future: APIService.getUserProfile(),
//   //     builder: (
//   //       BuildContext context,
//   //       AsyncSnapshot<String> model,
//   //     ) {
//   //       if (model.hasData) {
//   //         return Center(
//   //             child: Column(
//   //           children: [
//   //             Text(model.data!),
//   //             const Text("your devices"),
//   //             TextButton(
//   //               style: TextButton.styleFrom(
//   //                 padding: const EdgeInsets.all(16.0),
//   //                 primary: Colors.lightGreen,
//   //                 textStyle: const TextStyle(fontSize: 20),
//   //               ),
//   //               onPressed: () => APIService.addEraMacAdress("fghoiuhygtfrs"),
//   //               child: const Text("add era"),
//   //             )
//   //           ],
//   //         ));
//   //       } else {}

//   //       return const Center(
//   //         child: CircularProgressIndicator(),
//   //       );
//   //     },
//   //   );
//   // }
// }
