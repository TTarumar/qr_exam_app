import 'package:qr_exam_app/services/auth_service.dart';
import '../const/locator.dart';
import '../model/user_model.dart';
import '../services/auth_base.dart';
import '../viewModel/user_view_model.dart';


enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  AuthService authService = locator<AuthService>();
  AppMode appMode = AppMode.RELEASE;

  @override
  Future<UserModel> login(String mail, String pass) async {
    UserViewModel userViewModel=UserViewModel();

    if (appMode == AppMode.DEBUG) {
      return await null;
    } else {
      UserModel _userModel =
      await userViewModel.login(mail, pass);
      return _userModel;
    }
  }

  @override
  Future register(String email, String password, String passwordConfirmation, String firstName, String lastName) {
    // TODO: implement register
    throw UnimplementedError();
  }



}