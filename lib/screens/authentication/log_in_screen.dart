import 'package:fitpulse_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:fitpulse_app/components/strings.dart';
import 'package:fitpulse_app/components/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;
  bool signInRequired = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInBloc, LogInState>(
      listener: (context, state) {
        if(state is LogInSuccess){
          setState(() {
            signInRequired = false;
          });
        } else if (state is LogInProccess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is LogInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: Form(
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
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  errorMsg: _errorMsg,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRexExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: passwordController,
                hint: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                errorMsg: _errorMsg,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (!passwordRexExp.hasMatch(value)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                sufixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if (obscurePassword) {
                        iconPassword = CupertinoIcons.eye_fill;
                      } else {
                        iconPassword = CupertinoIcons.eye_slash_fill;
                      }
                    });
                  },
                  icon: Icon(
                    iconPassword,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            !signInRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LogInBloc>().add(
                                LogInRequired(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ))
                : CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            const SizedBox(height: 30.0),
            TextButton(
              onPressed: () {
                //TODO: Forgot Password
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //IconButton for Google Sign In
              children: [
                IconButton(
                  onPressed: () {
                    context.read<LogInBloc>().add(const LogInGoogleSignInRequired());
                  },
                  icon: Image.asset(
                    'lib/assets/images/google_button.png',
                    height: 70.0,
                  ),
                ),
                //IconButton for Apple Sign In
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/images/apple_button.png',
                    height: 70.0,
                  ),
                ),
                //IconButton for Instagram Sign In
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'lib/assets/images/instagram_button.png',
                    height: 70.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
