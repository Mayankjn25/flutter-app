import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Photo extends Equatable {
  final String id;
  final String url;

  Photo({
    required this.id,
    required this.url,
  });

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      url: map['urls']['regular'],
    );
  }

  @override
  List<Object> get props => [id, url];

  @override
  bool get stringify => true;
}
