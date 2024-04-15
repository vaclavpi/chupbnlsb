import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                              text: "Prozkoumej",
                              size: 35,
                              color: AppColors.fourthColor,
                            ),
                            AppBoldText(
                              text: "Brandýs nad Labem-Starou Boleslav",
                              size: 16,
                              color: AppColors.fourthColor,
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/img/logoTB.png',
                          width: 107,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  // Tab bar
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 20),
                        controller: _tabController,
                        labelColor: AppColors.fourthColor,
                        unselectedLabelColor: Colors.white,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: CircleTabIndicator(
                            color: AppColors.fourthColor, radius: 4),
                        tabs: [
                          Tab(
                            child: Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width / 3 - 40,
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "kultura",
                                  style: TextStyle(
                                      fontFamily: "BB-UttaraGrotesk",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width / 3 - 40,
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "příroda",
                                  style: TextStyle(
                                      fontFamily: "BB-UttaraGrotesk",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width / 3 - 40,
                              decoration: BoxDecoration(
                                color: AppColors.appColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "občerstvení",
                                  style: TextStyle(
                                      fontFamily: "BB-UttaraGrotesk",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tab bar view
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: MediaQuery.of(context).size.width / 1.3,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Kultura tab
                        ListView.builder(
                          itemCount: state.culturePlaces.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context)
                                    .DetailPage(state.culturePlaces[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 1,
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 2,
                                  left: 0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.appColor,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 12,
                                  ),
                                  child: Text(
                                    state.culturePlaces[index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "BB-UttaraGrotesk",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            state.culturePlaces[index].img),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                        ),
                        // Příroda tab
                        ListView.builder(
                          itemCount: state.naturePlaces.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context)
                                    .DetailPage(state.naturePlaces[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 1,
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 2,
                                  left: 0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.appColor,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 12,
                                  ),
                                  child: Text(
                                    state.naturePlaces[index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "BB-UttaraGrotesk",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            state.naturePlaces[index].img),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                        ),
                        // Občerstvení tab
                        ListView.builder(
                          itemCount: state.refreshmentPlaces.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context)
                                    .DetailPage(state.refreshmentPlaces[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 1,
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 2,
                                  left: 0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.appColor,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 12,
                                  ),
                                  child: Text(
                                    state.refreshmentPlaces[index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: "BB-UttaraGrotesk",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            state.refreshmentPlaces[index].img),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Mapa
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: "Mapa",
                          size: 25,
                          color: AppColors.fourthColor,
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.appColor,
                          ),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 7,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<AppCubits>(context).MapPage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/img/mapilu.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  // Objevuj více
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: "Objevuj více",
                          size: 25,
                          color: AppColors.fourthColor,
                        ),
                        SizedBox(height: 10),
                        // Two containers per row
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to another screen
                                  launch(
                                      'https://github.com/vaclavpi/chupbnlsb');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/bnlsbILU5.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.appColor,
                                      ),
                                      child: Text(
                                        'Projekt',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "BB-UttaraGrotesk",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--------------------------------------
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to another screen
                                  launch(
                                      'https://www.brandysko.cz/ap/kdy=4&p1=7519');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/bnlsbILU1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.appColor,
                                      ),
                                      child: Text(
                                        'Aktuálně',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "BB-UttaraGrotesk",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--------------------------------------
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to another screen
                                  launch(
                                      'https://www.youtube.com/channel/UCZtmOJoSyQK_Ls8swIPDftg');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/bnlsbILU2.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.appColor,
                                      ),
                                      child: Text(
                                        'Podcasty',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "BB-UttaraGrotesk",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--------------------------------------
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to another screen
                                  launch('https://vaclavpi.github.io/');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/bnlsbILU3.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.appColor,
                                      ),
                                      child: Text(
                                        'Autor',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "BB-UttaraGrotesk",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //--------------------------------------
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to another screen
                                  launch(
                                      'https://github.com/vaclavpi/chupbnlsb/issues');
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/bnlsbILU4.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.appColor,
                                      ),
                                      child: Text(
                                        'Zpětná vazba',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "BB-UttaraGrotesk",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          } else if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
                child: Text("ERROR: Chyba při načítání 😒 | 0x00001"));
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
