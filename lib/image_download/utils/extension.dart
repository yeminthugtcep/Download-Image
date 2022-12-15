import 'package:flutter/material.dart';

extension goTo on BuildContext {
  Future<dynamic> push(Widget widget) async {
    return await Navigator.of(this).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  Future<dynamic> pushEnd(Widget widget) async {
    return await Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return widget;
    }), (route) => false);
  }
}
