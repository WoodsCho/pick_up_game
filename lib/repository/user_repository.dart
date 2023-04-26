import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pick_up_game/model/pickup_game_user.dart';

class UserRepository {
  static Future<PUser?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance.collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.size == 0){
      return null;
    }else {
      return PUser.fromJson(data.docs.first.data());
    }
  }

  static Future<bool> signup(PUser user)async{
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
      return true;
    }catch(e) {
      return false;

    }
  }
}