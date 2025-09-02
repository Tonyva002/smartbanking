import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  //Propiedades
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAOM1s8fYyIqDH0-6C1Udgchgt5XKp5tU8';
  final storage = const FlutterSecureStorage();


  //Crear usuario
  Future<String?> createrUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    // url de firebase
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decoderResp = json.decode(resp.body);

    //Si viene el token lo almacenamos el token en local de lo contrario mostramos el error
    if (decoderResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decoderResp['idToken']);
      return null;
    } else {
      return decoderResp['error']['message'];
    }
  }
  //Validar correo y contraseña
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decoderResp = json.decode(resp.body);

    if (decoderResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decoderResp['idToken']);
      return null;
    } else {
      return decoderResp['error']['message'];
    }
  }
  // Cerrar sesion
  Future logout() async {
    // Delete value
    await storage.delete(key: 'token');
    return;

  }

  //Leer el token 
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
