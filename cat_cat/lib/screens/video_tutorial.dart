import 'package:flutter/material.dart';
import 'video_player.dart';

class VideoTutorialPage extends StatelessWidget {
  const VideoTutorialPage({super.key});

  final List<Map<String, String>> videoList = const [
    {
      'title':
          'How to Get your Cat Used to Water (4 Step Tutorial) | The Cat Butler',
      'url': 'https://youtu.be/tcaJgnAm6pk',
      'thumbnail':
          'https://firebasestorage.googleapis.com/v0/b/cat-cat-5f7eb.firebasestorage.app/o/images%2FTumbnail1.png?alt=media&token=5f359f86-9193-4793-b3ae-bdea63adba75',
    },
    {
      'title':
          'How to Bathe your Cat that Hates Water (6 Step Tutorial) | The Cat Butler',
      'url': 'https://youtu.be/ORtlZG_RU1s',
      'thumbnail':
          'https://firebasestorage.googleapis.com/v0/b/cat-cat-5f7eb.firebasestorage.app/o/images%2Ftumbnail2.png?alt=media&token=c148de07-bef8-4f14-a2a8-5ed24a72ff57',
    },
    {
      'title': 'How to wash a Kitten without making it to scared',
      'url': 'https://youtu.be/ymxEmbALjIo',
      'thumbnail':
          'https://firebasestorage.googleapis.com/v0/b/cat-cat-5f7eb.firebasestorage.app/o/images%2Ftumbnail3.png?alt=media&token=dbd5b8b9-9539-4e13-97cb-6dd21bffd288',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 231, 208),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Find best vaccinate, treatment...',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayerPage(videoUrl: video['url']!),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      video['thumbnail']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Figma · k views · 10 days ago',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: const Color.fromARGB(255, 211, 162, 87),
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(25),
      //       topRight: Radius.circular(25),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.2),
      //         blurRadius: 10,
      //         offset: const Offset(0, -4),
      //       ),
      //     ],
      //   ),
      // child: BottomNavigationBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      //   unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   currentIndex: 1,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.play_circle_fill),
      //       label: 'Tutorial',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart),
      //       label: 'Progress',
      //     ),
      //   ],
      // ),
      //   ),
    );
  }
}
