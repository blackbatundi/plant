import 'package:animate_do/animate_do.dart';
import 'package:flow_projet/app/start/shared/utils/style.dart';
import 'package:flow_projet/app/start/views/start/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnouncePage extends StatefulWidget {
  static String routeName = "/anounce_screen";
  const AnouncePage({Key? key}) : super(key: key);

  @override
  State<AnouncePage> createState() => _AnouncePageState();
}

class _AnouncePageState extends State<AnouncePage> {
  PageController? _pageViewController;
  double longSpace = 30; // pour le grands espace
  double shortSpace = 10; // pour les distances courtes

  List<Map<String, dynamic>> starts = [
    {
      "image": "assets/svg/1.svg",
      "title": "Find the resultat of the disease of the plant",
      "subtitle": "lormpusm",
    },
    {
      "image": "assets/svg/2.svg",
      "title": "Consult the historic of disease in the app",
      "subtitle": "lormpusm",
    },
  ];

  int indexPage = 0;

  @override
  void initState() {
    _pageViewController = PageController()
      ..addListener(() {
        setState(() {
          if (_pageViewController!.page! >= 0 &&
              _pageViewController!.page! < 1) {
            indexPage = 0;
          } else if (_pageViewController!.page! >= 1 &&
              _pageViewController!.page! < 2) {
            indexPage = 1;
          }
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: FadeInDown(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageViewController,
                  children: List.generate(
                    2,
                    (index) => contents(
                        image: starts[index]['image'],
                        indexPage: index,
                        titleMessage: starts[index]['title'],
                        subtitleMessage: starts[index]["subtitle"]),
                  ),
                ),
              ),
              SizedBox(
                height: longSpace,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: index == indexPage
                          ? AppColors.PRIMARY_COLOR_DARK
                          : const Color(0xFFebebeb),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: longSpace,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: custormButtom(
                    color: AppColors.PRIMARY_COLOR_DARK,
                    title: "Next",
                    colorText: Colors.white,
                    onTap: () {
                      Navigator.pushNamed(context, StartPage.routeName);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //start announce page

  Widget contents({
    int? indexPage,
    required String image,
    required String titleMessage,
    required String subtitleMessage,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                image,
              ),
            ),
            SizedBox(
              height: longSpace,
            ),
            title(titleMessage),
            SizedBox(
              height: longSpace,
            ),
            subtitle(subtitleMessage),
          ],
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

  Widget title(String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget subtitle(String subtitle) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black54,
      ),
    );
  }
}
