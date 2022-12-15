import 'package:flutter/material.dart';
import 'package:image_download/image_download/home/home.dart';
import 'package:image_download/image_download/utils/extension.dart';

class Advertisement extends StatefulWidget {
  @override
  AdvertisementState createState() {
    return AdvertisementState();
  }
}

class AdvertisementState extends State<Advertisement> {
  @override
  void initState() {
    super.initState();
    goTo();
  }

  goTo() {
    Future.delayed(const Duration(seconds: 2), () {
      context.pushEnd(const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/photo.png"), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
