import 'dart:convert';
import 'package:demose/models/media.dart';
import 'package:http/http.dart' as http;

class MediaService {
  final String baseUrl = 'https://drive.google.com/uc';
  final String thumbnailBasePath = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample';

  Future<Welcome> fetchMediaData(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?id=$id'));
      
      if (response.statusCode == 200) {
        return welcomeFromJson(response.body);
      } else {
        throw Exception('Failed to load media data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
   Future<Video> fetchVideoDetail(int videoId) async {
      try {
      final response = await http.get(Uri.parse('$baseUrl/$videoId')); // Modify the URL to fetch video by ID
      
      if (response.statusCode == 200) {
        // Assuming the response contains a single video object as JSON
        final Map<String, dynamic> videoJson = jsonDecode(response.body);
        return Video.fromJson(videoJson); // Convert JSON to Video object using your model method
      } else {
        throw Exception('Failed to load video detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    // Implement the logic to fetch video details by ID here
    // Make necessary API calls to retrieve details of a specific video
    // Return the Video object
    // throw UnimplementedError('fetchVideoDetail is not implemented yet');
  }
}
