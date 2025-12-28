import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/cubits/rawg_form_field_cubit.dart';

class RAWGFormField extends StatelessWidget {
  final bool enabled;
  final bool isPassword;
  final double height;
  final int maxLines;
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const RAWGFormField({
    super.key,
    this.enabled = true,
    this.isPassword = false,
    this.height = 80.0,
    this.maxLines = 1,
    required this.hintText,
    required this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RAWGFormFieldCubit()..setObscureText(isPassword),
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppFont.style(fontSize: 13.0, color: AppPalette.white),
            ),
            const SizedBox(height: 8.0),
            BlocBuilder<RAWGFormFieldCubit, RAWGFormFieldState>(
              builder: (context, state) {
                return TextField(
                  controller: controller,
                  enabled: enabled,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  obscureText: isPassword ? state.obscureText : false,
                  onChanged: onChanged,
                  style: AppFont.style(fontSize: 18.0, color: AppPalette.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 16.0,
                    ),
                    filled: true,
                    fillColor: AppPalette.gray4,
                    hintStyle: AppFont.style(
                      fontSize: 18.0,
                      color: AppPalette.gray1,
                    ),
                    hintText: hintText,
                    prefixIcon: prefixIcon,
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(
                              state.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppPalette.gray3,
                              size: 20.0,
                            ),
                            onPressed: () => context.read<RAWGFormFieldCubit>().toggleObscureText(),
                          )
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}