import 'package:get/get.dart';
import 'package:pick_up_game/model/pickup_game_user.dart';
import 'package:pick_up_game/repository/user_repository.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find();

  Rx<PUser> user = PUser().obs;

  Future<PUser?>loginUser(String uid) async {
        var userData = await UserRepository.loginUserByUid(uid);
        print(userData);
        return userData;
    }

    void signup(PUser signupUser)async{

    var result = await UserRepository.signup(signupUser);
    if (result){
      user(signupUser);
    }
    }
}