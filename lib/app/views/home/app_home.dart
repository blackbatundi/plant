import 'package:flow_projet/app/start/shared/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class AppHome extends StatefulWidget {
  static String routeName = "/home_app";
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  String selectMenu = "Home";
  Color color = const Color(0xFFebebeb);
  bool hasScrolled = false;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);
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
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  Container(), //hidtoric
                  Container(), //home
                  Container(),
                  // profil
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: bottomNavigation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigation() {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 75),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(.15),
                  offset: const Offset(-1, -5),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 70,
                ),
                modelIcon(
                  icon: Iconsax.scan,
                  menu: "Scan",
                  index: 0,
                ),
                const SizedBox(
                  width: 170,
                ),
                modelIcon(
                  icon: Iconsax.task_square5,
                  menu: "Historic",
                  index: 2,
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 50,
            top: 20,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectMenu = "Home";
                  _tabController!.animateTo(1);
                });
              },
              borderRadius: BorderRadius.circular(80),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
                  shape: BoxShape.circle,
                ),
                child: AnimatedContainer(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.SCAFFOLD_BACKGROUND_LIGHT,
                      width: 8,
                    ),
                    color: selectMenu == "Home"
                        ? AppColors.PRIMARY_COLOR_DARK
                        : Colors.grey.withOpacity(.5),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                          .5,
                        ),
                        offset: const Offset(1, 5),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(.15),
                        offset: const Offset(-1, -5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Iconsax.home_15,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  modelIcon({
    IconData? icon,
    String? menu,
    required index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectMenu = menu!;
          _tabController!.animateTo(index);
        });
      },
      borderRadius: BorderRadius.circular(30),
      child: Column(
        children: [
          Icon(
            icon,
            color: menu == selectMenu
                ? AppColors.PRIMARY_COLOR_DARK
                : Colors.grey.withOpacity(.5),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "$menu",
              style: TextStyle(
                color: menu == selectMenu
                    ? AppColors.PRIMARY_COLOR_DARK
                    : Colors.grey.withOpacity(.5),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
