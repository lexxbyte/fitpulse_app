import 'package:fitpulse_app/components/strings.dart';
import 'package:fitpulse_app/components/textfield.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                  controller: emailController,
                  hint: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email, color: Theme.of(context).colorScheme.tertiary,),
                  errorMsg: _errorMsg,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRexExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
            )
          ],
        ));
  }
}
