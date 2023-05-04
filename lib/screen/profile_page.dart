import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pick_up_game/user/login_screen.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String? profilePictureUrl;
  String? name;
  int? basketballSkill;
  String? location;
  int? age;
  String? gender;

  Future<void> getUserProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userProfileSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      name = userProfileSnapshot['name'];
      basketballSkill = userProfileSnapshot['basketballSkill'];
      location = userProfileSnapshot['location'];
      age = userProfileSnapshot['age'];
      gender = userProfileSnapshot['gender'];
    });
    if (userProfileSnapshot['profilePictureUrl'] != null) {
      final ref = FirebaseStorage.instance
          .refFromURL(userProfileSnapshot['profilePictureUrl']);
      final url = await ref.getDownloadURL();
      setState(() {
        profilePictureUrl = url;
      });
    }
  }

  Future signOut() async {
    try {
      print('sign out complete');
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('sign out failed');
      print(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              profilePictureUrl != null
                  ? Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.hardEdge,
                      //default is none
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Image.network(
                        profilePictureUrl!,
                        errorBuilder: (context, error, stackTrace) =>
                            Text("Failed to load image"),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.hardEdge,
                      //default is none
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Icon(
                        Icons.person_pin,
                        size: 150,
                        color: Colors.grey,
                      ),
                    ),
              SizedBox(height: 20),
              Text('이름: ${name ?? ''}'),
              Text('농구수준: ${basketballSkill ?? ''}'),
              Text('지역: ${location ?? ''}'),
              Text('나이: ${age ?? ''}'),
              Text('성별: ${gender ?? ''}'),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),

      ),
    );
  }
}
