import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wri/common/color.dart';
import 'package:wri/presentation/providers/home_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _TestState();
}

class _TestState extends State<Home> {

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeProvider.addListener(updateScreen);
    },);
  }

  @override
  void dispose() {
    homeProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthMedia = MediaQuery.sizeOf(context).width;
    final heightMedia = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/wri_logo.png',
                      height: 40,
                    ),
                    Spacer(),
                    Icon(Icons.notifications_rounded, color: iconColor,),
                    SizedBox(width: widthMedia * 0.05,),
                    Icon(Icons.settings_rounded, color: iconColor,),
                  ],
                ), // 최상단
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    width: widthMedia,
                    height: 54,
                    decoration: BoxDecoration(
                      color: textFiledColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: widthMedia * 0.05,),
                        Expanded(
                          child: TextField(
                            controller: homeProvider.searchCountryController,
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w400,
                              color: kBlack
                            ),
                            decoration: InputDecoration(
                              hintText: '나라 검색',
                              hintStyle: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: searchHintText,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
          
                          },
                          child: Icon(Icons.search_rounded, color: searchIconColor,),
                        ),
                        SizedBox(width: widthMedia * 0.05,),
                      ],
                    ),
                  ),
                ), // 검색창
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    child: Image.asset(
                      'assets/ad_banner.png',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ), // 광고 배너
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/air_plane.png'
                              ),
                            ),
                            Spacer(flex: 2,),
                            Text(
                              '항공권',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: itemTextColor
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/exchange_rate.png'
                              ),
                            ),
                            Spacer(flex: 2,),
                            Text(
                              '환율',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: itemTextColor
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/roaming.png'
                              ),
                            ),
                            Spacer(flex: 2,),
                            Text(
                              '로밍',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: itemTextColor
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 100,
                        width: 70,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/event.png'
                              ),
                            ),
                            Spacer(flex: 2,),
                            Text(
                              '이벤트',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: itemTextColor
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // 아이템
                SizedBox(height: heightMedia * 0.03,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        '어디로 가볼까?',
                        style: TextStyle(
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w600,
                          color: kBlack,
                          fontSize: 20
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 95,
                        height: 35,
                        decoration: BoxDecoration(
                          color: textFiledColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            '더 보기',
                            style: TextStyle(
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w400,
                              color: moreInfoTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // 어디로 가볼까?
                /*
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '검색결과 ',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                color: kBlack
                              ),
                            ),
                            TextSpan(
                              text: '12',
                              style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w700,
                                color: kBlack
                              ),
                            ),
                            TextSpan(
                              text: ' 개 ',
                              style: TextStyle(
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w400,
                                  color: kBlack
                              ),
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                ), // 검색 결과 */ // TODO
              ],
            ),
          ),
        ),
      ),
    );
  }
}
