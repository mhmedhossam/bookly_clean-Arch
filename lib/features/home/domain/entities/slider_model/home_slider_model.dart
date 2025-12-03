import 'package:bookia/features/home/domain/entities/slider_model/slider.dart';

class HomeSliderModel {
  List<SliderModel>? sliders;

  HomeSliderModel({this.sliders});

  factory HomeSliderModel.fromJson(json) {
    return HomeSliderModel(
      sliders: (json["sliders"] as List<dynamic>?)?.map((e) {
        return SliderModel.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }
}
