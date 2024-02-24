import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:honest_guide/cubit/app_cubit.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/widgets/app_text.dart';
import 'package:honest_guide/widgets/app_large_bold_text.dart';
import 'package:honest_guide/widgets/app_bold_text.dart';
import 'package:honest_guide/misc/colors.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, String? imageUrl, String? name});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String apiKey =
      'AIzaSyCNyhuZsblc9Ko27fQQ_usslco3N7ZcFkU'; // Nahraďte svým API klíčem
  final String placeId =
      'ChIJnViDs-rxC0cRSjUD9fLW4fE'; // Nahraďte ID místem, které chcete zobrazit

  double starRating = 0.0;

  //@override
  //void initState() {
  //super.initState();
  //fetchStarRating();
  //}

  //Future<void> fetchStarRating() async {
  //final url =
  //'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=rating&key=$apiKey';

  //final response = await http.get(Uri.parse(url));

  //if (response.statusCode == 200) {
  //final data = json.decode(response.body);
  //final rating = data['result']['rating'];
  //setState(() {
  //starRating = rating.toDouble();
  // });
  // } else {
  // throw Exception('Nepodařilo se načíst hodnocení místa.');
  // }
  //}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(detail.places.img),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                left: 20,
                top: 50,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.thirdColor, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.close_rounded),
                        color: Colors.white, // Barva ikony
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
                        color: AppColors.thirdColor, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.photo_album_rounded),
                        color: Colors.white, // Barva ikony
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
                        color: AppColors.thirdColor, // Barva pozadí ikony
                        shape: BoxShape
                            .circle, // Tvar pozadí (v tomto případě kruh)
                      ),
                      padding: EdgeInsets.all(1.0), // Volitelný padding
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.podcasts_rounded),
                        color: Colors.white, // Barva ikony
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 310,
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
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
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.thirdColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AppBoldText(
                                text: detail.places.location,
                                size: 14,
                                color: AppColors.thirdColor)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildStarRating(starRating),
                            Text(
                              '$starRating (Mapy Google)',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.thirdColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        AppLargeText(
                          text: "O tomto objektu:",
                          color: AppColors.thirdColor,
                          size: 23,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: AppText(
                                text: detail.places.description,
                                color: AppColors.mainColor),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 100, // nebo libovolná jiná hodnota
                          padding: EdgeInsets.only(bottom: 0),
                          alignment: Alignment.bottomCenter, // Padding na spo
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                    width:
                                        8), // Mezera na začátku seznamu obrázků
                                buildImage(context, detail.places.img),
                                SizedBox(width: 8), // Mezera mezi obrázky
                                buildImage(context, detail.places.img1),
                                SizedBox(width: 8), // Mezera mezi obrázky
                                buildImage(context, detail.places.img2),
                                SizedBox(width: 8), // Mezera mezi obrázky
                                buildImage(context, detail.places.img3),
                                SizedBox(width: 8), // Mezera mezi obrázky
                                buildImage(context, detail.places.img4),
                                SizedBox(width: 8), // Mezera mezi obrázky
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
                    )),
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
          i < rating ? AppColors.fifthColor : AppColors.secondColor;
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
    // Pokud je imagePath null, můžete vrátit placeholder nebo jiný fallback obsah
    return Container(
      width: 100,
      height: 100,
      color: const Color.fromARGB(255, 255, 255, 255), // Placeholder barva
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DetailPage(),
  ));
}
