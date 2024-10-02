import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:prueba_diagnostico/controllers/servicio_back/RespuestaGenerica.dart';
import 'dart:convert';

class Conexion {
  final String URL = "http://10.20.139.199:3000/api/";

  Future<RespuestaGenerica> solicitudGet(String recurso, bool token) async {
    Map<String, String> _header = {'Content-Type': 'application/json'};

    final String _url = URL + recurso;
    final uri = Uri.parse(_url);
    try {
      final response = await http.get(uri, headers: _header);
      log(response.body);
      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          return _response(404, "Recurso no encontrado", []);
        } else {
          Map<dynamic, dynamic> mapa = jsonDecode(response.body);
          return _response(mapa['code'], mapa['msg'], mapa['datos']);
        }
      } else {
        Map<dynamic, dynamic> mapa = jsonDecode(response.body);
        return _response(mapa['code'], mapa['msg'], mapa['datos']);
      }
    } catch (e) {
      return _response(500, "Error inesperado", []);
    }
  }

  RespuestaGenerica _response(int code, String msg, dynamic data) {
    var respuesta = RespuestaGenerica();
    respuesta.code = code;
    respuesta.datos = data;
    respuesta.msg = msg;
    return respuesta;
  }
}
