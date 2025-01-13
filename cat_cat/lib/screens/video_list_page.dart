import 'package:flutter/material.dart';
import 'video_player_page.dart';
import 'add_video_page.dart';

class VideoListPage extends StatefulWidget {
  const VideoListPage({super.key});

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  List<Map<String, String>> videoList = [
    {
      'title': 'Sample Video 1',
      'url': 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      'thumbnail': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Sample Video 2',
      'url': 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      'thumbnail': 'https://via.placeholder.com/150',
    },
  ];

  void addVideo(Map<String, String> newVideo) {
    setState(() {
      videoList.add(newVideo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          return ListTile(
            leading: Image.network(video['thumbnail']!, width: 100, fit: BoxFit.cover),
            title: Text(video['title']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                    videoUrl: video['url']!,
                    videoTitle: video['title']!,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVideoPage(onAddVideo: addVideo),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
