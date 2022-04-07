import 'package:flutter/material.dart';
import 'package:mvvm/app/di.dart';
import 'package:mvvm/presentation/register/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _registerViewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }

  void _bind() {
    _registerViewModel.start();
    _nameController.addListener(() {
      _registerViewModel.setUserName(_nameController.text.trim());
    });
    _passwordController.addListener(() {
      _registerViewModel.setPassword(_passwordController.text.trim());
    });
    _emailController.addListener(() {
      _registerViewModel.setEmail(_emailController.text.trim());
    });
    _mobileController.addListener(() {
      _registerViewModel.setMobileNumber(_mobileController.text.trim());
    });
  }
}
