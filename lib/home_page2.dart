import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:honest_guide/pages/detail_page.dart';
import 'package:honest_guide/pages/navpages/about_page.dart';
import 'package:honest_guide/pages/navpages/podcast.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BnL-SB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> data1 = [];
  List<dynamic> data2 = [];
  List<dynamic> data3 = [];
  List<dynamic> data4 = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String dataString1 =
        await rootBundle.loadString('assets/data/culture_data.json');
    String dataString2 =
        await rootBundle.loadString('assets/data/food_data.json');
    String dataString3 =
        await rootBundle.loadString('assets/data/nature_data.json');
    String dataString4 = await rootBundle.loadString('assets/data/data.json');

    setState(() {
      data1 = json.decode(dataString1);
      data2 = json.decode(dataString2);
      data3 = json.decode(dataString3);
      data4 = json.decode(dataString4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
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
          SizedBox(height: 20), // Odsazení mezi nadpisem a záložkami
          _buildTabs(),
          Expanded(
            child: _buildListView(),
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
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/vapi.jpeg'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'O projektu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/znak.png'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'O městě',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PodcastPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/podcasty.png'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'Podcasty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/welcome-3.png'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'Podcasty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/welcome-3.png'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'Podcasty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/img/welcome-3.png'),
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
                                color: Color.fromARGB(255, 20, 54, 76)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                'Podcasty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //--------------------------------------
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < 4; index++)
            _buildTab(index, _getTabTitle(index)),
        ],
      ),
    );
  }

  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'Památky';
      case 1:
        return 'Příroda';
      case 2:
        return 'Kultura';
      case 3:
        return 'Nové položky';
      default:
        return '';
    }
  }

  Widget _buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 30,
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Colors.blue
              : Color.fromARGB(90, 20, 54, 76),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    List<dynamic> selectedData = [];
    switch (_selectedIndex) {
      case 0:
        selectedData = data1;
        break;
      case 1:
        selectedData = data2;
        break;
      case 2:
        selectedData = data3;
        break;
      case 3:
        selectedData = data4;
        break;
    }
    return Container(
      margin: EdgeInsets.only(top: 20), // Mezera nad seznamem položek
      height: 200, // Nastavte výšku seznamu podle potřeby
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < selectedData.length; i++)
              _buildListItem(selectedData[i]['img'], selectedData[i]['name'],
                  () {
                // Funkce pro navigaci na detail stránku po kliknutí na položku
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String? imageUrl, String? name, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Předávání funkce onTap pro reakci na kliknutí
      child: Container(
        margin: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8), // Mezery od levého a pravého okraje a mezi položkami
        height: 300,
        child: Container(
          height: 300,
          width: 200,
          padding: const EdgeInsets.only(top: 200, left: 0),
          child: Container(
            padding: const EdgeInsets.only(top: 5, left: 5),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              name ?? 'Unknown',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imageUrl ?? 'assets/img/default_image.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
