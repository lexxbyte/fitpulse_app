import 'package:fitpulse_app/screens/authentication/log_in_screen.dart';
import 'package:fitpulse_app/screens/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Image.asset('lib/assets/images/background.png'
          ,fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,),
            SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.13,
              //left: MediaQuery.of(context).size.width * 0.1,
              //right: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              children: [
                Image.asset('lib/assets/images/fitpulselogo.png'),
                TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  controller: tabController,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  labelColor: Theme.of(context).colorScheme.tertiary,
                  tabs: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      LogInScreen(),
                      SignUpScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
        ],
      ),
    );
  }
}
