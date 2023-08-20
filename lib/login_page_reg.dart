import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'main.dart';
import 'login_page.dart';

class LoginPageReg extends StatefulWidget {
  @override
  _LoginPageRegState createState() => _LoginPageRegState();
}

class _LoginPageRegState extends State<LoginPageReg> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/inicio.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.0),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 100, 30, 1),
                child: Text(
                  'BUYEEI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PassThrough',
                    fontSize: 45,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 2.0),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 1),
                child: Text(
                  '¡Hazte socio de la comunidad y comienza \na canjear tus beneficios!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PassThrough',
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 0.0),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 70, 50, 0),
                child: Container(
                  width: 100.0,
                  height: 60.0,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0.0),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 18, 50, 0),
                child: Container(
                  height: 60.0,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(height: 0.0),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 18, 50, 6),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                    minimumSize: Size(double.infinity, 59.0),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                    'Continuar',
                    style: TextStyle(
                      fontFamily: 'PassThrough',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1.0), // Espacio entre el botón "Continuar" y los botones de iconos
              Padding(
                padding: EdgeInsets.fromLTRB(30, 1, 30, 50),
              ),
              SizedBox(height: 0.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Acción para la imagen de Facebook
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Google%20Button.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvR29vZ2xlIEJ1dHRvbi5wbmciLCJpYXQiOjE2ODkzNzc5NjksImV4cCI6MTcyMDkxMzk2OX0.WlUzuxMqQgJlpAkJ8llyqlORQ5F68KDXmGRHa0oAnJE&t=2023-07-14T23%3A39%3A29.863Z',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 110,
                      height: 110,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Acción para la imagen de Google
                    },
                    child: CachedNetworkImage(
                      imageUrl:
                      'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Facebook%20Button.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvRmFjZWJvb2sgQnV0dG9uLnBuZyIsImlhdCI6MTY4OTM3Nzk5OSwiZXhwIjoxNzIwOTEzOTk5fQ.jrhavGNw9sIdLXUNW4s4WplaAoA0UEgDngcVG9RAFyE&t=2023-07-14T23%3A39%3A59.952Z',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 110,
                      height: 110,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Acción para la imagen de Twitter
                    },
                    child: CachedNetworkImage(
                      imageUrl: 'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Twitter%20Button.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvVHdpdHRlciBCdXR0b24ucG5nIiwiaWF0IjoxNjg5Mzc4MDM3LCJleHAiOjE3MjA5MTQwMzd9.mUUkEOj8detWCcXcQ8MLR1ISrNhDnsW4ZlLC6g7eOS4&t=2023-07-14T23%3A40%3A38.238Z',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 110,
                      height: 110,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 27.0), // Espacio entre los botones de iconos y el texto "¿Ya tienes una cuenta?"
              Text(
                '¿Ya tienes una cuenta?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PassThrough',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 0.0), // Espacio entre el texto "¿Ya tienes una cuenta?" y el botón "Iniciar sesión"
              Padding(
                padding: EdgeInsets.fromLTRB(130, 15, 130, 0),
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    minimumSize: Size(double.infinity, 40.0),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                    'Inicia sesión',
                    style: TextStyle(
                      fontFamily: 'PassThrough',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 130.0),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      // Verifica las credenciales
      if (username == 'admin' && password == 'password') {
        // Credenciales válidas, redirige a la página principal
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } else {
        // Credenciales inválidas, muestra un diálogo de error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text('Usuario o contraseña incorrectos.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    });
  }
}
