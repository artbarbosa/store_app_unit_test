import 'package:store_app_unit_test/app/modules/login/model/user_model.dart';

abstract class ILoginRepository {
  Future<UserModel> getLoginWithUsernameAndPassword();
  Future<String> postAuthWithUsernameAndPassword(
      String username, String password);
}
