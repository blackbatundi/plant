import 'package:flow_projet/app/start/shared/utils/style.dart';
import 'package:flow_projet/app/start/views/start/anounce_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasStarted = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        hasStarted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.TRANSPARENT,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.TRANSPARENT,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/trans_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.50),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                      width: 150,
                    ),
                    appName(),
                    slogant(),
                  ],
                ),
              ),
            ),

            /// It's an animation that moves the icon from the top of the screen to the center of the
            /// screen.
            AnimatedPositioned(
              duration: const Duration(seconds: 5),
              onEnd: () {
                Navigator.pushReplacementNamed(context, AnouncePage.routeName);
              },
              curve: Curves.bounceOut,
              top: hasStarted
                  ? MediaQuery.of(context).size.height / 2 - 150
                  : -200,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: icon(),
            ),
          ],
        ),
      ),
    );
  }
//here is our bg

//here is our slogant

  Widget appName() {
    return const Text.rich(
      TextSpan(
        text: "Plant ",
        style: TextStyle(
          fontSize: 24,
          color: AppColors.PRIMARY_COLOR_DARK,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "App",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

//here is our slogant

  Widget slogant() {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        "The protection of nature is our priority",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

// here we create our splash's image
  Widget icon() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      height: 150,
      width: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/log.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
