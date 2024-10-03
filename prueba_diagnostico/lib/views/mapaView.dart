import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

class MapaView extends StatefulWidget {
  final String lugar;
  final List<dynamic> puntos;

  const MapaView({Key? key, required this.lugar, required this.puntos})
      : super(key: key);

  @override
  _MapaViewState createState() => _MapaViewState();
}

class _MapaViewState extends State<MapaView> with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de ${widget.lugar}'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 227, 206, 251),
          ),
          child: Text(
            'Menú',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        const ListTile(
          title: Text(
            "Lugares Encontrados",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            "(Presione sobre el lugar para verlo en el mapa)",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ),
        for (var lugar in widget.puntos)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            color: Colors.grey[200],
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.black26),
            ),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${lugar['nombre']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latitud: ${lugar['latitud']} \nLongitud: ${lugar['longitud']}",
                    style: const TextStyle(fontSize: 11),
                  )
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                _centrarMapa(
                  double.parse(lugar['latitud'].toString()),
                  double.parse(lugar['longitud'].toString()),
                );
              },
            ),
          )
      ])),
      body: FutureBuilder<MapOptions>(
        future: _crearMapOptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return FlutterMap(
                mapController: _animatedMapController.mapController,
                options: snapshot.data!,
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: _crearMarcadores(widget.puntos),
                  ),
                  PosicionUsuarioWidget(_animatedMapController),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(
                  child: Text('No se encontran lugares de interés.'));
            }
          }
        },
      ),
    );
  }

  Future<LatLng> posicion_actual() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double latitud = position.latitude;
    double longitud = position.longitude;

    return LatLng(latitud, longitud);
  }

  Future<MapOptions> _crearMapOptions() async {
    LatLng centro = await posicion_actual();
    return MapOptions(
      initialCenter: centro,
      initialZoom: 17.0,
    );
  }

  List<Marker> _crearMarcadores(List<dynamic> puntos) {
    return puntos.map((punto) {
      double latitud = double.parse(punto['latitud']);
      double longitud = double.parse(punto['longitud']);

      return Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(latitud, longitud),
        child: IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: () {
            _mostrarInfoPunto(punto);
            _centrarMapa(latitud, longitud);
          },
        ),
      );
    }).toList();
  }

  void _mostrarInfoPunto(Map<String, dynamic> punto) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${punto['nombre']}'),
          content: Text(
              'Latitud: ${punto['latitud']} \nLongitud: ${punto['longitud']}',
              style: const TextStyle(fontSize: 12)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _centrarMapa(double latitud, double longitud) {
    _animatedMapController.animateTo(
      dest: LatLng(latitud, longitud),
      zoom: 17.0,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}

class PosicionUsuarioWidget extends StatefulWidget {
  final AnimatedMapController animatedMapController;

  const PosicionUsuarioWidget(this.animatedMapController, {Key? key}) : super(key: key);

  @override
  _PosicionUsuarioWidgetState createState() => _PosicionUsuarioWidgetState();
}

class _PosicionUsuarioWidgetState extends State<PosicionUsuarioWidget> {
  LatLng? _posicionUsuario;
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _iniciarSeguimientoPosicion();
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  void _iniciarSeguimientoPosicion() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _posicionUsuario = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _posicionUsuario != null
        ? MarkerLayer(markers: [
            Marker(
              point: _posicionUsuario!,
              width: 40.0,
              height: 40.0,
              child: Tooltip(
                message: 'Mi ubicación',
                child: Icon(
                  Icons.my_location,
                  color: Colors.red.shade300,
                  size: 40,
                ),
              ),
            ),
          ])
        : Container();
  }
}
