import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  IO.Socket? socket;
  String socketError = "";

  void connect(String serverUrl) {
    try {
      socket = IO.io(serverUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'timeout': 5000,
      });
      socket?.on('connect', (_) => _onConnect(_));
      socket?.on('disconnect', (_) => _onDisconnect());
      socket?.on('error', (data) => _onError(data));

      socket?.connect();
    } catch (e) {
      socketError = e.toString();
    }
  }

  static void _onConnect(dynamic data) {
    if (kDebugMode) {
      print('Connected to Socket.io server!');
    }
    // Perform any additional actions on connect
  }

  static void _onDisconnect() {
    if (kDebugMode) {
      print('Disconnected from Socket.io server!');
    }
    // Perform any additional actions on disconnect
  }

  static void _onError(dynamic error) {
    if (kDebugMode) {
      print('Socket.io error: $error');
    }
    // Handle Socket.io errors
  }

  void emitEvent(String eventName, dynamic data) {
    if (socket?.connected ?? false) {
      try {
        socket?.emit(eventName, data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (kDebugMode) {
        print('Socket not connected!');
      }
    }
  }

  void disconnect() {
    try {
      if (socket?.connected ?? false) {
        socket?.disconnect();
      }
    } catch (e) {
      socketError = e.toString();
    }
  }
}
