import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<AuthEvent>((event, emit) {});

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        var a = await authRepository.signIn(
            email: event.email, password: event.password);
        if (a == null) {
          emit(const AuthError("Something Wrong"));
          emit(UnAuthenticated());
        } else {
          emit(Authenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        var a = await authRepository.signUp(
            email: event.email, password: event.password, name: event.name);
        if (a == null) {
          emit(const AuthError("Something Wrong"));
          emit(UnAuthenticated());
        } else {
          emit(SingUpSuccess());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });

    on<CreateUserRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.createProfile(
            email: event.email, name: event.name);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    // on<GoogleSignInRequested>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await authRepository.signInWithGoogle();
    //     emit(Authenticated());
    //   } catch (e) {
    //     emit(AuthError(e.toString()));
    //     emit(UnAuthenticated());
    //   }
    // });
  }
}
