// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

@immutable
class AppEventGetData extends AppEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class AppEventlogIn extends AppEvent {
  final String email;
  final String password;
  const AppEventlogIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

@immutable
class AppEventRegister extends AppEvent {
  final int phoneNumber;
  final String email;
  final String password;
  const AppEventRegister(
      {required this.email, required this.password, required this.phoneNumber});

  @override
  List<Object?> get props => [email, password, phoneNumber];
}

class AppEventEnterWithGoogle extends AppEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class AppEventSignOut extends AppEvent {
  @override
  List<Object?> get props => [];
}

@immutable
class AppEventResetPassword extends AppEvent {
  final String email;
  const AppEventResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}
