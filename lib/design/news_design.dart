import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../backend/news.dart';

// ignore: must_be_immutable
class NewsDesign extends StatelessWidget {
  News news;
  NewsDesign({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: news.imageUrl!,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator(),), // Provide a placeholder URL if imageUrl is null
            errorWidget: (context, url, error) {
              return const Center(
                child: Icon(
                  Icons.error_outline, // Show an error icon
                  color: Colors.red,
                  size: 50,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            news.title ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Author: ${news.author ?? 'Unknown Author'}",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(news.description ?? ''),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => openLink(news.url),
            child: const Text(
              "Read more",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void openLink(String? link) async {
    if (await canLaunch(link!)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
