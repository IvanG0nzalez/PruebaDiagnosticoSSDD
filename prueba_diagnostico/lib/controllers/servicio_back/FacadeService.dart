import 'package:prueba_diagnostico/controllers/Conexion.dart';
import 'package:prueba_diagnostico/controllers/servicio_back/RespuestaGenerica.dart';

class FacadeService {
  Conexion c = Conexion();
  Future<RespuestaGenerica> listar_lugares() async {
    return await c.solicitudGet("lugares", false);
  }

  Future<RespuestaGenerica> listar_lugares_por_tipo(String? tipo) async {
    return await c.solicitudGet("lugares/$tipo", false);
  }
}