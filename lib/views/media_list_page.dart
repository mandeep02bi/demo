
// ignore_for_file: unnecessary_null_comparison, prefer_interpolation_to_compose_strings, depend_on_referenced_packages
import 'dart:io';


import 'package:demose/views/media_details_page.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
import 'package:demose/services/media_services.dart';
import 'package:demose/models/media.dart'; // Import your models
import 'package:open_file/open_file.dart';

// Function to handle the downloaded video file
Future<void> playDownloadedVideo(File file) async {
  if (file.existsSync()) {
    // Check if the file exists
    try {
      await OpenFile.open(file.path); // Opens the file with an appropriate app
    } catch (e) {
      print('Error opening file: $e');
    }
  } else {
    print('File does not exist');
  }
}

class MediaListPage extends StatefulWidget {
  @override
  _MediaListPageState createState() => _MediaListPageState();
}

class _MediaListPageState extends State<MediaListPage> {
  final MediaService mediaService = MediaService();
  Welcome? mediaData; // Variable to store fetched media data
  String thmbailurl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/";
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Welcome fetchedData = await mediaService.fetchMediaData('1FEOTw_ioZ4SR4Iq5UxqsqcEgKAg3bNtX');
      setState(() {
        mediaData = fetchedData;
      });
    } catch (e) {
      // Handle error
      print('Error fetching media data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media List'),
      ),
      body: mediaData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: mediaData!.categories.length,
              itemBuilder: (context, index) {
                Category category = mediaData!.categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        category.name,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: category.videos.length,
                      itemBuilder: (context, videoIndex) {
                        Video video = category.videos[videoIndex];
                          return ListTile(

      leading: CircleAvatar(
        backgroundImage: NetworkImage(thmbailurl + video.thumb), // Assuming thumb is a URL
      ),
      title: Text(video.title),
      subtitle: Text(video.description),
      trailing: IconButton(
        icon: Icon(Icons.download), // Replace with appropriate icon
        onPressed: () {
          // Implement download functionality for this video
        downloadVideo(video);
        },
      ),
      onTap: () {
        // Handle the tap event for the video item
         Navigator.push(context, MaterialPageRoute(builder: (context) => MediaDetailPage(video: video)));
      },
    );
                        // Here, build a ListTile or other widget to display video information
                        // Implement download functionalities, pause/resume, etc. for each video
                       
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}

void downloadVideo(Video video) async {
  final url = video.sources[0]; 
  print(url);// Assuming video.sources[0] holds the download URL
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    print(response);
     final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/video_${video.id}.mp4'); // Assuming it's a video file
      await file.writeAsBytes(response.bodyBytes);
       print('File downloaded to: ${file.path}');
      playDownloadedVideo(file);
    // Save the downloaded data or perform actions with it
    // Example: Save to local storage, play the video, etc.
  } else {
    // Handle download failure
    print('Download failed: ${response.reasonPhrase}');
  }
}

