import 'dart:async';
import 'package:image_download/image_download/page/dart_object/dart_object.dart';
import 'package:image_download/image_download/page/response_ob/response_ob.dart';
import 'package:image_download/image_download/utils/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bloc {
  StreamController<ResponseOb> _streamController =
      StreamController<ResponseOb>.broadcast();
  Stream<ResponseOb> getStream() => _streamController.stream;

  int page = 1;
  getData(String nameText) async {
    page = 1;
    ResponseOb resp = ResponseOb(msgState: MsgState.loading);
    //_streamController.sink.add(resp);
    var response = await http
        .get(Uri.parse(API + "?key=" + KEY + "&q=" + nameText + "&page=$page"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      //print(map);
      DartObject dob = DartObject.fromJson(map);
      print(
          dob); //instance of 'DartObject'=> ငါတို့ လိုချင်တဲ့ dartObjectကနေ ယူသုံးလို့ရအောင် လုပ်ပေးတာ
      resp.msgState = MsgState.data;
      resp.pageState = PageState.first;
      resp.data = dob;
      _streamController.sink.add(resp);
    } else if (response.statusCode == 500) {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.servierErr;
      _streamController.sink.add(resp);
    } else if (response.statusCode == 404) {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.noFoundErr;
      _streamController.sink.add(resp);
    } else {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.unknownErr;
      _streamController.sink.add(resp);
    }
  }

  getNextData(String nameText) async {
    page++;
    ResponseOb resp = ResponseOb(msgState: MsgState.loading);
    // _streamController.sink.add(resp);
    var response = await http
        .get(Uri.parse(API + "?key=" + KEY + "&q=" + nameText + "&page=$page"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      //print(map);
      DartObject dob = DartObject.fromJson(map);
      print(
          dob); //instance of 'DartObject'=> ငါတို့ လိုချင်တဲ့ dartObjectကနေ ယူသုံးလို့ရအောင် လုပ်ပေးတာ
      resp.msgState = MsgState.data;
      resp.pageState = PageState.load;
      resp.data = dob;
      _streamController.sink.add(resp);
    } else if (response.statusCode == 500) {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.servierErr;
      _streamController.sink.add(resp);
    } else if (response.statusCode == 404) {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.noFoundErr;
      _streamController.sink.add(resp);
    } else {
      resp.msgState = MsgState.error;
      resp.errState = ErrState.unknownErr;
      _streamController.sink.add(resp);
    }
  }

  dispose() {
    _streamController.close();
  }
}
