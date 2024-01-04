import 'package:flutter/material.dart';
import 'package:demose/models/media.dart';
import 'package:demose/services/media_services.dart';

class MediaDetailViewModel extends ChangeNotifier {
  final MediaService _mediaService = MediaService();
  late Video selectedVideo;

  Future<void> fetchVideoDetail(int videoId) async {
    try {
      // Assuming you have a specific method in your service to fetch video details by ID
      selectedVideo = await _mediaService.fetchVideoDetail(videoId);
      notifyListeners();
    } catch (e) {
      // Handle errors, e.g., show error message or retry logic
      print('Error fetching video detail: $e');
    }
  }
}
