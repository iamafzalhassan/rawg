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

  static const double signInHeight = 327.0;
  static const double signUpHeight = 423.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          showSnackBar(context, state.errorMessage!);
        }

        if (state.successMessage != null) {
          context.pushReplacementNamed(RouteConstants.dashboard);
        }
      },
      listenWhen: (previous, current) => previous.errorMessage != current.errorMessage || previous.successMessage != current.successMessage || (previous.user == null && current.user != null),
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
                              fontSize: 28.0,
                              color: AppPalette.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.currentTabIndex == 0 ? 'auth.signUpSubtitle'.tr() : 'auth.signInSubtitle'.tr(),
                            style: AppFont.style(
                              fontSize: 14.0,
                              color: AppPalette.gray1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.0),
                        ),
                        color: AppPalette.gray6,
                      ),
                      height: (state.currentTabIndex == 0 ? signUpHeight : signInHeight) + 48,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: AppPalette.gray4,
                            ),
                            child: DefaultTabController(
                              initialIndex: state.currentTabIndex,
                              length: 2,
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: AppPalette.white,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: AppPalette.black,
                                labelStyle: AppFont.style(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                onTap: (index) => context.read<AuthCubit>().switchTab(index),
                                tabs: [
                                  Tab(text: 'auth.signUp'.tr()),
                                  Tab(text: 'auth.signIn'.tr()),
                                ],
                                unselectedLabelColor: AppPalette.gray1,
                                unselectedLabelStyle: AppFont.style(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            controller: cubit.nameController,
            enabled: !state.isLoading,
            hintText: 'auth.fullNameHint'.tr(),
            label: 'auth.fullName'.tr(),
          ),
          const SizedBox(height: 16.0),
          RAWGFormField(
            controller: cubit.emailController,
            enabled: !state.isLoading,
            hintText: 'auth.emailHint'.tr(),
            keyboardType: TextInputType.emailAddress,
            label: 'auth.email'.tr(),
          ),
          const SizedBox(height: 16.0),
          RAWGFormField(
            controller: cubit.passwordController,
            enabled: !state.isLoading,
            hintText: 'auth.passwordHint'.tr(),
            isPassword: true,
            label: 'auth.password'.tr(),
          ),
          const SizedBox(height: 48.0),
          RAWGButton.elevated(
            backgroundColor: state.isSignUpFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
            isLoading: state.isLoading,
            label: 'auth.register'.tr(),
            onPressed: state.isSignUpFormValid && !state.isLoading ? () => cubit.signUp() : null,
          ),
        ],
      ),
    );
  }

  Widget buildSignInForm(BuildContext context, AuthState state) {
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            controller: cubit.signInEmailController,
            enabled: !state.isLoading,
            hintText: 'auth.emailHint'.tr(),
            keyboardType: TextInputType.emailAddress,
            label: 'auth.email'.tr(),
          ),
          const SizedBox(height: 16.0),
          RAWGFormField(
            controller: cubit.signInPasswordController,
            enabled: !state.isLoading,
            hintText: 'auth.passwordHint'.tr(),
            isPassword: true,
            label: 'auth.password'.tr(),
          ),
          const SizedBox(height: 48.0),
          RAWGButton.elevated(
            backgroundColor: state.isSignInFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
            isLoading: state.isLoading,
            label: 'auth.signIn'.tr(),
            onPressed: state.isSignInFormValid && !state.isLoading ? () => cubit.signIn() : null,
          ),
        ],
      ),
    );
  }
}