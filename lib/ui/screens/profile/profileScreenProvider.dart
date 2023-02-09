import 'package:karbanboard/core/services/auth_services.dart';

import '../../../core/others/base_view_model.dart';
import '../../../locator.dart';

/// Add logic for Logout User
/// Add logic for display user data

class ProfileScreenProvider extends BaseViewModel {
  AuthService _auth = locator<AuthService>();

  void logout() {
    _auth.logout();
  }
}
