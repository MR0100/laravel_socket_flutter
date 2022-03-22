import 'package:flutter/material.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as SocketIO;

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  Echo echo = Echo({
    'broadcaster': 'socket.io',
    'host': 'http://selectivesignals.us:6001',
    'client': SocketIO.io
  });
  connectWithSocket() {
    /// CHANNEL LISTENNING...
    echo.channel('chat-channel').listen('.ChatEvent', (e) {
      print(e);
    }).error(() {
      print('error');
    }).notification(() {
      print('notify');
    });

    // /// DIRECT LISTENNING...
    // echo.listen('chat-channel', '.ChatEvent', (e) {
    //   print(e);
    // });

// Accessing socket instance
    echo.socket.on('connect', (_) => print('connected'));
    echo.socket.on('disconnect', (_) => print('disconnected'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          connectWithSocket();
        },
        child: const Icon(Icons.connect_without_contact),
      ),
    );
  }
}
