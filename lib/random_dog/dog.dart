import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class RandomDog extends StatefulWidget {
  const RandomDog({super.key});

  @override
  RandomDogState createState() {
    return RandomDogState();
  }
}

class RandomDogState extends State<RandomDog> {
  String api = "https://dog.ceo/api/breeds/image/random";
  String imageUrl = "";
  String showPercentage = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Dog image"),
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          height: 300,
          width: double.infinity,
          color: Colors.white,
          child: imageUrl.isEmpty
              ? const Center(
                  child: Text(
                    'no image',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : showImage(),
        ),
        ElevatedButton(
          onPressed: getImage,
          child: const Text("get image"),
        ),
        ElevatedButton(
          onPressed: download,
          child: const Text("download image"),
        ),
        Container(
          height: 20,
          child: LiquidLinearProgressIndicator(
            value: int.parse(showPercentage) / 100, // Defaults to 0.5.
            valueColor: const AlwaysStoppedAnimation(
                Colors.green), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors
                .white, // Defaults to the current Theme's backgroundColor.
            borderColor: Colors.blue,
            borderWidth: 5.0,
            borderRadius: 12.0,
            direction: Axis
                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
            center: Text(showPercentage + "%"),
          ),
        )
      ]),
    );
  }

  getImage() async {
    var response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      imageUrl = map["message"];
      setState(() {});
      print(imageUrl);
    }
  }

  Widget showImage() {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }

  download() async {
    var response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (count, total) {
        double percentage = (count / total) * 100;
        print(percentage.toStringAsFixed(0));
        setState(() {
          showPercentage = percentage.toStringAsFixed(0);
        });
        if (percentage == 100) {
          showPercentage = "0";
          setState(() {});
        }
      },
    );
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "theint");
    print(result);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blue, content: Text("download successfully")));
  }
}
