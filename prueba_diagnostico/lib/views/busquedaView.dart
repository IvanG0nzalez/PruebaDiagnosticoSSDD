import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:prueba_diagnostico/controllers/servicio_back/FacadeService.dart';
import 'package:prueba_diagnostico/views/mapaView.dart';

class BusquedaView extends StatefulWidget {
  const BusquedaView({Key? key}) : super(key: key);

  @override
  _BusquedaViewState createState() => _BusquedaViewState();
}

class _BusquedaViewState extends State<BusquedaView> {
  List<String> lugares = [
    'Parques',
    'Hoteles',
    'Iglesias',
    'Museos',
    'Micromercados',
    'Restaurantes'
  ];
  
  String? _lugarSeleccionado;

  List<dynamic> lugares_encontrados = [];
  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Lugares de Interés'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Selecciona un Lugar de Interés',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lugares.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile<String>(
                      title: Text(lugares[index]),
                      value: lugares[index],
                      groupValue: _lugarSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _lugarSeleccionado = value;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
              _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                onPressed: _lugarSeleccionado == null
                    ? null
                    : () {
                        _buscarLugares(_lugarSeleccionado);
                      },
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buscarLugares(String? tipo) {

    setState(() {
      _isLoading = true;
    });

    FacadeService facadeService = FacadeService();
    facadeService.listar_lugares_por_tipo(tipo).then((value) {
      setState(() {
        _isLoading = false;
    });
    
    log(value.datos.toString());

    if (value.code == 200 && value.datos.isNotEmpty) {
      setState(() {
        lugares_encontrados = value.datos;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapaView(
              lugar: _lugarSeleccionado!,
              puntos: lugares_encontrados,
            ),
          ),
        );
      });
    } else {
      log("No se encontraron lugares o error en la solicitud");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontraron lugares o error en la solicitud")),
      );
    }
  }).catchError((error) {
    setState(() {
      _isLoading = false;
    });
    log("Error en la solicitud: $error");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error en la solicitud al servidor")),
    );
  });
  }
}
