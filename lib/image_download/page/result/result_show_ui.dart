import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/page/dart_object/dart_object.dart';

class ResultUi extends StatefulWidget {
  Hits hits;
  ResultUi(this.hits);
  ResultUiState createState() {
    return ResultUiState();
  }
}

class ResultUiState extends State<ResultUi> {
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.hits.webformatURL.toString(),
      child: CachedNetworkImage(
        imageUrl: widget.hits.webformatURL.toString(),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
