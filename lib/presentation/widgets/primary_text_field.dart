import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reconciliation/presentation/utils/colors/app_colors.dart';
import 'package:reconciliation/presentation/utils/styles/app_styles.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.suffixIcon = const SizedBox(),
    this.maxLines = 1,
    required this.textEditingController,
    this.fieldValidator,
    this.focusNode,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.enabled = true,
  });
  final String title;
  final String hintText;
  final Widget suffixIcon;
  final int maxLines;
  final bool enabled;

  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  // final String fieldValidator;
  final String? Function(String?)? fieldValidator;
  final void Function(String?)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == ''
            ? const SizedBox()
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.colorPrimaryExtraDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        Column(
          children: [
            TextFormField(
              onFieldSubmitted: onFieldSubmitted,
              focusNode: focusNode,
              maxLines: maxLines,
              style: AppStyles.primaryTextFieldStyle2,
              inputFormatters: inputFormatters,
              controller: textEditingController,
              enabled: enabled,
              validator: fieldValidator,
              decoration: InputDecoration(
                hoverColor: AppColors.colorWhite,
                filled: true,
                fillColor: enabled
                    ? AppColors.colorWhite
                    : AppColors.colorDisabledTextField,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                hintMaxLines: maxLines,
                errorStyle: AppStyles.errorTextStyle,
                hintStyle: AppStyles.primaryTextFieldHintStyle,
                suffixIcon: suffixIcon,
              ),
            ),
            !enabled
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(43, 0, 0, 0),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
