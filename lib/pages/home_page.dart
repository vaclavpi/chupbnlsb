import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images ={
    "podcast.png":"Podcasty",
    "clapperboard.png":"Videa",
    "trophy.png":"Soutěže",
    "houses.png":"Město",
    "info.png":"O aplikaci",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body:  BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          if(state is LoadedState){
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                //title
                Container(
                  margin: const EdgeInsets.only(left:20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "Prozkoumej", size: 35, color: AppColors.fourthColor,),
                      AppLargeText(text: "Brandýs nad Labem - Starou Boleslav", size: 22, color: AppColors.fourthColor,)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                //bar
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: AppColors.fourthColor,
                      unselectedLabelColor: AppColors.secondColor,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(color: AppColors.fourthColor, radius: 4),
                      tabs: [
                        Tab(text: "Kulturní památky"),
                        Tab(text: "Přírodní památky"),
                        Tab(text: "Další zajímavosti"),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20,),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            GestureDetector(
                              onTap:(){
                              BlocProvider.of<AppCubits>(context).DetailPage(info[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top:10),
                                width: 200,
                                height: 300,
                                padding: const EdgeInsets.only(top: 200, left: 0,),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.7),),
                                  padding: const EdgeInsets.only(top: 5, left: 5,),
                                  child: Text(info[index].name,
                                  style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(info[index].img),
                                    fit: BoxFit.cover
                                    )
                                ),
                              ),
                            );
                        },
                      ),
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            GestureDetector(
                              onTap:(){
                              BlocProvider.of<AppCubits>(context).DetailPage(info[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top:10),
                                width: 200,
                                height: 300,
                                padding: const EdgeInsets.only(top: 200, left: 0,),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.7),),
                                  padding: const EdgeInsets.only(top: 5, left: 5,),
                                  child: Text(info[index].name,
                                  style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(info[index].img),
                                    fit: BoxFit.cover
                                    )
                                ),
                              ),
                            );
                        },
                      ),
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return
                            GestureDetector(
                              onTap:(){
                              BlocProvider.of<AppCubits>(context).DetailPage(info[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15, top:10),
                                width: 200,
                                height: 300,
                                padding: const EdgeInsets.only(top: 200, left: 0,),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.7),),
                                  padding: const EdgeInsets.only(top: 5, left: 5,),
                                  child: Text(info[index].name,
                                  style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(info[index].img),
                                    fit: BoxFit.cover
                                    )
                                ),
                              ),
                            );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.only(left:20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: "Mapa", size: 25, color: AppColors.fourthColor,),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<AppCubits>(context, listen: false).MapPage();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      color: Color.fromARGB(255, 20, 54, 76).withOpacity(0.7),
                      width: double.infinity,
                      height: 120,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.7749, -122.4194),
                          zoom: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),





                SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.only(left:20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: "Objevuj více", size: 25, color: AppColors.fourthColor,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 120,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index ){
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                            image: AssetImage(
                              "assets/img/"+images.keys.elementAt(index)),
                            fit: BoxFit.cover
                            )
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: AppText(text: images.values.elementAt(index), color: AppColors.thirdColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
            ],
        );
          }else{
            return Container();
          }
        },
      )
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color:color, radius:radius);
  }

}

class _CirclePainter extends BoxPainter{
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color=color;
    _paint.isAntiAlias=true;
    final Offset circleOffset = Offset(configuration.size!.width/2 -radius/2, configuration.size!.height-radius);
    canvas.drawCircle(offset+circleOffset, radius, _paint);
  }

}