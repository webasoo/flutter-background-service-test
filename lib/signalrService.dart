import 'dart:io';

import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalrService {
  static final SignalrService _singleton = SignalrService._internal();
  factory SignalrService() {
    return _singleton;
  }

  SignalrService._internal();

  String _serverUrl = "https://server.com/apphub";
  HubConnection? _hubConnection;

  HubConnection get hubConnection {
    _hubConnection ??= HubConnectionBuilder()
        .withUrl(
            _serverUrl,
            HttpConnectionOptions(
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              accessTokenFactory: () async {
                return token;
              },
              logging: (level, message) => print(message),
            ))
        .withAutomaticReconnect()
        .build();
    return _hubConnection!;
  }

  bool _connectionIsOpen = false;
  bool get connectionIsOpen => _connectionIsOpen;
  set connectionIsOpen(bool v) {
    _connectionIsOpen = v;
  }

  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJUb2tlbklkIjoiZmEzOTM0OWZhNGE5NDY3MGJmOGFjNGNlOTFlNDQ3NjUiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMTAwIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZ2l2ZW5uYW1lIjoi2LPbjNivINqp2YXYp9mEICIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3N1cm5hbWUiOiLYs9in2KzYr9uMINix2KfYryIsIk5hdGlvbmFsTm8iOiIyMjk4NTk0MDQxIiwiVG9rZW5Jc3N1ZURhdGVUaW1lIjoiNS8yOC8yMDIzIDU6NTI6MzkgUE0iLCJUb2tlbkV4cGlyYXRpb25EYXRlVGltZSI6IjYvMTEvMjAyMyA1OjUyOjM5IFBNIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlBpc2hnYW1hblRyYW5zcG9ydF9NYW5hZ2VtZW50RGFzaGJvYXJkIiwiUGlzaGdhbWFuVHJhbnNwb3J0X09wZXJhdGlvbmFsVXNlcnMiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVHJlYXR5U3VwZXJ2aXNvciIsIlBpc2hnYW1hblRyYW5zcG9ydF9UcmFuc3BvcnRhdGlvbkNvbXBhbnlUeXBlIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1RyYW5zcG9ydGF0aW9uVW5pdCIsIlBpc2hnYW1hblRyYW5zcG9ydF9QaWNrdXBMb2NhdGlvbiIsIlBpc2hnYW1hblRyYW5zcG9ydF9UcmFuc3BvcnRhdGlvbkNvbXBhbnkiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVmVoaWNsZXNNYW5hZ2VtZW50IiwiUGlzaGdhbWFuVHJhbnNwb3J0X1ZlaGljbGVVc2VyVHlwZSIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlU2l0dWF0aW9uIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1ZlaGljbGVTeXN0ZW0iLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVmVoaWNsZVVzZXJzTWFuYWdlbWVudCIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlQ2F0ZWdvcnkiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVmVoaWNsZVN0YXR1cyIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlQ29sb3IiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVmVoaWNsZUJvZHlTdGF0dXMiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfT3duZXJzaGlwVHlwZSIsIlBpc2hnYW1hblRyYW5zcG9ydF9Eb2N1bWVudFN0YXR1cyIsIlBpc2hnYW1hblRyYW5zcG9ydF9DYXJCcmlnYWQiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfQ29tcGFueU9wZXJhdG9ydHlwZSIsIkNvdW50cnkiLCJQZXJtaXNzaW9uIiwiU2V0dGluZyIsIk9yZ0NoYXJ0IiwiU3RhdGUiLCJDaXR5IiwiUGVyc29uZWwiLCJMaWNlbnNlVHlwZSIsIkxpY2Vuc2UiLCJNYXJpdGFsU3RhdHVzIiwiVGFiX0NvbnRhY3RJbmZvIiwiTG9jYXRpb25BcmVhIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1ZlaGljbGVUeXBlIiwiUGVyc29uZWxDb2RpbmciLCJQaXNoZ2FtYW5UcmFuc3BvcnRfRHJvcE9mZkxvY2F0aW9uIiwiQ29tbXVuaWNhdGlvblVzZXIiLCJDb21tdW5pY2F0aW9uTGFiZWwiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfUGF5bWVudFJlcG9ydHMiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfU2VydmljZUV4cGVydGlzZSIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlU2V0dGluZyIsIlBpc2hnYW1hblRyYW5zcG9ydF9Qb2ludFRyYW5zcG9ydGF0aW9uIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1JvdXRlVHJhbnNwb3J0YXRpb24iLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVGF4aU1hbmFnZW1lbnRTZXR0bGVtZW50SW5mbyIsIlBpc2hnYW1hblRyYW5zcG9ydF9XaXRoZHJhd2FsUmVxdWVzdCIsIlBpc2hnYW1hblRyYW5zcG9ydF9XaXRoZHJhd2FsUmVxdWVzdENvbmZpcm1hdGlvbiIsIlBpc2hnYW1hblRyYW5zcG9ydF9XYWxsZXRNYW5hZ2VtZW50IiwiUGlzaGdhbWFuVHJhbnNwb3J0X1NwZWNUeXBlQ2F0ZWdvcnkiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfVmVoaWNsZVNlcmllIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1ZlaGljbGVNb2RlbCIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlRXF1aXBtZW50TWFuYWdlbWVudCIsIlBpc2hnYW1hblRyYW5zcG9ydF9WZWhpY2xlRnVlbENhcmRNYW5hZ2VtZW50IiwiUGlzaGdhbWFuVHJhbnNwb3J0X1ZlaGljbGVQYXJ0cyIsIlBpc2hnYW1hblRyYW5zcG9ydF9GdWVsVHlwZSIsIlBpc2hnYW1hblRyYW5zcG9ydF9GdWVsQ2FyZFVzZXJUeXBlIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1NhbGVSZXBvcnRzIiwiUGlzaGdhbWFuVHJhbnNwb3J0X1dpdGhkcmF3YWxSZXF1ZXN0UGF5bWVudCIsIlBpc2hnYW1hblRyYW5zcG9ydF9TcGVjVHlwZSIsIlBpc2hnYW1hblRyYW5zcG9ydF9NaXNzaW9uU2V0dGxlbWVudERldGFpbFJlcG9ydHMiLCJQaXNoZ2FtYW5UcmFuc3BvcnRfSm9iTG9nSGlzdG9yeSIsIlBpc2hnYW1hblRyYW5zcG9ydF9Hb29kIl0sImV4cCI6MTY4NjUwNTk1OX0.QBjr1oMkxWl2QbHKKvJTxXQz2u5iB8lEm85rvO-XzFw";

  Future<HubConnection> openHubConnection() async {
    _hubConnection!.onclose((exception) {
      connectionIsOpen = false;
    });
    _hubConnection!.onreconnecting((error) {
      print("onreconnecting called");
      connectionIsOpen = false;
    });
    _hubConnection!.onreconnected((connectionId) {
      print("onreconnected called");
      connectionIsOpen = true;
    });

    if (_hubConnection!.state != HubConnectionState.connected) {
      await _hubConnection!.start();
      connectionIsOpen = true;
    }
    return _hubConnection!;
  }

  void _httpClientCreateCallback(HttpClient httpClient) {
    HttpOverrides.global = DevHttpOverrides();
  }
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
