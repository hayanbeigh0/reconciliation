// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class OTPSentSuccessfully extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoginErrorState extends AuthenticationState {
  final String error;
  const AuthenticationLoginErrorState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}

class AuthenticationOtpErrorState extends AuthenticationState {
  final String error;
  const AuthenticationOtpErrorState({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}

class AuthenticationSuccessState extends AuthenticationState {
  final AfterLogin afterLogin;
  const AuthenticationSuccessState({
    required this.afterLogin,
  });
  @override
  List<Object?> get props => [afterLogin];
}

class OTPSentState extends AuthenticationState {
  final String username;
  final String session;
  final String phoneNumber;
  const OTPSentState({
    required this.username,
    required this.session,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props => [username, session, phoneNumber];
}

class NavigateToActivationState extends AuthenticationState {
  final String sessionId;
  final String username;
  final String phoneNumber;
  const NavigateToActivationState({
    required this.sessionId,
    required this.username,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props => [sessionId, username, phoneNumber];
}

// class AuthVerificationCode extends AuthenticationState {
//   final String confirmationCode;
//   final CognitoUser cognitoUser;
//   const AuthVerificationCode({
//     required this.confirmationCode,
//     required this.cognitoUser,
//   });
//   @override
//   List<Object?> get props => [confirmationCode, cognitoUser];
// }

class AuthSuccess extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends AuthenticationState {
  final String message;
  const AuthFailure({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
