import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_download/image_download/page/result/result_bloc.dart';
import 'package:image_download/image_download/page/result/result.dart';
import 'package:image_download/image_download/utils/extension.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  SearchState createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  final _isCheck = GlobalKey<FormState>();
  final _nameText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("Home")),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _isCheck,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _nameText,
                validator: (value) =>
                    value?.isNotEmpty == true ? null : "required name",
                decoration: InputDecoration(
                  hintText: "enter name",
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
              onPressed: () {
                bool isCheck = _isCheck.currentState!.validate();
                if (isCheck) {
                  print(_nameText.text);
                  context.push(Result(_nameText.text)).then((value) {
                    _nameText.clear();
                  });
                }
                return;
              },
              child: const Text("get image"),
            ),
          ]),
        ),
      ),
    );
  }
}
