import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/core/utils/show_snackbar.dart';
import 'package:rawg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_from_field.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  static const double signUpHeight = 423.0;
  static const double signInHeight = 327.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.errorMessage != current.errorMessage || previous.successMessage != current.successMessage || (previous.user == null && current.user != null),
      listener: (context, state) {
        if (state.errorMessage != null) {
          showSnackBar(context, state.errorMessage!);
        }

        if (state.successMessage != null) {
          context.pushReplacementNamed(RouteConstants.dashboard);
        }
      },
      child: Scaffold(
        backgroundColor: AppPalette.black2,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).padding.top + 8.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            state.currentTabIndex == 0 ? 'auth.signUpTitle'.tr() : 'auth.signInTitle'.tr(),
                            style: AppFont.style(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppPalette.white,
                            ),
                          ),
                          Text(
                            state.currentTabIndex == 0 ? 'auth.signUpSubtitle'.tr() : 'auth.signInSubtitle'.tr(),
                            style: AppFont.style(
                              fontSize: 14,
                              color: AppPalette.gray1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppPalette.gray6,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.0),
                        ),
                      ),
                      height: (state.currentTabIndex == 0 ? signUpHeight : signInHeight) + 48,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppPalette.gray4,
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: DefaultTabController(
                              length: 2,
                              initialIndex: state.currentTabIndex,
                              child: TabBar(
                                onTap: (index) => context.read<AuthCubit>().switchTab(index),
                                indicator: BoxDecoration(
                                  color: AppPalette.white,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Colors.transparent,
                                labelColor: AppPalette.black,
                                unselectedLabelColor: AppPalette.gray1,
                                labelStyle: AppFont.style(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                unselectedLabelStyle: AppFont.style(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                tabs: [
                                  Tab(text: 'auth.signUp'.tr()),
                                  Tab(text: 'auth.signIn'.tr()),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: state.currentTabIndex == 0 ? signUpHeight : signInHeight,
                            child: state.currentTabIndex == 0 ? buildSignUpForm(context, state) : buildSignInForm(context, state),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpForm(BuildContext context, AuthState state) {
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'auth.fullName'.tr(),
            hintText: 'auth.fullNameHint'.tr(),
            controller: cubit.nameController,
            enabled: !state.isLoading,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'auth.email'.tr(),
            hintText: 'auth.emailHint'.tr(),
            controller: cubit.emailController,
            keyboardType: TextInputType.emailAddress,
            enabled: !state.isLoading,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'auth.password'.tr(),
            hintText: 'auth.passwordHint'.tr(),
            controller: cubit.passwordController,
            isPassword: true,
            enabled: !state.isLoading,
          ),
          const SizedBox(height: 48.0),
          RAWGButton.elevated(
            label: 'auth.register'.tr(),
            isLoading: state.isLoading,
            onPressed: state.isSignUpFormValid && !state.isLoading ? () => cubit.signUp() : null,
            height: 55.0,
            backgroundColor: state.isSignUpFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
          ),
        ],
      ),
    );
  }

  Widget buildSignInForm(BuildContext context, AuthState state) {
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'auth.email'.tr(),
            hintText: 'auth.emailHint'.tr(),
            controller: cubit.signInEmailController,
            keyboardType: TextInputType.emailAddress,
            enabled: !state.isLoading,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'auth.password'.tr(),
            hintText: 'auth.passwordHint'.tr(),
            controller: cubit.signInPasswordController,
            isPassword: true,
            enabled: !state.isLoading,
          ),
          const SizedBox(height: 48.0),
          RAWGButton.elevated(
            label: 'auth.signIn'.tr(),
            isLoading: state.isLoading,
            onPressed: state.isSignInFormValid && !state.isLoading ? () => cubit.signIn() : null,
            height: 55.0,
            backgroundColor: state.isSignInFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
          ),
        ],
      ),
    );
  }
}