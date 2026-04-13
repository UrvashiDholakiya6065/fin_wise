import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatShimmerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: shimmerBox(width: 120, height: 16),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: shimmerCircle(40),
        ),
        actions: [
          shimmerCircle(20),
          SizedBox(width: 12),
          shimmerCircle(20),
          SizedBox(width: 12),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 10,
        itemBuilder: (context, index) {
          bool isMe = index % 2 == 0;

          return Align(
            alignment:
            isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: shimmerBox(width: 150, height: 12),
            ),
          );
        },
      ),
    );
  }

  // 🔹 shimmer rectangle
  Widget shimmerBox({double width = double.infinity, double height = 10}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  // 🔹 shimmer circle
  Widget shimmerCircle(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.white,
      ),
    );
  }
}