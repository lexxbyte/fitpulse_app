import 'package:fitpulse_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:fitpulse_app/components/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../components/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Deklaracija formKey-a za pristup podacima forme
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash_fill;
  bool signUpRequired = false;
  //Deklaracija provere sifre(da li sadrzi veliko slovo, malo slovo, broj i specijalni znak, i odredjenu duzinu)
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProccess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          return; 
        }
      },
      child: Form(
          //GlobalKey koristimo za pristup podacima forme
          key: _formKey,
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    //Controller koristimo za pristup unetim podacima
                    controller: emailController,
                    hint: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    //Validator koristimo za proveru unetih podataka
                    validator: (value) {
                      //Znak uzvika stavljamo da bi dartu rekli da je value sigurno razlicito od null
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailRexExp.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      //Ovde vracamo null ako je sve ok
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
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  onChanged: (value) {
                    if (value!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (value.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (value.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (value.contains(specialCharRegExp)) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if (value.length >= 8) {
                      setState(() {
                        contains8Length = true;
                      });
                    } else {
                      setState(() {
                        contains8Length = false;
                      });
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
                    icon: Icon(iconPassword),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (!passwordRexExp.hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Password must contain: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  if (containsUpperCase)
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.green,
                    ),
                  if (!containsUpperCase)
                    const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                  if (containsLowerCase)
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.green,
                    ),
                  if (!containsLowerCase)
                    const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                  if (containsNumber)
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.green,
                    ),
                  if (!containsNumber)
                    const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                  if (containsSpecialChar)
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.green,
                    ),
                  if (!containsSpecialChar)
                    const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                  if (contains8Length)
                    const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.green,
                    ),
                  if (!contains8Length)
                    const Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: Colors.red,
                    ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: nameController,
                  hint: 'Username',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(CupertinoIcons.person_fill),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    } else if (value.length < 3) {
                      return 'Username is too short';
                    } else if (value.length > 20) {
                      return 'Username is too long';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              !signUpRequired
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            MyUser myUser = MyUser.empty;
                            myUser = myUser.copyWith(
                              email: emailController.text,
                              username: nameController.text,
                            );

                            setState(() {
                              context.read<SignUpBloc>().add(SignUpRequired(
                                  user: myUser,
                                  password: passwordController.text));
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 10.0),
              const Text('or', style: TextStyle(fontSize: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                     IconButton(
                  onPressed: () {
                    context.read<SignUpBloc>().add(SignUpWithGoogleSignIn());
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
              )
            ],
          ),
          ),
          ),
    );
  }
}
