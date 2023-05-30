import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:websocket_demo/socket_manager_class.dart';


class SocketIoDemoApp extends StatefulWidget {
  @override
  _SocketIoDemoAppState createState() => _SocketIoDemoAppState();
}

class _SocketIoDemoAppState extends State<SocketIoDemoApp> {
  SocketManager socketManager=SocketManager();
  String listenData="";
  @override
  void initState() {
    super.initState();
      socketManager.connect("<Your URL With Port Number>");

  }

  @override
  void dispose() {
    socketManager.socket?.close();
    socketManager.disconnect();
    super.dispose();
  }

  ValueNotifier<bool> isLoading=ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Socket.io Demo'),
        ),
        body:  ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context,c,v) {
            return Center(
              child: isLoading.value?const CircularProgressIndicator():Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(socketManager.socket?.connected??false?'Socket Connected':'Socket Not Connected'),
                  const SizedBox(height: 10,),
                  Text(socketManager.socketError==""?'':'Socket Error:- ${socketManager.socketError}'),
                  Text(listenData==""?'':listenData),
                  const SizedBox(height: 30,),
                  ElevatedButton(onPressed: ()async{
                    if(socketManager.socket?.disconnected??false) {
                      isLoading.value = true;

                      socketManager.connect("<Your URL With Port Number>");
                      await Future.delayed(const Duration(seconds: 2));
                      isLoading.value = false;
                    }else{
                      isLoading.notifyListeners();
                    }

                  }, child: const Text("Connect")),
                  ElevatedButton(onPressed: (){
                    socketManager.disconnect();
                    setState(() {
                    });

                  }, child: const Text("Disconnect")),
                  ElevatedButton(onPressed: (){
                    socketManager.emitEvent('<Your Event>', 124);
                    socketManager.emitEvent('<Your Event>',123);
                    setState(() {
                    });

                  }, child: const Text("Emit")),
                  ElevatedButton(onPressed: (){

                socketManager.socket?.on('<Your Event>', (data) => print('---$data'));
                    setState(() {
                    });

                  }, child: const Text("Listen")),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}