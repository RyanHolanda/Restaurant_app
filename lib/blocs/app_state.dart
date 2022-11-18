part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final String? authError;
  const AppState({required this.isLoading, this.authError});
}

class AppStateLoggedIn extends AppState {
  const AppStateLoggedIn({required isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, authError];
}

class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({required isLoading}) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading, authError];
}

class AppStateAuthError extends AppState {
  const AppStateAuthError({required isLoading, String? authError})
      : super(isLoading: isLoading, authError: authError);


  @override
  List<Object?> get props => [isLoading, authError];
}

class AppStateSendResetEmail extends AppState {
  const AppStateSendResetEmail({required isLoading})
      : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading];
}