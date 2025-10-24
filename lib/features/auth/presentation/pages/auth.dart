import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_button.dart';
import 'package:rawg/features/common/presentation/widgets/rawg_from_field.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupHeight = 399.0;
    final loginHeight = 303.0;

    return Scaffold(
      backgroundColor: AppPalette.black2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 8.0),
                const SizedBox(height: 24.0),
                Text(
                  _tabController.index == 0
                      ? 'Create your personal account of games'
                      : 'Welcome back! Sign in to continue',
                  style: AppFont.style(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white,
                  ),
                ),
                Text(
                  _tabController.index == 0
                      ? 'Join us today to unlock personalized features and tools.'
                      : 'Access your account and continue where you left off.',
                  style: AppFont.style(fontSize: 14, color: AppPalette.gray1),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
          Container(
            decoration: const BoxDecoration(
              color: AppPalette.gray6,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            height:
                (_tabController.index == 0 ? signupHeight : loginHeight) + 48,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppPalette.gray4,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    onTap: (_) => setState(() {}),
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
                SizedBox(
                  height: (_tabController.index == 0
                      ? signupHeight
                      : loginHeight),
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [buildSignUpForm(), buildLoginForm()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignUpForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'Full Name',
            hintText: 'Wade Warren',
            controller: _nameController,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Password',
            hintText: '••••••••',
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          RAWGButton.elevated(
            label: 'Register',
            onPressed: () => context.pushNamed(RouteConstants.dashboard),
            height: 55.0,
            backgroundColor: AppPalette.black2,
          ),
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RAWGFormField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          RAWGFormField(
            label: 'Password',
            hintText: '••••••••',
            controller: _loginPasswordController,
            isPassword: true,
          ),
          const SizedBox(height: 24),
          RAWGButton.elevated(
            label: 'Login',
            onPressed: () {},
            height: 55.0,
            backgroundColor: AppPalette.black2,
          ),
        ],
      ),
    );
  }
}