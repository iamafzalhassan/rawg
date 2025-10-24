import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rawg/core/constants/route_constants.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';

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

  bool _obscurePassword = true;
  bool _obscureLoginPassword = true;

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
                      ? 'Create your personal account'
                      : 'Welcome back! Sign in to continue',
                  style: AppFont.style(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.white,
                  ),
                ),
                const SizedBox(height: 12.0),
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
          LabeledTextField(
            label: 'Full Name',
            hintText: 'Wade Warren',
            controller: _nameController,
          ),
          const SizedBox(height: 16),
          LabeledTextField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          PasswordField(
            label: 'Password',
            controller: _passwordController,
            obscureText: _obscurePassword,
            toggleVisibility: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
          const SizedBox(height: 24),
          StyledButton(
            label: 'Register',
            onPressed: () => context.pushNamed(RouteConstants.dashboard),
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
          LabeledTextField(
            label: 'Email',
            hintText: 'wadewarren@gmail.com',
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          PasswordField(
            label: 'Password',
            controller: _loginPasswordController,
            obscureText: _obscureLoginPassword,
            toggleVisibility: () {
              setState(() => _obscureLoginPassword = !_obscureLoginPassword);
            },
          ),
          const SizedBox(height: 24),
          StyledButton(label: 'Login', onPressed: () {}),
        ],
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const LabeledTextField({
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppFont.style(fontSize: 13, color: AppPalette.white),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppFont.style(fontSize: 18.0, color: AppPalette.black),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppFont.style(fontSize: 18.0, color: AppPalette.gray1),
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
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback toggleVisibility;

  const PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.toggleVisibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppFont.style(fontSize: 13, color: AppPalette.white),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: AppFont.style(fontSize: 18.0, color: AppPalette.black),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: AppFont.style(fontSize: 18.0, color: AppPalette.gray1),
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
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppPalette.gray3,
                  size: 20.0,
                ),
                onPressed: toggleVisibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const StyledButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.black2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: AppFont.style(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppPalette.white,
          ),
        ),
      ),
    );
  }
}