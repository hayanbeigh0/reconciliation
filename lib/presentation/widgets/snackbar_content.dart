import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';

class SnackbarContent extends StatelessWidget {
  final String message;
  final Color color;
  final Icon icon;
  const SnackbarContent(
      {super.key,
      required this.message,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          icon,
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
    );
  }
}
