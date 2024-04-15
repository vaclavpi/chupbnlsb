import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/misc/colors.dart';
import 'package:flutter_tts/flutter_tts.dart'; // Import pro Text-To-Speech

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, String? imageUrl, String? name})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double starRating = 0.0;

  // Funkce pro Text-To-Speech
  Future<void> speakDescription(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(
        "cs-CZ"); // Nastaví jazyk na češtinu (pokud je to váš případ)
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(detail.places.img),
                      fit: BoxFit.cover,
                    ),
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
                        color: Colors.white, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.close_rounded),
                        color: AppColors.thirdColor, // Barva ikony
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
                        color: Colors.white, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.control_camera),
                        color: AppColors.thirdColor, // Barva ikony
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
                        color: Colors.white, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          speakDescription(detail.places.description);
                        },
                        icon: Icon(Icons.volume_up),
                        color: AppColors.thirdColor, // Barva ikony
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 310,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 320 - 1,
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
                            '$starRating (Mapy Google)',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.thirdColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      AppLargeText(
                        text: "O tomto objektu:",
                        color: AppColors.thirdColor,
                        size: 23,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: AppText(
                            text: detail.places.description,
                            color: AppColors.mainColor,
                          ),
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
              ),
            ],
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
