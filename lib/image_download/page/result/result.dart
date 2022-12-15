import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/page/dart_object/dart_object.dart';
import 'package:image_download/image_download/page/result/result_bloc.dart';
import 'package:image_download/image_download/page/response_ob/response_ob.dart';
import 'package:image_download/image_download/page/result/result_detail.dart';
import 'package:image_download/image_download/page/result/result_show_ui.dart';

import 'package:image_download/image_download/utils/extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Result extends StatefulWidget {
  String name;
  Result(this.name);
  ResultState createState() {
    return ResultState();
  }
}

class ResultState extends State<Result> {
  final bloc = Bloc();
  RefreshController controller = RefreshController();

  @override
  void initState() {
    super.initState();
    bloc.getData(widget.name);
    bloc.getStream().listen((ResponseOb resp) {
      if (resp.msgState == MsgState.data) {
        if (resp.pageState == PageState.first) {
          controller.refreshCompleted();
        } else if (resp.pageState == PageState.load) {
          controller.loadComplete();
        }
      }
    });
  }

  List<Hits> newHitsList = [];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: StreamBuilder<ResponseOb>(
        stream: bloc.getStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (context, snapshot) {
          ResponseOb resp = snapshot.data!;
          if (resp.msgState == MsgState.data) {
            DartObject dob = resp.data;
            if (resp.pageState == PageState.first) {
              newHitsList = dob.hits!;
            }
            if (resp.pageState == PageState.load) {
              newHitsList.addAll(dob.hits!);
            }
            return SmartRefresher(
              controller: controller,
              enablePullDown: true,
              onRefresh: () {
                bloc.getData(widget.name);
              },
              enablePullUp: newHitsList.length > 19,
              onLoading: () {
                bloc.getNextData(widget.name);
              },
              child: ListView.builder(
                itemCount: newHitsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        context.push(ResultDetail(newHitsList[index]));
                      },
                      child: Column(
                        children: [
                          Text(index.toString()),
                          ResultUi(newHitsList[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (resp.msgState == MsgState.error) {
            if (resp.errState == ErrState.servierErr) {
              return const Center(
                child: Text("500\nServier Error"),
              );
            } else if (resp.errState == ErrState.noFoundErr) {
              return const Center(
                child: Text("404\nPage not Found"),
              );
            } else {
              return const Center(
                child: Text("unknown Error"),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
