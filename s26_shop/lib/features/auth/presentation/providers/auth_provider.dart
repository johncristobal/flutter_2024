import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infraestructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepo = AuthRepositoryImpl();
  return AuthNotifier(authRepo);
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  AuthNotifier(this.authRepository): super(AuthState());
  
  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials {
      logout( errorMsg: "Credenciales no validas" );
    } on ConnectionTimeout {
      logout( errorMsg: "Timeout" );
    } catch(e) {
      logout( errorMsg: "Error no controlado" );
    }
  }

  Future<void> logout({ String? errorMsg }) async {
    // tood: clear token
    state = state.copyWith(
      authStatus: AuthStatus.notauth,
      user: null,
      errorMsg: errorMsg
    );
  }

  void register(String email, String password, String fullname) async {
    
  }

  void checkStatus() async {
    
  }

  void _setLoggedUser(User user) {
    // todo: save token
    state = state.copyWith(
      user: user,
      errorMsg: "",
      authStatus: AuthStatus.auth
    );
  }
}

enum AuthStatus { checking, auth, notauth }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMsg;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMsg = ""
  });

  AuthState copyWith({
      AuthStatus? authStatus,
      User? user,
      String? errorMsg
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMsg: errorMsg ?? this.errorMsg,
  );
}