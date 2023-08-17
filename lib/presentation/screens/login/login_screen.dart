import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reconciliation/business_logic/auth/authentication_cubit.dart';
import 'package:reconciliation/business_logic/local_storage/local_storage_cubit.dart';
import 'package:reconciliation/presentation/screens/home/add_task_screen.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/functions/snackbars.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController otpController = TextEditingController();
  final double otpFieldSpacing = 40;

  bool mobileNumberEmpty = false;
  bool mobileNumberIsLessDigits = false;
  bool invalidOTP = false;
  bool isResendOtpVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationInitial) {
            setState(() {
              isResendOtpVisible = false;
            });
            _mobileNumberController.clear();
          }
          if (state is OTPSentSuccessfully) {
            SnackBars.sucessMessageSnackbar(
                context, '✅ Otp sent to ${state.phoneNumber}');
          }
          if (state is AuthenticationLoginErrorState) {
            SnackBars.errorMessageSnackbar(context, state.error);
          }
          if (state is AuthenticationOtpErrorState) {
            SnackBars.errorMessageSnackbar(context, state.error);
            otpController.clear();
          }

          if (state is AuthenticationSuccessState) {
            BlocProvider.of<LocalStorageCubit>(context)
                .storeUserData(state.afterLogin);
            Navigator.of(context).pushNamedAndRemoveUntil(
              AddTaskScreen.routeName,
              (route) => false,
            );
          }
          if (state is AuthenticationLoginErrorState) {
            SnackBars.errorMessageSnackbar(context, state.error);
          }
        },
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 50),
                color: const Color(0xFF253358),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg/reconlogo.svg'),
                    const Expanded(child: SizedBox()),
                    Text(
                      'Effortlessly compare Excel sheets and unveil insights like never before',
                      style: GoogleFonts.inder(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome back',
                      style: GoogleFonts.lexendDeca(
                        color: const Color(0xFF313131),
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Continue to the dashboard',
                      style: GoogleFonts.lexendDeca(
                        color: const Color(0xFF616161),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 3, child: SizedBox()),
                        Expanded(
                          flex: 4,
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mobile number',
                                  style: GoogleFonts.lexendDeca(
                                    color: const Color(0xFF616161),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Stack(
                                  children: [
                                    TextFormField(
                                      controller: _mobileNumberController,
                                      style: GoogleFonts.lexendDeca(),
                                      onChanged: (value) {
                                        setState(() {
                                          mobileNumberIsLessDigits = false;
                                          mobileNumberEmpty = false;
                                        });
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFB6B6B6),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF497EF7),
                                          ),
                                        ),
                                        disabledBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 230, 230, 230),
                                          ),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 230, 230, 230),
                                          ),
                                        ),
                                        hoverColor: AppColors.colorWhite,
                                        filled: true,
                                        fillColor: AppColors.colorWhite,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Ex: 999 888 7777',
                                        hintMaxLines: 1,
                                        errorStyle: AppStyles.errorTextStyle,
                                        hintStyle:
                                            AppStyles.primaryTextFieldHintStyle,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isResendOtpVisible,
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        color: const Color.fromARGB(
                                            191, 255, 255, 255),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<AuthenticationCubit>(
                                                  context)
                                              .clearMobileNumber();
                                          setState(() {
                                            isResendOtpVisible = false;
                                          });
                                          _mobileNumberController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Visibility(
                                  visible: mobileNumberEmpty ||
                                      mobileNumberIsLessDigits,
                                  replacement: const SizedBox(height: 25),
                                  child: SizedBox(
                                    height: 25,
                                    child: Text(
                                      mobileNumberIsLessDigits
                                          ? 'Mobile number must be 10 digits long.'
                                          : 'Mobile number is required',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                AnimatedContainer(
                                  duration: const Duration(
                                    milliseconds: 200,
                                  ),
                                  height: isResendOtpVisible ? 110 : 0,
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Enter OTP',
                                          style: GoogleFonts.lexendDeca(
                                            color: const Color(0xFF616161),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: otpController,
                                          onFieldSubmitted: (value) {},
                                          onChanged: (value) {
                                            setState(() {
                                              invalidOTP = false;
                                            });
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4)
                                          ],
                                          style: GoogleFonts.lexendDeca(),
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFB6B6B6),
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF497EF7),
                                              ),
                                            ),
                                            hoverColor: AppColors.colorWhite,
                                            filled: true,
                                            fillColor: AppColors.colorWhite,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            hintText: '',
                                            hintMaxLines: 1,
                                            errorStyle:
                                                AppStyles.errorTextStyle,
                                            hintStyle: AppStyles
                                                .primaryTextFieldHintStyle,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Visibility(
                                          visible: invalidOTP,
                                          replacement:
                                              const SizedBox(height: 25),
                                          child: SizedBox(
                                            height: 25,
                                            child: Text(
                                              'Enter a valid otp',
                                              style: GoogleFonts.lexendDeca(
                                                fontSize: 12,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                BlocConsumer<AuthenticationCubit,
                                    AuthenticationState>(
                                  listener: (context, state) {
                                    if (state is OTPSentState) {
                                      setState(() {
                                        isResendOtpVisible = true;
                                      });
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthenticationLoadingState) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color(0xFF497EF7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: const SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              const Color(0xFF497EF7),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_mobileNumberController
                                              .text.isEmpty) {
                                            setState(() {
                                              mobileNumberEmpty = true;
                                            });
                                          } else if (_mobileNumberController
                                                  .text.length <
                                              10) {
                                            setState(() {
                                              mobileNumberIsLessDigits = true;
                                            });
                                          } else if (isResendOtpVisible) {
                                            if (otpController.text.length < 4) {
                                              setState(() {
                                                invalidOTP = true;
                                              });
                                              return;
                                            }
                                          }
                                          if (state is OTPSentState) {
                                            if (isResendOtpVisible) {
                                              BlocProvider.of<
                                                          AuthenticationCubit>(
                                                      context)
                                                  .verifyOtp(
                                                {
                                                  "username": state.username,
                                                  "session": state.session,
                                                  "phone_number":
                                                      state.phoneNumber,
                                                },
                                                otpController.text,
                                              );
                                            }
                                            return;
                                          } else {
                                            BlocProvider.of<
                                                        AuthenticationCubit>(
                                                    context)
                                                .signIn(
                                              _mobileNumberController.text,
                                              false,
                                            );
                                          }

                                          // if (_formKey.currentState!.validate()) {
                                          // }
                                        },
                                        child: Text(
                                          isResendOtpVisible
                                              ? 'Login'
                                              : 'Send OTP',
                                          style: GoogleFonts.lexendDeca(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                BlocBuilder<AuthenticationCubit,
                                    AuthenticationState>(
                                  builder: (context, state) {
                                    if (state is OTPSentState) {
                                      return SizedBox(
                                        height: 40,
                                        width: double.infinity,
                                        child: Visibility(
                                          visible: isResendOtpVisible,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              child: Text(
                                                'Resend OTP',
                                                style: GoogleFonts.lexendDeca(
                                                  color:
                                                      const Color(0xFF497EF7),
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              onTap: () {
                                                BlocProvider.of<
                                                            AuthenticationCubit>(
                                                        context)
                                                    .signIn(state.phoneNumber,
                                                        true);
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: Visibility(
                                        visible: isResendOtpVisible,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            child: Text(
                                              'Resend OTP',
                                              style: GoogleFonts.lexendDeca(
                                                color: const Color(0xFF497EF7),
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(flex: 3, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return loginScreen();
  }
}
