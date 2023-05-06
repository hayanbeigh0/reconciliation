import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reconciliation/data/models/user_details.dart';
import 'package:reconciliation/data/repositories/auth/authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationCubit(this.authenticationRepository)
      : super(AuthenticationInitial());
  String? sessionId;
  String? username;
  String? phoneNumber;

  signIn(String phoneNumber, bool resendOtp) async {
    this.phoneNumber = phoneNumber;
    emit(AuthenticationLoadingState());
    try {
      final response = await authenticationRepository.signIn(phoneNumber);
      final responseBody = response.data;
      print(jsonEncode(responseBody.toString()));
      if (response.statusCode == 200) {
        if (responseBody['CUSTOM_CHALLENGE'] != null &&
            responseBody['session'] != null) {
          sessionId = responseBody['session'];
        } else {
          sessionId = responseBody['session'];
          username = responseBody['username'];
        }

        if (!resendOtp) {
          emit(
            OTPSentSuccessfully(
              phoneNumber: phoneNumber,
              session: sessionId.toString(),
              username: username.toString(),
            ),
          );
          emit(
            OTPSentState(
              phoneNumber: phoneNumber,
              session: sessionId.toString(),
              username: username.toString(),
            ),
          );
        } else {
          emit(
            OTPSentSuccessfully(
              phoneNumber: phoneNumber,
              session: sessionId.toString(),
              username: username.toString(),
            ),
          );
          // emit(OTPSentSuccessfully());
          emit(
            OTPSentState(
              phoneNumber: phoneNumber,
              session: sessionId.toString(),
              username: username.toString(),
            ),
          );
        }
      } else {
        emit(AuthenticationLoginErrorState(error: responseBody));
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        emit(
          const AuthenticationLoginErrorState(
            error: 'Connection Timeout!',
          ),
        );
      }
      if (e.type == DioErrorType.unknown) {
        return emit(
          const AuthenticationLoginErrorState(
            error: 'Unknown error occurred!',
          ),
        );
      }
      if (e.response!.data == "User Phone number is not yet registered") {
        return emit(
          const AuthenticationLoginErrorState(
            error: 'Provided mobile number is not yet registered!',
          ),
        );
      }
      log(error: e.toString(), '3');
      emit(
        AuthenticationLoginErrorState(
          error: e.response!.statusMessage.toString(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  verifyOtp(Map<String, dynamic> userDetails, String otp) async {
    print('Verify Otp Cubit UserDetails: ${userDetails.toString()}');
    emit(AuthenticationLoadingState());
    try {
      final Response response =
          await authenticationRepository.verifyOtp(userDetails, otp);
      final responseBody = response.data;
      if (response.statusCode == 200) {
        if (responseBody['AuthenticationResult'] == null) {
          emit(
            const AuthenticationOtpErrorState(
              error:
                  " Oops! That OTP didn't work. Please check and enter the correct OTP.",
            ),
          );
          sessionId = responseBody['Session'];
          username = username;
          emit(
            OTPSentState(
              phoneNumber: phoneNumber.toString(),
              session: sessionId.toString(),
              username: username.toString(),
            ),
          );
        } else if (responseBody['AuthenticationResult']['AccessToken'] !=
            null) {
          AfterLogin afterLogin = AfterLogin.fromJson(responseBody);

          emit(AuthenticationSuccessState(afterLogin: afterLogin));
        } else {
          log(error: response.data, '1');
          emit(AuthenticationOtpErrorState(error: response.data));
        }
      } else {
        log(error: response.data, '2');
        emit(
          AuthenticationOtpErrorState(
            error: response.data,
          ),
        );
      }
    } on DioError catch (e) {
      log('Login error:${e.message}');
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        emit(
          const AuthenticationOtpErrorState(
            error: ' Connection Timeout!',
          ),
        );
      }
      if (e.type == DioErrorType.unknown) {
        emit(
          const AuthenticationOtpErrorState(
            error: ' Unknown error occurred!',
          ),
        );
        emit(
          OTPSentState(
            session: sessionId.toString(),
            username: username.toString(),
            phoneNumber: phoneNumber.toString(),
          ),
        );
      }
      // log(error: e.toString(), '3');
      if (e.response!.data['message'] == 'Unrecognizable lambda output') {
        emit(
          const AuthenticationOtpErrorState(
            error:
                ' You have exceeded 3 attempts. Please use "Resend OTP" to try again.',
          ),
        );
        emit(
          OTPSentState(
            session: sessionId.toString(),
            username: username.toString(),
            phoneNumber: phoneNumber.toString(),
          ),
        );
        return;
      }
      if (e.response!.data['message'] == "Invalid session for the user.") {
        emit(
          const AuthenticationOtpErrorState(
            error:
                ' You have exceeded 3 attempts. Please use "Resend OTP" to try again.',
          ),
        );
        emit(
          OTPSentState(
            session: sessionId.toString(),
            username: username.toString(),
            phoneNumber: phoneNumber.toString(),
          ),
        );
        return;
      }
      if (e.type == DioErrorType.unknown) {
        emit(
          const AuthenticationOtpErrorState(
            error: ' Unknown error occurred!',
          ),
        );
        return;
      }
      print('33:${e.response.toString()}');
      emit(
        const AuthenticationOtpErrorState(
          error: ' Unknown error occurred!',
        ),
      );
      emit(
        OTPSentState(
          session: sessionId.toString(),
          username: username.toString(),
          phoneNumber: phoneNumber.toString(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
