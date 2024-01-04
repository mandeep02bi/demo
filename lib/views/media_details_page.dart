import 'package:flutter/material.dart';
import 'package:demose/services/media_services.dart';
import 'package:demose/models/media.dart'; // Import your models

class MediaDetailPage extends StatefulWidget {
  final Video video; // Pass the selected video to this page

  MediaDetailPage({required this.video});

  @override
  _MediaDetailPageState createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends State<MediaDetailPage> {
  final MediaService mediaService = MediaService();
  late Video selectedVideo; // Variable to store fetched video detail

  @override
  void initState() {
    super.initState();
    // fetchData();
  }



  @override
  Widget build(BuildContext context) {
  
      return Scaffold(
        appBar: AppBar(
          title: Text('Media Detail'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.video.title),
              // Display other details of the video
              // Implement download, playback, and error handling
            ],
          ),
        ),
      );
    }
  
}
