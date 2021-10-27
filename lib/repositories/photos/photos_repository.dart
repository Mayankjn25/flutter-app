import 'dart:convert';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_photos/.env.dart';
import 'package:flutter_photos/models/models.dart';
import 'package:flutter_photos/models/photo_model.dart';
import 'package:flutter_photos/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:palash_assignment/models/photo_model.dart';

import 'base_photos_repository.dart';

class PhotosRepository extends BasePhotosRepository {
  static const String _pexelBaseUrl = 'https://api.pexels.com/v1';
  static const int numPerPage = 10;

  final http.Client _httpClient;

  PhotosRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<List<Photo>> searchPhotos({
    required String query,
    int page = 1,
  }) async {
    try {
      final url =
          '$_pexelBaseUrl/search?page=$page&per_page=$numPerPage&query=$query';
      final response = await _httpClient.get(Uri.parse(url), headers: {
        'Authorization':
            '563492ad6f91700001000001ec9665f5282542acbdbeca8d63f85147'
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List results = data['results'];
        final List<Photo> photos =
            results.map((e) => Photo.fromMap(e)).toList();
        return photos;
      }
      throw Failure();
    } catch (_) {
      throw Failure();
    }
  }
}
