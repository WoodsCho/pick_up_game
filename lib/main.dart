import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pick_up_game/firebase_options.dart';
import 'package:pick_up_game/screen/login_screen.dart';
import 'package:pick_up_game/screen/root.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp( _App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Root(),
    );
  }
}
