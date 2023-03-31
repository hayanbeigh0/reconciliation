import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reconciliation/utils/colors/app_colors.dart';
import 'package:reconciliation/utils/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.isLoading,
    this.enabled = true,
  }) : super(key: key);

  final VoidCallback onTap;
  final String buttonText;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading && !enabled ? null : onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        backgroundColor: AppColors.colorPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonText,
              style: AppStyles.primaryButtonTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            isLoading
                ? const Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.colorWhite,
                        ),
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/arrowright.svg',
                    width: constraints.maxWidth > 600 ? 16 : 20,
                  ),
          ],
        );
      }),
    );
  }
}
