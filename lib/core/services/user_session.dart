import 'package:flutter/foundation.dart';

/// Simple in-memory session holder.
/// Replace with a real provider/repository when backend is ready.
class UserSession {
  UserSession._();

  static final ValueNotifier<String?> roleNotifier =
      ValueNotifier<String?>(null);

  static String? get role => roleNotifier.value;
  static bool get isLoggedIn => roleNotifier.value != null;

  static void login(String userRole) => roleNotifier.value = userRole;
  static void logout() => roleNotifier.value = null;
}
