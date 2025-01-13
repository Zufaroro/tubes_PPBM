import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String videoTitle; // Pastikan parameter ini ditambahkan

  const VideoPlayerPage({super.key, required this.videoUrl, required this.videoTitle}); // Tambahkan 'videoTitle' ke konstruktor


  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    // Extract Video ID dari URL
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    // Inisialisasi controller YouTube Player
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    // Hentikan controller ketika halaman ditutup
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: const Color.fromARGB(255, 245, 230, 209),
      ),
      body: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Color.fromARGB(255, 245, 234, 218),
          handleColor: Color.fromARGB(255, 255, 243, 228),
        ),
      ),
    );
  }
}