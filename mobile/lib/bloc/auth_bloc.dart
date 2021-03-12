import 'package:cookkey/bloc/base_bloc.dart';
import 'package:cookkey/repo/auth_repo.dart';
import 'package:cookkey/store/token_store.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final UserRepo userRepo;
  final AppSharedStore sharedStore;

  Auth _auth;

  AuthBloc({
    @required this.authRepo,
    @required this.userRepo,
    @required this.sharedStore,
  }) : super(null);

  @override
  AuthState mapError(ApiError error, AuthEvent event) => AuthFailure(error);

  @override
  void mapEvents() {
    mapEvent<AuthRestore>(_mapRestore);
    mapEvent<AuthLocalLoggedIn>(_mapLocalLogin);
    mapEvent<AuthLoggedOut>(_mapLogout);
  }

  void restoreLogin() {
    if (_auth != null) {
      add(AuthRestore(_auth));
    } else {
      final token = sharedStore.token;
      final user = sharedStore.user;
      if (token != null && user != null) {
        add(AuthRestore(Auth(token: token, user: user)));
      }
    }
  }

  void loginPassword(String username, String password) =>
      add(AuthLocalLoggedIn(AuthCredentials(username, password)));

  void logout() => add(AuthLoggedOut());

  Stream<AuthState> _mapRestore(AuthRestore event) async* {
    yield AuthSuccessLogin(event.auth);
  }

  Stream<AuthState> _mapLocalLogin(AuthLocalLoggedIn event) async* {
    yield AuthProcess();
    final auth = await authRepo.login(event.credentials);
    await sharedStore.saveToken(auth.token);
    await sharedStore.saveUser(auth.user);
    _auth = auth;
    yield AuthSuccessLogin(auth);
  }

  Stream<AuthState> _mapLogout(AuthLoggedOut event) async* {
    yield AuthProcess();
    await authRepo.logout();
    await sharedStore.removeToken();
    await sharedStore.clearUser();
    _auth = null;
    yield AuthSuccessLogout();
  }
}

abstract class AuthEvent {
  const AuthEvent();
}

class AuthRestore extends AuthEvent {
  final Auth auth;

  const AuthRestore(this.auth);
}

class AuthLocalLoggedIn extends AuthEvent {
  final AuthCredentials credentials;

  const AuthLocalLoggedIn(this.credentials);
}

class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

abstract class AuthState {
  const AuthState();
}

class AuthProcess extends AuthState {}

class AuthSuccessLogin extends AuthState {
  final Auth auth;

  const AuthSuccessLogin(this.auth);
}

class AuthSuccessLogout extends AuthState {
  const AuthSuccessLogout();
}

class AuthFailure extends AuthState {
  final ApiError error;

  const AuthFailure(this.error);
}
