import 'package:flutter/material.dart';
import 'package:wri/presentation/providers/country_info_provider.dart';
import 'package:wri/presentation/screens/widget/expand_text.dart';
import 'package:wri/presentation/screens/widget/tab_bar_delegate.dart';

import '../../common/color.dart';

class CountryInfo extends StatefulWidget {
  const CountryInfo({super.key});

  @override
  State<CountryInfo> createState() => _TestState();
}

class _TestState extends State<CountryInfo> with TickerProviderStateMixin {
  late final TabController tabController;

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    countryInfoProvider.loadCountryInfoModel(titles: '가나');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      countryInfoProvider.addListener(updateScreen);
    },);
  }

  @override
  void dispose() {
    countryInfoProvider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthMedia = MediaQuery.sizeOf(context).width;
    final heightMedia = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        leading: Icon(
          Icons.arrow_back_ios,
          color: backArrowGray,
          size: 24,
        ),
        titleSpacing: -15,
        title: Text(
            '가나',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ), // 나라 이름
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: heightMedia * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: kBackgroundColor,
                  height: heightMedia * 0.3,
                  width: widthMedia,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: -10,
                        child: Image.asset(
                          'assets/world_image.png',
                          width: widthMedia,
                        ),
                      ), // 세계 지도
                      Positioned(
                        top: 20,
                        child: Image.network(
                          'https://opendata.mofa.go.kr:8444/fileDownload/images/country_images/flags/15/20220318_161935687.gif',
                          width: widthMedia * 0.5,
                        ),
                      ), // 국기
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: widthMedia,
                          height: heightMedia * 0.18,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kTransparentColor,
                                kBackgroundColor,
                                kBackgroundColor,
                              ],
                            ),
                          ),
                        ),
                      ), // 리니얼 그라디언트
                    ],
                  ),
                ),
              ),
            ), // 국기 이미지
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                widget: Container(
                  color: kBackgroundColor,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    controller: tabController,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: tabBarIndicatorColor,
                    indicatorColor: kBlack,
                    onTap: (value) {
                      setState(() {});
                    },
                    labelColor: kBlack,
                    unselectedLabelColor: tabBarColor,
                    labelStyle: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.visible,
                    ),
                    tabs: [
                      Tab(text: '소개', ),
                      Tab(text: '정보', ),
                      Tab(text: '환율', ),
                      Tab(text: '여행지', ),
                      Tab(text: '항공편', ),
                    ],
                  ),
                )
              ),
            ), // 탭바
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: heightMedia * 3,
                      width: widthMedia,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${countryInfoProvider.countryInfoModel?.pages.values.first.title} (Africa)',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30
                                      ),
                                    ),
                                  ],
                                ), // 나라 이름
                                expandText(
                                  text: countryInfoProvider.countryInfoModel?.pages.values.first.extract ?? '',
                                ), // 나라 상세 설명
                              ],
                            ),
                          ),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
