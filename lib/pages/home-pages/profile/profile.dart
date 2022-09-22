import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/models/auth/profile_response_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/profile.dart';
import '../../../services/api_service.dart';
import '../../../services/shared_service.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileProvider get state => Provider.of(context, listen: false);
  Future<ProfileResponseModel?> d = SharedService.profileDetails();

  @override
  Widget build(BuildContext context) {
    print(d.toString());
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Profile Page',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          const CircleAvatar(
            radius: 70,
            child: Icon(
              Icons.person,
              size: 120,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          userProfile(),
        ],
      ),
    );
  }

  Widget userProfile() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "name : ${state.profileData!.user.name}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "lastName : ${state.profileData!.user.lastName}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "email : ${state.profileData!.user.email}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "age : ${state.profileData!.user.age.toString()}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "phone : ${state.profileData!.user.phone}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "logout",
              style: TextStyle(
                  fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () {
                SharedService.logout(context);
              },
            ),
          ],
        ),
      ],
    ));
  }
}
