import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_colors.dart';

class Config {
  static const String appName = "neural App";
  static const String apiURL = "neuralnet-server-2.herokuapp.com"; //PROD_URL
  //authenticaion API
  static const loginAPI = "/api/user/login";
  static const registerAPI = "/api/user/create";
  static const userProfileAPI = "/api/user/get/";
  // era API
  static const eraAddApi = "/api/era/create";
//   // notes API
  static const addNoteAPI = "/api/notes/create";
  static const updateNoteAPI = "/api/notes/update";
  static const deleteNoteAPI = "/api/notes/delete";
  static const getAllNotesApi = "/api/notes/getSpecificUser/";
  static const items = [
    Icon(
      Icons.home,
      color: AppColors.containerBackground,
      size: 30,
    ),
    Icon(
      Icons.device_hub,
      color: AppColors.containerBackground,
      size: 30,
    ),
    Icon(
      Icons.person,
      color: AppColors.containerBackground,
      size: 30,
    ),
    Icon(
      Icons.settings,
      color: AppColors.containerBackground,
      size: 30,
    )
  ];
}

class Constants {
  static const radius = 35.0;
  static const padding = 15.0;
}


// // var socket = io("https://neuralnet-server-2.herokuapp.com/", {
// //     query: { id: "aecazcùzmecùzpeoc,zedc$", eraId: "aeoiazcnpcsoclqscd", type: "client" }
// // })
// // var socket = io("https://neuralnet-server-2.herokuapp.com/", {
// //     query: { id: "aeoiazcnpcsoclqscd", type: "era" }
// // })
// // socket.emit("controle request", { message: "test2", eraId: "aeoiazcnpcsoclqscd" });
// // socket.on("controle request", arg => {
// //     console.log(arg)

// // });



//   curl "https://neuralnet-server-2.herokuapp.com/socket.io/?'id=miasandiebayern&,
//          eraId=parejo&type=client"
//   curl "https://neuralnet-server-2.herokuapp.com/socket.io/?id='miasandiebayern'&eraId='parejo'&type='client'"
//  curl "https://neuralnet-server-2.herokuapp.com/?'id=miasandiebayern&,
//          eraId=parejo&type=client"
//  curl "https://neuralnet-server-2.herokuapp.com/?id='miasandiebayern'&,
//          eraId='parejo'&type='client'"