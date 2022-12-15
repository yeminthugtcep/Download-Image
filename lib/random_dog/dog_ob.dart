class DartObject {
  String? message;
  String? status;
  DartObject(Map<String, dynamic> map) {
    message = map["message"];
    status = map["status"];
  }
}
