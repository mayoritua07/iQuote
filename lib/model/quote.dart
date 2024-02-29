import 'package:flutter/material.dart';

class Quote {
  Quote(
      {required this.content,
      required this.author,
      required this.id,
      required this.image,
      required this.isFavorite,
      this.notes = const []});

  final List<dynamic> content;
  final String id;
  final String author;
  final List<String> notes;
  bool isFavorite;
  final MemoryImage image;
}
