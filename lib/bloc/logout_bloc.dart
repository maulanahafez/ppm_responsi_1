import 'package:toko_kita/helpers/user_info.dart';

class LogoutBloc {
  static Future<void> logout() async {
    await UserInfo().logout();
  }
}
