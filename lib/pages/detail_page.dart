import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import pro Text-To-Speech
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io'; // Import pro práci se soubory

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, String? imageUrl, String? name})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double starRating = 0.0;
  bool visited = false;
  bool isFavorite = false; // Přidána proměnná pro stav oblíbených

  // Placeholder data for demonstration
  late DetailState detail;

  // Funkce pro Text-To-Speech
  Future<void> speakDescription(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("cs-CZ");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

// Funkce pro uložení do oblíbených
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // Přepínáme stav ikony
    });
    // Zde zavoláme funkci pro uložení do databáze s aktuálním stavem isFavorite
    saveToDatabase(isFavorite);
  }

  // Funkce pro uložení do databáze
  void saveToDatabase(bool isFavorite) {
    saveToFavorites(isFavorite, detail.places.name);
  }

  void saveToFavorites(bool isFavorite, String placeName) {
    // Načtení existujících oblíbených položek
    var favorites = <String, dynamic>{};
    File favoritesFile = File('favorites.json');
    if (favoritesFile.existsSync()) {
      var jsonString = favoritesFile.readAsStringSync();
      favorites = json.decode(jsonString);
    }

    // Přidání nebo aktualizace stavu oblíbené položky
    favorites[placeName] = isFavorite;

    // Uložení zpět do souboru
    var jsonString = json.encode(favorites);
    favoritesFile.writeAsStringSync(jsonString);

    print('Místo $placeName bylo uloženo do oblíbených: $isFavorite');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(detail.places.img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 50,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<AppCubits>(context).goHome();
                              },
                              icon: Icon(Icons.close_rounded),
                              color: AppColors.thirdColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 50,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: visited
                                  ? AppColors.fourthColor
                                  : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visited = !visited;
                                  });
                                  // Implementace funkce pro označení jako navštíveného
                                },
                                icon: Icon(visited
                                    ? Icons.check
                                    : Icons.check_box_outline_blank),
                                color: visited
                                    ? Colors.white
                                    : AppColors.thirdColor),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 170,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: IconButton(
                              onPressed: () {
                                speakDescription(detail.places.description);
                              },
                              icon: Icon(Icons.volume_up),
                              color: AppColors.thirdColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 110,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: IconButton(
                              onPressed: () {
                                launch(detail.places.web);
                              },
                              icon: Icon(Icons.language),
                              color: AppColors.thirdColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppLargeText(
                              text: detail.places.name,
                              color: AppColors.fourthColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.thirdColor,
                          ),
                          SizedBox(height: 5),
                          AppBoldText(
                            text: detail.places.location,
                            size: 14,
                            color: AppColors.thirdColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildStarRating(starRating),
                          Text(
                            '$starRating',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.thirdColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildIconButton(
                            icon: Icons.navigation,
                            label: "Navigovat",
                            onTap: () {
                              // Implementace funkce pro navigaci
                            },
                          ),
                          buildIconButton(
                            icon: Icons.favorite,
                            label: "Uložit do oblíbených",
                            onTap: toggleFavorite, // Opraveno zde
                          ),
                          buildIconButton(
                            icon: visited
                                ? Icons.check
                                : Icons.check_box_outline_blank,
                            label: visited ? "Navštíveno" : "Navštíveno?",
                            onTap: () {
                              setState(() {
                                visited = !visited;
                              });
// Implementace funkce pro označení jako navštíveného
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      AppLargeText(
                        text: "Popis",
                        color: AppColors.thirdColor,
                        size: 23,
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: AppText(
                          text: detail.places.description,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(bottom: 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img1),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img2),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img3),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img4),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img5),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img6),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img7),
                              SizedBox(width: 8),
                              buildImage(context, detail.places.img8),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData starIcon = i < rating ? Icons.star : Icons.star_border;
      Color starColor =
          i < rating ? AppColors.fourthColor : AppColors.thirdColor;
      stars.add(
        Icon(
          starIcon,
          color: starColor,
          size: 20.0,
        ),
      );
    }
    return Row(
      children: stars,
    );
  }

  Widget buildIconButton(
      {required IconData icon,
      required String label,
      required Function onTap}) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            onTap();
          },
          icon: Icon(icon),
          color: AppColors.thirdColor,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: AppColors.thirdColor,
          ),
        ),
      ],
    );
  }
}

Widget buildImage(BuildContext context, String? imagePath) {
  if (imagePath != null) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Image.asset(imagePath),
              contentPadding: EdgeInsets.zero,
            ),
          );
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  } else {
    return Container(
      width: 100,
      height: 100,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailPage(),
  ));
}
