import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab_store/core/style/color_manager.dart';
import 'package:lab_store/presentation_layer/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/route_manager/app_routes.dart';
import '../../provider/auth/auth_provider.dart';
import '../../widgets/default_form_field.dart';
import '../../widgets/main_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackWidget(),
      ),
      backgroundColor: ColorManager.backGround,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 46.0, horizontal: 32.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  DefaultTextField(
                    controller: _nameController,
                    fNode: _nameFocusNode,
                    onComplete: () =>
                        FocusScope.of(context).requestFocus(_emailFocusNode),
                    inputType: TextInputType.name,
                    label: 'Name',
                    hint: 'Enter your Name',
                    validateMessage: 'Enter valid Name',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DefaultTextField(
                    controller: _emailController,
                    fNode: _emailFocusNode,
                    onComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    inputType: TextInputType.emailAddress,
                    label: 'Email',
                    hint: 'Enter your email',
                    validateMessage: 'Enter valid Email',
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DefaultTextField(
                    controller: _passwordController,
                    fNode: _passwordFocusNode,
                    inputType: TextInputType.visiblePassword,
                    label: 'Password',
                    hint: 'Enter your password',
                    validateMessage: 'Enter valid password',
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Row(
                    children: [
                      const Text('I already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.loginScreenRoute);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ColorManager.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  MainButton(
                    text: 'SIGN UP',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authProvider.signUpWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                            context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or sign up with social account',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              FontAwesomeIcons.google,
                              color: ColorManager.primary,
                            )),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(FontAwesomeIcons.facebookF,
                                color: ColorManager.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
