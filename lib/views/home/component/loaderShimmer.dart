import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoaderShimmer extends StatelessWidget {
  const LoaderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Colors.grey.withOpacity(0.4),
      highlightColor: Colors.white,
      child: Container(
        margin:const EdgeInsets.all(6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.4)

        ),

      ),
    );
  }
}
