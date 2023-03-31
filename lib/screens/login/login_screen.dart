import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reconciliation/screens/home/add_task_screen.dart';

import 'package:reconciliation/utils/colors/app_colors.dart';
import 'package:reconciliation/utils/styles/app_styles.dart';
import 'package:reconciliation/widgets/primary_text_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _mobileNumberController = TextEditingController();
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final TextEditingController otpController1 = TextEditingController();

  final TextEditingController otpController2 = TextEditingController();

  final TextEditingController otpController3 = TextEditingController();

  final TextEditingController otpController4 = TextEditingController();

  FocusNode focusNode1 = FocusNode();

  FocusNode focusNode2 = FocusNode();

  FocusNode focusNode3 = FocusNode();

  FocusNode focusNode4 = FocusNode();

  final double otpFieldSpacing = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 26,
                                  color: AppColors.colorSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.04,
                              ),
                              const Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.colorPrimaryExtraDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.005,
                              ),
                              SizedBox(
                                height: 80,
                                child: PrimaryTextField(
                                  fieldValidator: (p0) => validateMobileNumber(
                                    p0.toString(),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  title: '',
                                  hintText: '999 888 7777',
                                  textEditingController:
                                      _mobileNumberController,
                                ),
                              ),
                              Text(
                                "Enter OTP",
                                style: AppStyles
                                    .loginScreensInputFieldTitleTextStyle,
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.005,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor: AppColors.colorPrimary,
                                            textAlign: TextAlign.center,
                                            focusNode: focusNode1,
                                            style: const TextStyle(
                                              height: 1.5,
                                            ),
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode2);
                                              }
                                              if (value.isEmpty) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.colorWhite,
                                              hoverColor: AppColors.colorWhite,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor: AppColors.colorPrimary,
                                            textAlign: TextAlign.center,
                                            focusNode: focusNode2,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode3);
                                              }
                                              if (value.isEmpty) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode1);
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.colorWhite,
                                              hoverColor: AppColors.colorWhite,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor: AppColors.colorPrimary,
                                            textAlign: TextAlign.center,
                                            focusNode: focusNode3,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode4);
                                              }
                                              if (value.isEmpty) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode2);
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.colorWhite,
                                              hoverColor: AppColors.colorWhite,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            cursorColor: AppColors.colorPrimary,
                                            textAlign: TextAlign.center,
                                            focusNode: focusNode4,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                if (otpController1.text.isNotEmpty &&
                                                    otpController2
                                                        .text.isNotEmpty &&
                                                    otpController3
                                                        .text.isNotEmpty &&
                                                    otpController4
                                                        .text.isNotEmpty) {
                                                  // Navigator.of(context)
                                                  //     .pushNamed(
                                                  //   HomeScreen.routeName,
                                                  // );
                                                }
                                              }
                                              if (value.isEmpty) {
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode3);
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                            ],
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.colorWhite,
                                              hoverColor: AppColors.colorWhite,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Didn\'t receive the OTP?',
                                    style: AppStyles.inputAndDisplayTitleStyle
                                        .copyWith(
                                      fontSize: 14,
                                      color: AppColors.colorPrimaryExtraDark,
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
                                        color: AppColors.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.06,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.025,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: AppColors.colorPrimary,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => AddTaskScreen(),
                                      ));
                                    } else {
                                      log('Error');
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: AppColors.colorWhite,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.04,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
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
