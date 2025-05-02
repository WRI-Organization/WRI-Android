import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wri/common/color.dart';
import 'package:wri/presentation/providers/main_tab_provider.dart';
import 'package:wri/presentation/screens/home.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _TestState();
}

class _TestState extends State<MainTab> {

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainTabProvider.addListener(updateScreen);
    },);
  }

  @override
  void dispose() {
    mainTabProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: IndexedStack(
        index: mainTabProvider.currentIndex,
        children: [
          Home(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          border: Border.all(color: borderStroke),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          child: BottomNavigationBar(
            backgroundColor: kBackgroundColor,
            currentIndex: mainTabProvider.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              mainTabProvider.setCurrentIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icon/home.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(selectItemColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(
                  'assets/icon/home.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(unselectItemColor, BlendMode.srcIn),
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icon/flight_takeoff.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(selectItemColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(
                  'assets/icon/flight_takeoff.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(unselectItemColor, BlendMode.srcIn),
                ),
                label: '항공기',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icon/local_mall.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(selectItemColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(
                  'assets/icon/local_mall.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(unselectItemColor, BlendMode.srcIn),
                ),
                label: '환율',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icon/support_agent.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(selectItemColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(
                  'assets/icon/support_agent.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(unselectItemColor, BlendMode.srcIn),
                ),
                label: '로밍',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icon/event_available.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(selectItemColor, BlendMode.srcIn),
                ),
                icon: SvgPicture.asset(
                  'assets/icon/event_available.svg',
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(unselectItemColor, BlendMode.srcIn),
                ),
                label: '이벤트',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
