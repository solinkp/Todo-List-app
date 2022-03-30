import 'package:flutter/material.dart';

import 'package:todo/todo/todo.dart';
import 'package:todo/widgets/submit_button.dart';
import 'package:todo/signin/signin_service.dart';
import 'package:todo/utils/string_extensions.dart';
import 'package:todo/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    key: Key('email'),
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    textController: _emailController,
                    icon: Icons.email,
                    validator: (value) => value?.validateEmail(context),
                  ),
                  CustomTextField(
                    key: Key('password'),
                    keyboardType: TextInputType.text,
                    labelText: 'Password',
                    textController: _passwordController,
                    last: true,
                    obscured: true,
                    icon: Icons.lock,
                    validator: (value) => value?.validateEmpty(context),
                  ),
                  SizedBox(height: 20.0),
                  SubmitButton(
                    onPressed: _signIn,
                    text: 'Sign In',
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setLoading();
      await Future.delayed(Duration(seconds: 1), () {
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();
        if (SignInService().signIn(email, password)) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TodoList()),
            (Route<dynamic> route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid credentials'),
          ));
        }
        setLoading();
      });
    }
  }

  void setLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
}
