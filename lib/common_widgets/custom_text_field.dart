
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback? ontap;
  final bool enabled;
  final bool showEndText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final double? width;
  final TextInputType inputType;

  final bool isMarginAvailabl;
  final Widget? prefixIcon;
  final bool onsecureText;
  TextInputAction? textInputAction;

  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  List<BoxShadow>? boxShadow;
  bool readOnly;
  bool isFilled;
  int? maxLines;
  int? maxLength;
  final Iterable<String>? autofillHints;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    super.key,
    this.width,
    this.inputType = TextInputType.text,
    required this.onChanged,
    this.controller,
    required this.hintText,
    this.isMarginAvailabl = true,
    this.showEndText = false,
    this.prefixIcon,
    this.label = "",
    this.enabled = true,
    this.ontap,
    this.focusNode,
    this.onsecureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.boxShadow,
    this.readOnly = false,
    this.isFilled = true,
    this.maxLines = 1,
    this.maxLength,
    this.autofillHints,
    this.validator,
    this.textInputAction,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: isMarginAvailabl ? 0 : 20),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  child: Row(
                    children: [
                      Text(
                        label,
                        // style: context.textTheme.headlineSmall?.copyWith(fontSize: 14),
                      ),
                      const Spacer(),
                      showEndText
                          ? Text(
                              "Max 30 words",
                              // style: context.textTheme.headlineSmall
                                  // ?.copyWith(fontSize: 12,  color: const Color(0xffB2B2B2)),
                            )
                          : const SizedBox()
                    ],
                  ),
                )
              : const SizedBox(),
          TextFormField(
            validator: validator,
            onTapOutside: (event) {
              // logs(event);
              // FocusManager.instance.primaryFocus?.unfocus();
            },
            readOnly: readOnly,
            autofillHints: autofillHints,
            textInputAction: textInputAction,
            obscureText: onsecureText,
            focusNode: focusNode,
            onTap: ontap,
            enabled: enabled,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            controller: controller,
            onChanged: (value) {
              onChanged(value);
            },
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
              counterText: "",
                //  filled: true,
                        fillColor: Colors.grey.shade200,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: isFilled,
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 7),

                 border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
