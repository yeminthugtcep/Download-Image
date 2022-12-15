import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/page/dart_object/dart_object.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class ResultDetail extends StatefulWidget {
  Hits hits;
  ResultDetail(this.hits);
  ResultDetailState createState() {
    return ResultDetailState();
  }
}

class ResultDetailState extends State<ResultDetail> {
  String showCount = "0";
  bool isDownload = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hits.user.toString()),
        centerTitle: true,
      ),
      body: ListView(children: [
        Card(
          child: Hero(
            tag: widget.hits.webformatURL.toString(),
            child: CachedNetworkImage(
              imageUrl: widget.hits.webformatURL.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                    widget.hits.userImageURL.toString(),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.hits.user.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Photo Type : ${widget.hits.type}"),
              ),
              Text("Tags : ${widget.hits.tags}"),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(widget.hits.likes.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.comment,
                        color: Colors.green,
                      ),
                      Text(widget.hits.comments.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                      Text(widget.hits.views.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.download,
                        color: Colors.orange,
                      ),
                      Text(widget.hits.downloads.toString()),
                    ],
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              !isDownload
                  ? Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.green)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ))),
                        onPressed: Download,
                        child: const Text("Download"),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: DownloadPercentage(),
                      ),
                    ),
            ],
          ),
        ),
      ]),
    );
  }

  Download() async {
    setState(() {
      isDownload = true;
    });
    var response = await Dio().get(
      widget.hits.webformatURL.toString(),
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (count, total) {
        double percentage = (count / total) * 100;
        print(percentage.toStringAsFixed(0));
        setState(() {
          showCount = percentage.toStringAsFixed(0);
        });
        if (percentage == 100) {
          setState(() {
            isDownload = false;
            showCount = "0";
          });
        }
      },
    );
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "theint");
    print(result);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Download successfully")));
  }

  Widget DownloadPercentage() {
    return LiquidCircularProgressIndicator(
      value: int.parse(showCount) / 100, // Defaults to 0.5.
      valueColor: const AlwaysStoppedAnimation(
          Colors.blue), // Defaults to the current Theme's accentColor.
      backgroundColor:
          Colors.white, // Defaults to the current Theme's backgroundColor.
      borderColor: Colors.green,
      borderWidth: 5.0,
      direction: Axis
          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
      center: Text("$showCount%"),
    );
  }
}
