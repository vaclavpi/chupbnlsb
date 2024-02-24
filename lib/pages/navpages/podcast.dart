import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importuj url_launcher balíček

class PodcastPage extends StatefulWidget {
  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Podcasty'),
        ),
        body: PodcastyStranka(),
      ),
    );
  }
}

class PodcastyStranka extends StatelessWidget {
  final List<Podcast> podcasty = [
    Podcast(
      nazev: 'Název podcastu 1',
      obrazekUrl:
          'https://www.krestanskevanoce.cz/f/repository/uploads/80ddc47c02e14bcf8818a13345bcab1a.jpeg',
      youtubeOdkaz: 'https://www.youtube.com/watch?v=3NbXXYCHKR8',
    ),
    Podcast(
      nazev: 'Název podcastu 2',
      obrazekUrl:
          'https://www.krestanskevanoce.cz/f/repository/uploads/80ddc47c02e14bcf8818a13345bcab1a.jpeg',
      youtubeOdkaz: 'https://www.youtube.com/watch?v=3NbXXYCHKR8',
    ),
    // Zde můžeš přidat další podcasty podle potřeby
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: podcasty.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _openUrl(
                podcasty[index].youtubeOdkaz); // Otevřít odkaz při kliknutí
          },
          child: Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  podcasty[index].obrazekUrl,
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  podcasty[index].nazev,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Metoda pro otevření odkazu v prohlížeči
Future<void> _openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Nelze otevřít $url';
  }
}

class Podcast {
  final String nazev;
  final String obrazekUrl;
  final String youtubeOdkaz;

  Podcast(
      {required this.nazev,
      required this.obrazekUrl,
      required this.youtubeOdkaz});
}
