import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { admin, doctor, patient }

class UserState {
  final String name;
  final UserRole role;
  final bool isAuthenticated;

  UserState({
    this.name = "Invitado",
    this.role = UserRole.patient,
    this.isAuthenticated = false,
  });

  UserState copyWith({String? name, UserRole? role, bool? isAuthenticated}) {
    return UserState(
      name: name ?? this.name,
      role: role ?? this.role,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<UserState> {
  AuthNotifier() : super(UserState(name: "María", isAuthenticated: true, role: UserRole.patient));

  void login(String name, UserRole role) {
    state = state.copyWith(name: name, role: role, isAuthenticated: true);
  }

  void logout() {
    state = UserState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, UserState>((ref) {
  return AuthNotifier();
});
