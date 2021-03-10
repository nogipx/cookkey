import 'package:cookkey/bloc/base_bloc.dart';
import 'package:cookkey/repo/auth_repo.dart';
import 'package:cookkey/store/token_store.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final AppSharedStore sharedStore;

  AuthBloc({
    @required this.authRepo,
    @required this.sharedStore,
  }) : super(null);

  @override
  AuthState mapError(ApiError error, AuthEvent event) => AuthFailure(error);

  @override
  void mapEvents() {
    mapEvent<AuthLocalLoggedIn>(_mapLocalLogin);
    mapEvent<AuthLoggedOut>(_mapLogout);
  }

  Stream<AuthState> _mapLocalLogin(AuthLocalLoggedIn event) async* {
    yield AuthProcess();
    final auth = await authRepo.login(event.credentials);
    await sharedStore.saveToken(auth.token);
    yield AuthSuccessLogin(auth);
  }

  Stream<AuthState> _mapLogout(AuthLoggedOut event) async* {
    yield AuthProcess();
    await authRepo.logout();
    await sharedStore.removeToken();
    yield AuthSuccessLogout();
  }
}

abstract class AuthEvent {
  const AuthEvent();
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
