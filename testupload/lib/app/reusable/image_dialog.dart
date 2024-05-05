import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morpheme_cached_network_image/morpheme_cached_network_image.dart';
import '../constants/index.dart';

class ImageDialog extends StatelessWidget {
  final String img;

  const ImageDialog({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: appColors.trans,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      contentPadding: EdgeInsets.zero,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Center(
              child: MorphemeCachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.contain,
                width: Get.width,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(Icons.close, size: 20),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

CachedNetworkImage networkLoadImage({required String url}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error,size: 50,)),
    fit: BoxFit.fitHeight,
  );
}