import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                //title
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
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
                          AppLargeText(
                            text: "Brandýs nad Labem - Starou Boleslav",
                            size: 17,
                            color: AppColors.fourthColor,
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/img/znak.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //bar
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: AppColors.fourthColor,
                      unselectedLabelColor: AppColors.thirdColor,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(
                          color: AppColors.fourthColor, radius: 4),
                      tabs: [
                        Tab(
                          child: Container(
                            height: 25,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(90, 20, 54, 76),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("⛪ kultura"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 25,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(90, 20, 54, 76),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("🌳 příroda"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 25,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(90, 20, 54, 76),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("☕🍔 občerstvení"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<AppCubits>(context)
                                  .DetailPage(info[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15, top: 10),
                              width: 200,
                              height: 300,
                              padding: const EdgeInsets.only(
                                top: 200,
                                left: 0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 20, 54, 76)
                                      .withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  left: 5,
                                ),
                                child: Text(
                                  info[index].name,
                                  style: TextStyle(
                                      fontSize: 23,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(info[index].img),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: "Mapa",
                        size: 25,
                        color: AppColors.fourthColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.7),
                  ),
                  width: double.maxFinite,
                  height: 120,
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
                SizedBox(height: 30),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(
                        text: "Objevuj více",
                        size: 25,
                        color: AppColors.fourthColor,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First icon with text
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.navColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Handle the click event for the first icon
                                    // Navigate to the desired page
                                    // Example:
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));
                                  },
                                  icon: Icon(Icons.podcasts_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("Podcasty"),
                            ],
                          ),

                          // Second icon with text
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.navColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Handle the click event for the second icon
                                    // Navigate to the desired page
                                    // Example:
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));
                                  },
                                  icon: Icon(Icons.location_city_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("Město"),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.navColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Handle the click event for the second icon
                                    // Navigate to the desired page
                                    // Example:
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));
                                  },
                                  icon: Icon(Icons.event_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("Akce"),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.navColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // Handle the click event for the second icon
                                    // Navigate to the desired page
                                    // Example:
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));
                                  },
                                  icon: Icon(Icons.photo_camera_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("Co to je?"),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.navColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AppCubits>(context)
                                        .goAbout();
                                  },
                                  icon: Icon(Icons.info_rounded,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text("O aplikaci"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // End of the content in the Column
                SizedBox(height: 30),
              ],
            );
          } else {
            return Container();
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
