# websocket_demo

A new Flutter project.


## Add this package into your project.
socket_io_client: ^2.1.0

#### Copy socket_manager_class.dart file and past in your project

### create object of SocketManager Class.


#### for connect with your server use this.
socketManager.connect("<Your URL With Port Number>");


#### for disconnect socket use this method. 
socketManager.disconnect();

#### for emit use this method.
socketManager.emitEvent('<Your Event>', 124);

### for listen any event use this.
socketManager.socket?.on('<Your Event>', (data) => print('---$data'));