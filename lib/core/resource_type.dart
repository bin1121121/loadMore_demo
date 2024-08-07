class ResourceType {
  static const int requestDisconnect = -1;
  static const int requestNullData = 0;
  static const int requestConnectTimeout = 1;
  static const int requestSendTimeout = 2;
  static const int requestReceiveTimeout = 3;
  static const int requestCancel = 4;
  static const int requestResponse = 5;

  static const int requestSuccess = 200;
  static const int requestErrorServer = 500;
  static const int requestErrorToken = 401;
}
