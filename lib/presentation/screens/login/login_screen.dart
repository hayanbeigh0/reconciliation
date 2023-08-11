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
import 'package:reconciliation/presentation/widgets/primary_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();
  final TextEditingController otpController1 = TextEditingController();

  final TextEditingController otpController2 = TextEditingController();

  final TextEditingController otpController3 = TextEditingController();

  final TextEditingController otpController4 = TextEditingController();

  FocusNode focusNode1 = FocusNode();

  FocusNode focusNode2 = FocusNode();

  FocusNode focusNode3 = FocusNode();

  FocusNode focusNode4 = FocusNode();

  final double otpFieldSpacing = 40;

  bool mobileNumberFieldEnabled = true;

  bool otpFieldsEnabled = false;
  bool mobileNumberEmpty = false;
  bool mobileNumberIsLessDigits = false;
  bool invalidOTP = false;
  final PageController pageController = PageController();
  int currentPageIndex = 0;
  bool isResendOtpVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is OTPSentSuccessfully) {
            setState(() {
              pageController.animateToPage(
                1,
                duration: const Duration(
                  milliseconds: 100,
                ),
                curve: Curves.easeInOut,
              );
            });
            SnackBars.sucessMessageSnackbar(
                context, '✅ Otp sent to ${state.phoneNumber}');
            setState(() {
              mobileNumberFieldEnabled = false;
              otpFieldsEnabled = true;
            });
          }
          if (state is AuthenticationLoginErrorState) {
            SnackBars.errorMessageSnackbar(context, state.error);
          }
          if (state is AuthenticationOtpErrorState) {
            SnackBars.errorMessageSnackbar(context, state.error);
            otpController1.clear();
            otpController2.clear();
            otpController3.clear();
            otpController4.clear();
            focusNode1.requestFocus();
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
                      'Continue to your profile',
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
                            key: _formKey,
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
                                TextFormField(
                                  controller: _mobileNumberController,
                                  enabled: !isResendOtpVisible,
                                  // onFieldSubmitted: (value) =>
                                  //     _formKey.currentState!.validate(),
                                  // validator: (value) =>
                                  //     validateMobileNumber(value!),
                                  style: GoogleFonts.lexendDeca(),
                                  onChanged: (value) {
                                    setState(() {
                                      mobileNumberIsLessDigits = false;
                                      mobileNumberEmpty = false;
                                    });
                                    // if (value.length == 10) {
                                    //   _formKey.currentState!.validate();
                                    // }
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
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 230, 230, 230),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 230, 230, 230),
                                      ),
                                    ),
                                    hoverColor: AppColors.colorWhite,
                                    filled: true,
                                    fillColor: !isResendOtpVisible
                                        ? AppColors.colorWhite
                                        : const Color.fromARGB(
                                            255, 230, 230, 230),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Ex: 705 174 460',
                                    hintMaxLines: 1,
                                    errorStyle: AppStyles.errorTextStyle,
                                    hintStyle:
                                        AppStyles.primaryTextFieldHintStyle,
                                  ),
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
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0xFF497EF7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
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
                                        }
                                      } else {
                                        setState(() {
                                          isResendOtpVisible =
                                              !isResendOtpVisible;
                                        });
                                      }

                                      // if (_formKey.currentState!.validate()) {
                                      // }
                                    },
                                    child: Text(
                                      isResendOtpVisible ? 'Login' : 'Send OTP',
                                      style: GoogleFonts.lexendDeca(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
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

  Scaffold loginScreen() {
    return Scaffold(
      body: Stack(
        children: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is OTPSentSuccessfully) {
                setState(() {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(
                      milliseconds: 100,
                    ),
                    curve: Curves.easeInOut,
                  );
                });
                SnackBars.sucessMessageSnackbar(
                    context, '✅ Otp sent to ${state.phoneNumber}');
                setState(() {
                  mobileNumberFieldEnabled = false;
                  otpFieldsEnabled = true;
                });
              }
              if (state is AuthenticationLoginErrorState) {
                SnackBars.errorMessageSnackbar(context, state.error);
              }
              if (state is AuthenticationOtpErrorState) {
                SnackBars.errorMessageSnackbar(context, state.error);
                otpController1.clear();
                otpController2.clear();
                otpController3.clear();
                otpController4.clear();
                focusNode1.requestFocus();
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
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/reconciliationbackgrounglogin.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.15,
                            ),
                            const Text(
                              'RECONCILIATION',
                              style: TextStyle(
                                fontSize: 38,
                                color: AppColors.colorPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 370,
                                      ),
                                      width: constraints.maxWidth / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.colorPrimaryLight,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.05,
                                        vertical: constraints.maxHeight * 0.05,
                                      ),
                                      child: PageView(
                                        controller: pageController,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        onPageChanged: (value) {
                                          setState(() {
                                            currentPageIndex = value;
                                          });
                                        },
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: AppColors
                                                        .colorSecondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.04,
                                                ),
                                                const Text(
                                                  'Mobile Number',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors
                                                        .colorPrimaryExtraDark,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.005,
                                                ),
                                                SizedBox(
                                                  height: 80,
                                                  child: PrimaryTextField(
                                                    fieldValidator: (p0) =>
                                                        validateMobileNumber(
                                                      p0.toString(),
                                                    ),
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      LengthLimitingTextInputFormatter(
                                                          10),
                                                    ],
                                                    title: '',
                                                    hintText: '999 888 7777',
                                                    textEditingController:
                                                        _mobileNumberController,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.02,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: BlocBuilder<
                                                      AuthenticationCubit,
                                                      AuthenticationState>(
                                                    builder: (context, state) {
                                                      if (state
                                                          is AuthenticationLoadingState) {
                                                        return ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: constraints
                                                                      .maxHeight *
                                                                  0.025,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            backgroundColor:
                                                                AppColors
                                                                    .colorPrimary,
                                                          ),
                                                          onPressed: () {},
                                                          child: const Text(
                                                            'Get OTP',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .colorWhite,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      if (state
                                                          is OTPSentState) {
                                                        return ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: constraints
                                                                      .maxHeight *
                                                                  0.025,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            backgroundColor:
                                                                AppColors
                                                                    .colorPrimary,
                                                          ),
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              BlocProvider.of<
                                                                          AuthenticationCubit>(
                                                                      context)
                                                                  .verifyOtp(
                                                                {
                                                                  "username": state
                                                                      .username,
                                                                  "session": state
                                                                      .session,
                                                                  "phone_number":
                                                                      state
                                                                          .phoneNumber,
                                                                  "user_type":
                                                                      "STAFF"
                                                                },
                                                                otpController1
                                                                        .text +
                                                                    otpController2
                                                                        .text +
                                                                    otpController3
                                                                        .text +
                                                                    otpController4
                                                                        .text,
                                                              );
                                                            } else {
                                                              log('Error');
                                                            }
                                                          },
                                                          child: const Text(
                                                            'Get OTP',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .colorWhite,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      return ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            vertical: constraints
                                                                    .maxHeight *
                                                                0.025,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          backgroundColor:
                                                              AppColors
                                                                  .colorPrimary,
                                                        ),
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            BlocProvider.of<
                                                                        AuthenticationCubit>(
                                                                    context)
                                                                .signIn(
                                                              _mobileNumberController
                                                                  .text,
                                                              false,
                                                            );
                                                          } else {
                                                            log('Error');
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Get OTP',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorWhite,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.04,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Login',
                                                  style: TextStyle(
                                                    fontSize: 26,
                                                    color: AppColors
                                                        .colorSecondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.04,
                                                ),
                                                Text(
                                                  "Enter OTP",
                                                  style: AppStyles
                                                      .loginScreensInputFieldTitleTextStyle,
                                                ),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.005,
                                                ),
                                                otpFields(context),
                                                SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          0.02,
                                                ),
                                                BlocBuilder<AuthenticationCubit,
                                                    AuthenticationState>(
                                                  builder: (context, state) {
                                                    if (state is OTPSentState) {
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Didn\'t receive the OTP?',
                                                                style: AppStyles
                                                                    .inputAndDisplayTitleStyle
                                                                    .copyWith(
                                                                  fontSize: 14,
                                                                  color: AppColors
                                                                      .colorPrimaryExtraDark,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  BlocProvider.of<
                                                                              AuthenticationCubit>(
                                                                          context)
                                                                      .signIn(
                                                                          state
                                                                              .phoneNumber,
                                                                          true);
                                                                },
                                                                child: Text(
                                                                  'Resend Otp',
                                                                  style: AppStyles
                                                                      .loginScreensResendOtpTextStyle
                                                                      .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color: AppColors
                                                                        .colorPrimary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: constraints
                                                                    .maxHeight *
                                                                0.02,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical:
                                                                      constraints
                                                                              .maxHeight *
                                                                          0.025,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                backgroundColor:
                                                                    AppColors
                                                                        .colorPrimary,
                                                              ),
                                                              onPressed: () {
                                                                if (_formKey
                                                                        .currentState!
                                                                        .validate() &&
                                                                    otpController1
                                                                        .text
                                                                        .isNotEmpty &&
                                                                    otpController2
                                                                        .text
                                                                        .isNotEmpty &&
                                                                    otpController3
                                                                        .text
                                                                        .isNotEmpty &&
                                                                    otpController4
                                                                        .text
                                                                        .isNotEmpty) {
                                                                  log('Sessions from the login screen: ${state.session.toString()}');
                                                                  BlocProvider.of<
                                                                              AuthenticationCubit>(
                                                                          context)
                                                                      .verifyOtp(
                                                                    {
                                                                      "username":
                                                                          state
                                                                              .username,
                                                                      "session":
                                                                          state
                                                                              .session,
                                                                      "phone_number":
                                                                          state
                                                                              .phoneNumber,
                                                                    },
                                                                    otpController1.text +
                                                                        otpController2
                                                                            .text +
                                                                        otpController3
                                                                            .text +
                                                                        otpController4
                                                                            .text,
                                                                  );
                                                                } else {
                                                                  SnackBars.errorMessageSnackbar(
                                                                      context,
                                                                      'OTP fields cannot be empty!');
                                                                  WidgetsBinding
                                                                      .instance
                                                                      .addPostFrameCallback(
                                                                          (_) {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .requestFocus(
                                                                            focusNode1);
                                                                  });
                                                                }
                                                              },
                                                              child: const Text(
                                                                'Submit',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .colorWhite,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Didn\'t receive the OTP?',
                                                              style: AppStyles
                                                                  .inputAndDisplayTitleStyle
                                                                  .copyWith(
                                                                fontSize: 14,
                                                                color: AppColors
                                                                    .colorPrimaryExtraDark,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Text(
                                                                'Resend Otp',
                                                                style: AppStyles
                                                                    .loginScreensResendOtpTextStyle
                                                                    .copyWith(
                                                                  fontSize: 14,
                                                                  color: AppColors
                                                                      .colorPrimary,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: constraints
                                                                  .maxHeight *
                                                              0.02,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                    constraints
                                                                            .maxHeight *
                                                                        0.025,
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .colorPrimary,
                                                            ),
                                                            onPressed: () {},
                                                            child: const Text(
                                                              'Submit',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .colorWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  currentPageIndex == 1
                                      ? Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              onPressed: () {
                                                pageController.animateToPage(
                                                  0,
                                                  duration: const Duration(
                                                    milliseconds: 400,
                                                  ),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.chevron_left,
                                                size: 44,
                                                color: AppColors.colorPrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.2,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationLoadingState) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color.fromARGB(19, 0, 0, 0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.colorPrimary,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  IntrinsicHeight otpFields(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  enabled: otpFieldsEnabled,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.colorPrimary,
                  textAlign: TextAlign.center,
                  focusNode: focusNode1,
                  style: const TextStyle(
                    height: 1.5,
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(focusNode2);
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colorWhite,
                    hoverColor: AppColors.colorWhite,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintMaxLines: 1,
                  ),
                  controller: otpController1,
                ),
              ),
            ),
          ),
          SizedBox(
            width: otpFieldSpacing,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  enabled: otpFieldsEnabled,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.colorPrimary,
                  textAlign: TextAlign.center,
                  focusNode: focusNode2,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(focusNode3);
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNode1);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colorWhite,
                    hoverColor: AppColors.colorWhite,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintMaxLines: 1,
                  ),
                  controller: otpController2,
                ),
              ),
            ),
          ),
          SizedBox(
            width: otpFieldSpacing,
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 50,
              ),
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  enabled: otpFieldsEnabled,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.colorPrimary,
                  textAlign: TextAlign.center,
                  focusNode: focusNode3,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).requestFocus(focusNode4);
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNode2);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colorWhite,
                    hoverColor: AppColors.colorWhite,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintMaxLines: 1,
                  ),
                  controller: otpController3,
                ),
              ),
            ),
          ),
          SizedBox(
            width: otpFieldSpacing,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextFormField(
                  enabled: otpFieldsEnabled,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.colorPrimary,
                  textAlign: TextAlign.center,
                  focusNode: focusNode4,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).unfocus();
                      if (otpController1.text.isNotEmpty &&
                          otpController2.text.isNotEmpty &&
                          otpController3.text.isNotEmpty &&
                          otpController4.text.isNotEmpty) {}
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNode3);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.colorWhite,
                    hoverColor: AppColors.colorWhite,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintMaxLines: 1,
                  ),
                  controller: otpController4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validateMobileNumber(String value) {
    if (value.isEmpty) {
      return 'Mobile number is required!';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits long.';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Mobile number should be only digits.';
    }
    return null;
  }
}
