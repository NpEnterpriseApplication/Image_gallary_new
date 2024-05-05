import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morpheme_cached_network_image/morpheme_cached_network_image.dart';
import '../../../constants/index.dart';
import '../../../reusable/image_dialog.dart';
import '../../../reusable/index.dart';
import '../../../utils/index.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppTextFormField(
              isTitled: false,
              prefix: const Icon(
                Icons.search,
              ),
              controller: controller.searchController,
              hintText: AppString.searchImage,
              onChange: (value) {
                controller.debounce(() {
                  controller.filterImages(value);
                });
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.isFalse) {
                return controller.filteredImgData.value.hits?.isNotEmpty ??
                        false
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: Get.height * 0.02,
                            top: Get.height * 0.02,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                !Responsive.isDesktop(context) ? 2 : 3,
                            crossAxisSpacing: Get.width * 0.01,
                            mainAxisExtent: !Responsive.isDesktop(context)
                                ? !Responsive.isTablet(context)
                                    ? Get.height * 0.45
                                    : Get.height * 0.5
                                : Get.height * 0.55,
                            mainAxisSpacing: Get.width * 0.01,
                          ),
                          itemCount:
                              controller.filteredImgData.value.hits?.length,
                          itemBuilder: (context, index) {
                            var data =
                                controller.filteredImgData.value.hits?[index];

                            String tagInput = data?.tags ?? emptyString;
                            List<String> words = tagInput.split(', ');

                            List<String> capitalizedWords = words.map((word) {
                              String trimmedWord = word.trim();
                              if (trimmedWord.isNotEmpty) {
                                return trimmedWord[0].toUpperCase() +
                                    trimmedWord.substring(1).toLowerCase();
                              } else {
                                return '';
                              }
                            }).toList();

                            String tagValue = capitalizedWords.join(', ');

                            return Obx(() => listTile(
                                  context,
                                  image: data?.largeImageUrl ?? emptyString,
                                  likesCount: data?.likes ?? 0,
                                  viewCount: data?.views ?? 0,
                                  imgName: tagValue,
                                  icon: data!.isLiked.isTrue
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  onTapLike: () {
                                    data.isLiked.value = !data.isLiked.value;

                                    if (data.isLiked.isTrue) {
                                      data.likes = (data.likes ?? 0) + 1;
                                    } else {
                                      data.likes = (data.likes ?? 0) - 1;
                                    }

                                    controller.toggleLike(data.id ?? 0);
                                  },
                                  onTap: () {
                                    Get.dialog(ImageDialog(
                                      img: data.largeImageUrl ?? emptyString,
                                    ));
                                  },
                                ));
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                        AppString.noDataFound,
                        style: latoText.get17.w600.textColor(
                          appColors.xff000000.withOpacity(0.9),
                        ),
                      ));
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            }),
          ),
        ],
      ),
    );
  }

//==============================================================================
// ** Helper Widget **
//==============================================================================
  Widget listTile(BuildContext context,
      {required void Function() onTap,
      required String image,
      required int likesCount,
      required String imgName,
      IconData? icon,
      required void Function() onTapLike,
      required int viewCount}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: appColors.xffEFEBDA,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: MorphemeCachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: Get.width,
                ), // Show loading indicator if imageBytes is null
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.012),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.01),
                    child: Text(
                      imgName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: latoText.get16.w600
                          .textColor(appColors.xff000000.withOpacity(0.9)),
                    ),
                  ),
                  if (Responsive.isMobile(context) ||
                      Responsive.isMobile(context))
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.01, bottom: Get.height * 0.015),
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowText(
                              title: 'Likes : ',
                              dec: likesCount.toString(),
                              onTapLike: onTapLike,
                              icon: icon),
                          rowText(title: 'Views : ', dec: viewCount.toString())
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height * 0.01, bottom: Get.height * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowText(
                              title: 'Likes : ',
                              dec: likesCount.toString(),
                              onTapLike: onTapLike,
                              icon: icon),
                          rowText(title: 'Views : ', dec: viewCount.toString())
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowText(
      {required String title,
      required String dec,
      IconData? icon,
      void Function()? onTapLike}) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: onTapLike,
              child: Icon(
                icon,
                color: appColors.xffF44336,
              ),
            ),
          )
         ,
        RichText(
          text: TextSpan(
            text: title,
            style: latoText.get15.w500,
            children: <TextSpan>[
              TextSpan(
                  text: dec,
                  style: latoText.get15.w600
                      .textColor(appColors.xff000000.withOpacity(0.7))),
            ],
          ),
        ),
      ],
    );
  }
}
