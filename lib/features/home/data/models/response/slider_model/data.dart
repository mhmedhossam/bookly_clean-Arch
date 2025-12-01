import 'package:bookia/features/home/data/models/response/slider_model/slider.dart';

class Data {
  List<SliderModel>? sliders;

  Data({this.sliders});

  factory Data.fromjson(json) {
    return Data(
      sliders: (json["sliders"] as List<dynamic>?)?.map((e) {
        return SliderModel.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }
}
