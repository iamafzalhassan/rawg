import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/auth/cubits/auth_cubit.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_from_field.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  static const double signUpHeight = 399.0;
  static const double signInHeight = 303.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          state.currentTabIndex == 0 ? 'Create your personal account of games' : 'Welcome back! Sign in to continue',
                          style: AppFont.style(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppPalette.white,
                          ),
                        ),
                        Text(
                          state.currentTabIndex == 0 ? 'Join us today to unlock personalized features and tools.' : 'Access your account and continue where you left off.',
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
                              tabs: const [
                                Tab(text: 'Sign Up'),
                                Tab(text: 'Sign In'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: state.currentTabIndex == 0 ? signUpHeight : signInHeight,
                          child: state.currentTabIndex == 0 ? buildSignUpForm(context) : buildLoginForm(context),
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
    );
  }

  Widget buildSignUpForm(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'Full Name',
            hintText: 'Wade Warren',
            controller: cubit.nameController,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: cubit.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Password',
            hintText: '••••••••',
            controller: cubit.passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          RAWGButton.elevated(
            label: 'Register',
            onPressed: () {
              cubit.signUp();
              context.pushNamed(RouteConstants.dashboard);
            },
            height: 55.0,
            backgroundColor: AppPalette.black2,
          ),
        ],
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: cubit.signInEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Password',
            hintText: '••••••••',
            controller: cubit.signInPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          RAWGButton.elevated(
            label: 'Login',
            onPressed: () {
              cubit.signIn();
              context.pushNamed(RouteConstants.dashboard);
            },
            height: 55.0,
            backgroundColor: AppPalette.black2,
          ),
        ],
      ),
    );
  }
}