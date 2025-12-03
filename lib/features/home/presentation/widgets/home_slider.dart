import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/domain/entities/slider_model/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSlider extends StatefulWidget {
  final List<SliderModel> sliders;
  const HomeSlider({super.key, required this.sliders});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            initialPage: 0,
            onPageChanged: (index, reason) {
              activeIndex = index;
              setState(() {});
            },
            height: 150,
          ),
          itemCount: widget.sliders.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.sliders[itemIndex].image!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
        ),
        Gap(20),
        widget.sliders.isNotEmpty
            ? AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: widget.sliders.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  dotColor: AppColors.greyColor,
                  activeDotColor: AppColors.primaryColor,
                  expansionFactor: 5,
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
