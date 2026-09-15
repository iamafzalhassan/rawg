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

class Auth extends StatefulWidget {
  const Auth({super.key});

  static const double signInHeight = 327.0;
  static const double signUpHeight = 423.0;

  @override
  State<Auth> createState() => AuthPageState();
}

class AuthPageState extends State<Auth> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController = TextEditingController();

  void validateSignUpForm() => context.read<AuthCubit>().validateSignUpForm(email: emailController.text, name: nameController.text, password: passwordController.text);

  void validateSignInForm() => context.read<AuthCubit>().validateSignInForm(email: signInEmailController.text, password: signInPasswordController.text);

  Widget buildSignUpForm(AuthState state) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RAWGFormField(controller: nameController, enabled: !state.isLoading, hintText: 'auth.fullNameHint'.tr(), label: 'auth.fullName'.tr()),
        const SizedBox(height: 16.0),
        RAWGFormField(controller: emailController, enabled: !state.isLoading, hintText: 'auth.emailHint'.tr(), keyboardType: TextInputType.emailAddress, label: 'auth.email'.tr()),
        const SizedBox(height: 16.0),
        RAWGFormField(controller: passwordController, enabled: !state.isLoading, hintText: 'auth.passwordHint'.tr(), isPassword: true, label: 'auth.password'.tr()),
        const SizedBox(height: 48.0),
        RAWGButton.elevated(
          backgroundColor: state.isSignUpFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
          isLoading: state.isLoading,
          label: 'auth.register'.tr(),
          onPressed: state.isSignUpFormValid && !state.isLoading ? signUp : null,
        ),
      ],
    ),
  );

  void signUp() => context.read<AuthCubit>().signUp(email: emailController.text, name: nameController.text, password: passwordController.text);

  Widget buildSignInForm(AuthState state) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RAWGFormField(controller: signInEmailController, enabled: !state.isLoading, hintText: 'auth.emailHint'.tr(), keyboardType: TextInputType.emailAddress, label: 'auth.email'.tr()),
        const SizedBox(height: 16.0),
        RAWGFormField(controller: signInPasswordController, enabled: !state.isLoading, hintText: 'auth.passwordHint'.tr(), isPassword: true, label: 'auth.password'.tr()),
        const SizedBox(height: 48.0),
        RAWGButton.elevated(
          backgroundColor: state.isSignInFormValid && !state.isLoading ? AppPalette.black2 : AppPalette.gray6,
          isLoading: state.isLoading,
          label: 'auth.signIn'.tr(),
          onPressed: state.isSignInFormValid && !state.isLoading ? signIn : null,
        ),
      ],
    ),
  );

  void signIn() => context.read<AuthCubit>().signIn(email: signInEmailController.text, password: signInPasswordController.text);

  void clearFields() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    signInEmailController.clear();
    signInPasswordController.clear();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateSignUpForm);
    nameController.addListener(validateSignUpForm);
    passwordController.addListener(validateSignUpForm);
    signInEmailController.addListener(validateSignInForm);
    signInPasswordController.addListener(validateSignInForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    signInEmailController.dispose();
    signInPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
    listener: (context, state) {
      if (state.errorMessage != null) {
        showSnackBar(state.errorMessage!, context);
      }

      if (state.successMessage != null) {
        clearFields();
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
                        SizedBox(height: MediaQuery.of(context).padding.top + 8.0),
                        const SizedBox(height: 24.0),
                        Text(
                          state.currentTabIndex == 0 ? 'auth.signUpTitle'.tr() : 'auth.signInTitle'.tr(),
                          style: AppFont.style(color: AppPalette.white, fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                        Text(state.currentTabIndex == 0 ? 'auth.signUpSubtitle'.tr() : 'auth.signInSubtitle'.tr(), style: AppFont.style(color: AppPalette.gray1, fontSize: 14.0)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
                      color: AppPalette.gray6,
                    ),
                    height: (state.currentTabIndex == 0 ? Auth.signUpHeight : Auth.signInHeight) + 48,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.0), color: AppPalette.gray4),
                          child: DefaultTabController(
                            initialIndex: state.currentTabIndex,
                            length: 2,
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicator: BoxDecoration(borderRadius: BorderRadius.circular(24.0), color: AppPalette.white),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: AppPalette.black,
                              labelStyle: AppFont.style(fontSize: 16.0, fontWeight: FontWeight.w600),
                              onTap: (index) => context.read<AuthCubit>().switchTab(index),
                              tabs: [
                                Tab(text: 'auth.signUp'.tr()),
                                Tab(text: 'auth.signIn'.tr()),
                              ],
                              unselectedLabelColor: AppPalette.gray1,
                              unselectedLabelStyle: AppFont.style(fontSize: 16.0, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        SizedBox(height: state.currentTabIndex == 0 ? Auth.signUpHeight : Auth.signInHeight, child: state.currentTabIndex == 0 ? buildSignUpForm(state) : buildSignInForm(state)),
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
