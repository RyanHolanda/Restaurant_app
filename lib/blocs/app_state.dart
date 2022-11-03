part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final String? authError;
  const AppState({required this.isLoading, this.authError});
}

class AppStateLoggedIn extends AppState {
  AppStateLoggedIn({required isLoading}) : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, authError];
}

class AppStateLoggedOut extends AppState {
  AppStateLoggedOut({required isLoading}) : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, authError];
}

class AppStateAuthError extends AppState {
  AppStateAuthError({required isLoading, String? authError})
      : super(isLoading: isLoading, authError: authError);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, authError];
}

class AppStateSendResetEmail extends AppState {
  AppStateSendResetEmail({required isLoading})
      : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading];
}