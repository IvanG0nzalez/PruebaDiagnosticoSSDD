import 'package:flutter/material.dart';

class SessionView extends StatefulWidget {
  const SessionView({Key? key}) : super(key: key);

  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _start() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        Map<String, String> data = {
          'email': _emailController.text,
          'password': _passwordController.text,
        };

        if (data['email'] == 'admin@admin.admin' &&
            data['password'] == 'admin') {
          final SnackBar msg = SnackBar(content: Text('Bienvenido, Admin'));
          ScaffoldMessenger.of(context).showSnackBar(msg);
          Navigator.pushReplacementNamed(context, '/buscar');
        } else {
          final SnackBar msg =
              SnackBar(content: Text('¡Error! Credenciales Incorrectas'));
          ScaffoldMessenger.of(context).showSnackBar(msg);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo',
                      suffixIcon: Icon(Icons.alternate_email)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese su correo';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      suffixIcon: Icon(Icons.lock)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese su contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: _start,
                    child: const Text('Iniciar Sesión'),
                  ),
                ),
              ]
            )
          )
        )
      )
    );
  }
}
