import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StarCountScreen extends StatefulWidget {
  const StarCountScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StarCountScreenState createState() => _StarCountScreenState();
}

class _StarCountScreenState extends State<StarCountScreen> {
  final String apiKey = 'AIzaSyCNyhuZsblc9Ko27fQQ_usslco3N7ZcFkU'; // Nahraďte svým API klíčem
  final String placeId = 'ChIJdcS7XMLxC0cRtBY7hqc6oUc'; // Nahraďte dotazem na místo

  double starRating = 0.0;

  @override
  void initState() {
    super.initState();
    fetchStarRating();
  }

  Future<void> fetchStarRating() async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=rating&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rating = data['result']['rating'];
      setState(() {
        starRating = rating.toDouble();
      });
    } else {
      throw Exception('Nepodařilo se načíst hodnocení místa.');
    }
  }

  Widget buildStarRating(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData starIcon = i < rating ? Icons.star : Icons.star_border;
      Color starColor = i < rating ? Colors.yellow : Colors.grey;
      stars.add(
        Icon(
          starIcon,
          color: starColor,
          size: 40.0,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hodnocení místa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildStarRating(starRating),
            const SizedBox(height: 20.0),
            Text(
              'Hodnocení místa: $starRating',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: StarCountScreen(),
  ));
}
