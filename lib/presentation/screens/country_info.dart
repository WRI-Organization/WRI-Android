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
    countryInfoProvider.loadCountryInfoModel();
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
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: backArrowGray,
            size: 24,
          ),
        ),
        titleSpacing: -15,
        title: Text(
            '${countryInfoProvider.countryInfoModel?.data.country_name}',
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
              automaticallyImplyLeading: false,
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
                        child: Builder(
                          builder: (context) {
                            final flagUrl = countryInfoProvider.countryInfoModel?.data.flag_url;
                            if (flagUrl == null || flagUrl.isEmpty) {
                              return Container(
                                width: 180,
                                height: 120,
                                color: futureBuilderColor,
                              );
                            }
                            return Image.network(
                              '${countryInfoProvider.countryInfoModel?.data.flag_url}',
                              width: 180,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 180,
                                  height: 120,
                                  color: futureBuilderColor,
                                );
                              },
                            );
                          }
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
                                      '${countryInfoProvider.countryInfoModel?.data.country_name} (${countryInfoProvider.countryInfoModel?.data.continent})',
                                      style: TextStyle(
                                        fontFamily: 'inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30
                                      ),
                                    ),
                                  ],
                                ), // 나라 이름
                                expandText(
                                  text: countryInfoProvider.countryInfoModel?.data.extract ?? '',
                                ), // 나라 상세 설명
                                SizedBox(height: heightMedia * 0.1),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '여행 경보',
                                        style: TextStyle(
                                          fontFamily: 'inter',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                        ),
                                      ),
                                      Icon(
                                        Icons.warning_rounded,
                                        size: 16,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(context: context, builder: (context) {
                                            return Dialog(
                                              insetPadding: EdgeInsets.symmetric(horizontal: 20),
                                              child: Builder(
                                                  builder: (context) {
                                                    final flagUrl = countryInfoProvider.countryInfoModel?.data.dang_map_download_url;
                                                    if (flagUrl == null || flagUrl.isEmpty) {
                                                      return Container(
                                                        width: widthMedia,
                                                        height: 344.0,
                                                        color: futureBuilderColor,
                                                      );
                                                    }
                                                    return Container(
                                                      width: widthMedia,
                                                      height: widthMedia,
                                                      decoration: BoxDecoration(
                                                        color: kBackgroundColor,
                                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                                                            child: Image.network(
                                                              'http://10.188.141.251:3000${countryInfoProvider.countryInfoModel?.data.dang_map_download_url}',
                                                              width: widthMedia,
                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                if (loadingProgress == null) return child;
                                                                return Container(
                                                                  width: widthMedia,
                                                                  height: 344.0,
                                                                  color: futureBuilderColor,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Container(
                                                                width: widthMedia,
                                                                decoration: BoxDecoration(
                                                                  color: dialogBackgroundColor,
                                                                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))
                                                                ),
                                                                child: Center(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                    child: Container(
                                                                      width: widthMedia,
                                                                      height: 35,
                                                                      decoration: BoxDecoration(
                                                                        color: kBackgroundColor,
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      child: Center(
                                                                        child: Text(
                                                                          '닫기',
                                                                          style: TextStyle(
                                                                            fontFamily: 'inter',
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 12
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              ),
                                            );
                                          },);
                                        },
                                        child: Container(
                                          width: 95,
                                          height: 26,
                                          decoration: BoxDecoration(
                                            color: textFiledColor,
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '지도보기',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'inter',
                                                fontWeight: FontWeight.w500,
                                                color: openMapColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
