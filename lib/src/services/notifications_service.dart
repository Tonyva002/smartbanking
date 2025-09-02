

import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  //Para manejar los mensajes de la aplicacion
  static showSnackbar( String message) {

    final snackBar = SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}