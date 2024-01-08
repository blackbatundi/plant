import 'package:animate_do/animate_do.dart';
import 'package:flow_projet/app/start/shared/utils/style.dart';
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
                    title: "Start",
                    colorText: Colors.white,
                    onTap: () {
                      //  Navigator.pushNamed(context, StartPage.routeName);
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






// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';

// ///Class to hold data for itembuilder in Withbuilder app.
// class ItemData {
//   final Color color;
//   final String image;
//   final String text1;
//   final String text2;
//   final String text3;

//   ItemData(this.color, this.image, this.text1, this.text2, this.text3);
// }

// /// Example of LiquidSwipe with itemBuilder
// class AnouncePage extends StatefulWidget {
//   static String routeName = "/Annouce";
//   const AnouncePage({super.key});

//   @override
//   _AnouncePage createState() => _AnouncePage();
// }

// class _AnouncePage extends State<AnouncePage> {
//   int page = 0;
//   late LiquidController liquidController;
//   late UpdateType updateType;

//   List<ItemData> data = [
//     ItemData(Colors.blue, "assets/1.png", "Hi", "It's Me", "Sahdeep"),
//     ItemData(Colors.deepPurpleAccent, "assets/1.png", "Take a", "Look At",
//         "Liquid Swipe"),
//     ItemData(Colors.green, "assets/1.png", "Liked?", "Fork!", "Give Star!"),
//     ItemData(Colors.yellow, "assets/1.png", "Can be", "Used for",
//         "Onboarding design"),
//     ItemData(
//         Colors.pink, "assets/1.png", "Example", "of a page", "with Gesture"),
//     ItemData(Colors.red, "assets/1.png", "Do", "try it", "Thank you"),
//   ];

//   @override
//   void initState() {
//     liquidController = LiquidController();
//     super.initState();
//   }

//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((page) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (2.0 - 1.0) * selectedness;
//     return SizedBox(
//       width: 25.0,
//       child: Center(
//         child: Material(
//           color: Colors.white,
//           type: MaterialType.circle,
//           child: SizedBox(
//             width: 8.0 * zoom,
//             height: 8.0 * zoom,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             LiquidSwipe.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: double.infinity,
//                   color: data[index].color,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Image.asset(
//                         data[index].image,
//                         height: 300,
//                         fit: BoxFit.contain,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(index != 4 ? 24.0 : 0),
//                       ),
//                       index == 4
//                           ? const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 70.0),
//                               child: ExampleSlider(),
//                             )
//                           : const SizedBox.shrink(),
//                       Column(
//                         children: <Widget>[
//                           Text(
//                             data[index].text1,
//                             style: WithPages.style,
//                           ),
//                           Text(
//                             data[index].text2,
//                             style: WithPages.style,
//                           ),
//                           Text(
//                             data[index].text3,
//                             style: WithPages.style,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               positionSlideIcon: 0.8,
//               slideIconWidget: const Icon(Icons.arrow_back_ios),
//               onPageChangeCallback: pageChangeCallback,
//               waveType: WaveType.liquidReveal,
//               liquidController: liquidController,
//               fullTransitionValue: 880,
//               enableSideReveal: true,
//               preferDragFromRevealedArea: true,
//               enableLoop: true,
//               ignoreUserGestureWhileAnimating: true,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: <Widget>[
//                   const Expanded(child: SizedBox()),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List<Widget>.generate(data.length, _buildDot),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.animateToPage(
//                         page: data.length - 1, duration: 700);
//                   },
//                   child: Text("Skip to End"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.jumpToPage(
//                         page: liquidController.currentPage + 1 > data.length - 1
//                             ? 0
//                             : liquidController.currentPage + 1);
//                   },
//                   child: Text("Next"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   pageChangeCallback(int lpage) {
//     setState(() {
//       page = lpage;
//     });
//   }
// }

// ///Example of App with LiquidSwipe by providing list of widgets
// class WithPages extends StatefulWidget {
//   static final style = TextStyle(
//     fontSize: 30,
//     fontFamily: "Billy",
//     fontWeight: FontWeight.w600,
//   );

//   @override
//   _WithPages createState() => _WithPages();
// }

// class _WithPages extends State<WithPages> {
//   int page = 0;
//   late LiquidController liquidController;
//   late UpdateType updateType;
//   final pages = [
//     Container(
//       color: Colors.blue,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.0),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Hi",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "It's Me",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Sahdeep",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.deepPurpleAccent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.0),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Take a",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "look at",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Liquid Swipe",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.green,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.0),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Liked?",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Fork!",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Give Star!",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.yellow,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.0),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Can be",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Used for",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Onboarding Design",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.pink,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 70.0),
//             child: ExampleSlider(),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Example",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "of a page",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "with Gesture",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     Container(
//       color: Colors.red,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Image.asset(
//             'assets/1.png',
//             fit: BoxFit.cover,
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.0),
//           ),
//           Column(
//             children: <Widget>[
//               Text(
//                 "Do",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Try it",
//                 style: WithPages.style,
//               ),
//               Text(
//                 "Thank You",
//                 style: WithPages.style,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ];

//   @override
//   void initState() {
//     liquidController = LiquidController();
//     super.initState();
//   }

//   Widget _buildDot(int index) {
//     double selectedness = Curves.easeOut.transform(
//       max(
//         0.0,
//         1.0 - ((page) - index).abs(),
//       ),
//     );
//     double zoom = 1.0 + (2.0 - 1.0) * selectedness;
//     return new Container(
//       width: 25.0,
//       child: new Center(
//         child: new Material(
//           color: Colors.white,
//           type: MaterialType.circle,
//           child: new Container(
//             width: 8.0 * zoom,
//             height: 8.0 * zoom,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             LiquidSwipe(
//               pages: pages,
//               positionSlideIcon: 0.8,
//               fullTransitionValue: 880,
//               slideIconWidget: Icon(Icons.arrow_back_ios),
//               onPageChangeCallback: pageChangeCallback,
//               waveType: WaveType.liquidReveal,
//               liquidController: liquidController,
//               preferDragFromRevealedArea: true,
//               enableSideReveal: true,
//               ignoreUserGestureWhileAnimating: true,
//               enableLoop: true,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: <Widget>[
//                   Expanded(child: SizedBox()),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List<Widget>.generate(pages.length, _buildDot),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.animateToPage(
//                         page: pages.length - 1, duration: 700);
//                   },
//                   child: Text("Skip to End"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(25.0),
//                 child: TextButton(
//                   onPressed: () {
//                     liquidController.jumpToPage(
//                         page:
//                             liquidController.currentPage + 1 > pages.length - 1
//                                 ? 0
//                                 : liquidController.currentPage + 1);
//                   },
//                   child: Text("Next"),
//                   style: TextButton.styleFrom(
//                       backgroundColor: Colors.white.withOpacity(0.01),
//                       foregroundColor: Colors.black),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   pageChangeCallback(int lpage) {
//     setState(() {
//       page = lpage;
//     });
//   }
// }

// class ExampleSlider extends StatefulWidget {
//   const ExampleSlider({Key? key}) : super(key: key);

//   @override
//   State<ExampleSlider> createState() => _ExampleSliderState();
// }

// class _ExampleSliderState extends State<ExampleSlider> {
//   double sliderVal = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Slider(
//         value: sliderVal,
//         activeColor: Colors.white,
//         inactiveColor: Colors.red,
//         onChanged: (val) {
//           setState(() {
//             sliderVal = val;
//           });
//         });
//   }
// }
