import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart'; // Importa solo la biblioteca de provider
import 'puntos_provider.dart';
import 'auth_bloc.dart';
import 'auth_state.dart';
import 'main.dart';
import 'login_page_reg.dart';
import 'user_state.dart'; // Importa la clase UserState

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            final authBloc = BlocProvider.of<AuthBloc>(context);
            final puntosProvider = context.read<PuntosProvider>();
            puntosProvider.setUserId(authBloc.currentUser?.id);
            final userState = context.read<UserState>();
            print('User ID: ${authBloc.currentUser?.id}'); // Imprimir el User ID
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          bool _isLoading = state.isAuthenticated;

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/inicio.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
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
                        controller: _emailController,
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
                      onPressed: _isLoading ? null : () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final userState = Provider.of<UserState>(context, listen: false);
                        final success = await BlocProvider.of<AuthBloc>(context).signIn(email, password);
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Credenciales incorrectas'),
                          ));
                        }
                      },
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
                  SizedBox(height: 1.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 1, 30, 50),
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        minimumSize: Size(double.infinity, 0.0),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                        '¿Olvidaste tu contraseña?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PassThrough',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
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
                          imageUrl:
                          'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Twitter%20Button.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvVHdpdHRlciBCdXR0b24ucG5nIiwiaWF0IjoxNjg5Mzc4MDM3LCJleHAiOjE3MjA5MTQwMzd9.mUUkEOj8detWCcXcQ8MLR1ISrNhDnsW4ZlLC6g7eOS4&t=2023-07-14T23%3A40%3A38.238Z',
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: 110,
                          height: 110,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.0),
                  Text(
                    '¿Aun no tienes una cuenta?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PassThrough',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(130, 15, 130, 0),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPageReg()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        minimumSize: Size(double.infinity, 40.0),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                        'Registrate',
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
          );
        },
      ),
    );
  }
}

