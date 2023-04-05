import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

class AppStyles {
  static TextStyle errorTextStyle = const TextStyle(
    color: AppColors.textColorRed,
    fontFamily: 'LexendDeca',
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static TextStyle primaryTextFieldHintStyle = const TextStyle(
    overflow: TextOverflow.fade,
    color: AppColors.textColorLight,
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.1,
  );
  static TextStyle dropdownTextStyle = const TextStyle(
    overflow: TextOverflow.fade,
    color: AppColors.colorPrimaryExtraDark,
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.1,
  );
  static TextStyle loginScreensInputFieldTitleTextStyle = const TextStyle(
    color: AppColors.colorPrimaryExtraDark,
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static TextStyle loginScreensResendOtpTextStyle = const TextStyle(
    color: AppColors.textColorRed,
    fontFamily: 'LexendDeca',
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static TextStyle primaryButtonTextStyle = const TextStyle(
    color: AppColors.colorWhite,
    fontFamily: 'LexendDeca',
    fontWeight: FontWeight.w500,
  );
  static TextStyle secondaryButtonTextStyle = const TextStyle(
    color: AppColors.colorPrimary,
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle inputAndDisplayTitleStyle = const TextStyle(
    color: AppColors.colorPrimary,
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle primaryTextFieldStyle = const TextStyle(
    color: AppColors.colorPrimary,
    fontFamily: 'LexendDeca',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle primaryTextFieldStyle2 = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontFamily: 'LexendDeca',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
