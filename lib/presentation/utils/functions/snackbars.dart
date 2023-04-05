import 'package:flutter/material.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

class SnackBars {
  static void sucessMessageSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.textColorGreen,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.check,
                color: AppColors.textColorGreen,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void errorMessageSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          height: 60,
          decoration: const BoxDecoration(
            color: AppColors.textColorRed,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.warning,
                color: AppColors.textColorRed,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
