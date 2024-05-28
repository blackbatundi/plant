import 'package:flow_projet/app/start/shared/utils/style.dart';
import 'package:flow_projet/app/views/scanner_plant/views/tensorflow_teste.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';

class StartPage extends StatefulWidget {
  static String routeName = "/start_page";
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.TRANSPARENT,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: FadeInDown(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: stackElement(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      appName(),
                      slogant(),
                      message(),
                      custormButtom(
                          color: Colors.white,
                          colorText: AppColors.PRIMARY_COLOR_DARK,
                          title: "Join us.",
                          onTap: () {
                            Navigator.pushNamed(
                                context, TensorFlowTest.routeName);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  stackElement() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.3 - 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(140),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppColors.BLACK_COLOR.withOpacity(.10),
                    offset: const Offset(0, 13),
                    blurRadius: 5),
              ],
              image: const DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.3 - 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    offset: const Offset(0, 5),
                    blurRadius: 5),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(140),
              ),
              color: AppColors.BLACK_COLOR.withOpacity(
                .5,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.3 - 125,
            left: MediaQuery.of(context).size.width / 2 - 82.5,
            child: icon(),
          ),
        ],
      ),
    );
  }

  Widget icon() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        margin: const EdgeInsets.all(6.15),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              offset: const Offset(0, -5),
              blurRadius: 15,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(25),
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/log.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  //here is our app name
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
              color: Colors.black,
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
          color: Colors.black,
        ),
      ),
    );
  }
//here is our slogant

  Widget message() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Text(
        "To fully benefit from the potential offered by Plant App, join us.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  custormButtom({
    Color? color,
    String? title,
    Color? colorText,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(
          15,
        ),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(.15),
                offset: const Offset(0, 5),
                blurRadius: 5),
          ],
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Text(
          "$title",
          style: TextStyle(
            color: colorText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
