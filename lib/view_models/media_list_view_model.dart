import 'package:flutter/material.dart';
import 'package:demose/models/media.dart';
import 'package:demose/services/media_services.dart';

class MediaListViewModel extends ChangeNotifier {
  final MediaService _mediaService = MediaService();
  List<Category> categories = [];

  Future<void> fetchMediaData(String id) async {
    try {
      Welcome mediaData = await _mediaService.fetchMediaData(id);
      categories = mediaData.categories;
      notifyListeners();
    } catch (e) {
      // Handle errors, e.g., show error message or retry logic
      print('Error fetching media data: $e');
    }
  }
}
