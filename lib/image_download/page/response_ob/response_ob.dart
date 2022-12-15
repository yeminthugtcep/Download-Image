class ResponseOb {
  MsgState? msgState;
  ErrState? errState;
  PageState? pageState;
  dynamic data;
  ResponseOb({this.errState, this.msgState, this.pageState});
}

enum MsgState { loading, data, error, other }

enum ErrState { servierErr, noFoundErr, unknownErr }

enum PageState { first, load, noMore }
