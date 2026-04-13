import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatListShimmer extends StatelessWidget {
  final int itemCount;
  const ChatListShimmer({super.key,required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 Top Title Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              shimmerBox(width: 120, height: 20),
              shimmerCircle(20),
            ],
          ),
        ),

        // 🔹 Search Bar Shimmer
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: shimmerBox(width: double.infinity, height: 45),
        ),

        SizedBox(height: 16),

        // 🔹 List Shimmer
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    shimmerCircle(50),
                    SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerBox(width: 120, height: 12),
                          SizedBox(height: 6),
                          shimmerBox(width: 180, height: 10),
                        ],
                      ),
                    ),

                    shimmerBox(width: 40, height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget shimmerBox({double width = 100, double height = 10}) {
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