import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/cubits/rawg_form_field_cubit.dart';

class RAWGFormField extends StatelessWidget {
  const RAWGFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.height = 80.0,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final int maxLines;
  final Widget? prefixIcon;
  final double height;

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
              style: AppFont.style(fontSize: 13, color: AppPalette.white),
            ),
            const SizedBox(height: 8),
            BlocBuilder<RAWGFormFieldCubit, RAWGFormFieldState>(
              builder: (context, state) {
                return TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: isPassword ? state.obscureText : false,
                  enabled: enabled,
                  maxLines: maxLines,
                  onChanged: onChanged,
                  style: AppFont.style(fontSize: 18.0, color: AppPalette.white),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppFont.style(
                      fontSize: 18.0,
                      color: AppPalette.gray1,
                    ),
                    filled: true,
                    fillColor: AppPalette.gray4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 16.0,
                    ),
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