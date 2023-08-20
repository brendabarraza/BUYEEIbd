import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrito_provider.dart';
import 'producto_page.dart';
import 'pago_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'auth_bloc.dart';
import 'carrito_model.dart';
import 'frutales_page.dart';

class CarritoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final carritoProvider = Provider.of<CarritoProvider>(context);
    final List<Producto> productos = carritoProvider.productos;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color(0xFF241E1E),
        child: ListView(
          children: [
            ListTile(
              title: Text('CONFIGURACION', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.settings, color: Colors.white38),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: Text('PEDIDOS', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.receipt_sharp, color: Colors.white38),
              onTap: () {
                Navigator.pushNamed(context, '/pedidos');
              },
            ),
            ListTile(
              title: Text('NOSOTROS', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.info, color: Colors.white38),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF241E1E),
        title: Text('CARRITO'),
      ),
      backgroundColor: Color(0xFF444141),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isAuthenticated) {
              final usuarioId = BlocProvider.of<AuthBloc>(context).supabaseClient.auth.user()!.id;
              return FutureBuilder<List<CarritoItem>>(
                future: _getCarritoItems(context, usuarioId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error al cargar el carrito: ${snapshot.error}');
                  } else {
                    final carritoItems = snapshot.data;
                    if (carritoItems != null && carritoItems.isNotEmpty) {
                      // Muestra los elementos del carrito
                      return ListView.builder(
                        itemCount: carritoItems.length,
                        itemBuilder: (context, index) {
                          final item = carritoItems[index];
                          return ListTile(
                            title: Text(item.nombre),
                            subtitle: Text(item.descripcion),
                            trailing: Text('\$${item.precio}\n +${item.puntos} puntos'),
                            leading: Image.network(item.image), // Carga y muestra la imagen
                          );
                        },
                      );
                    } else {
                      return Text('El carrito está vacío');
                    }
                  }
                },
              );
            } else {
              // Mostrar mensaje de inicio de sesión requerido
              return Text('Debes iniciar sesión para ver el carrito');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PagoPage(),
            ),
          );
        },
        backgroundColor: Colors.brown,
        label: Text('Continuar'),
        icon: Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  Future<List<CarritoItem>> _getCarritoItems(BuildContext context, String usuarioId) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return authBloc.getCarritoItems(usuarioId);
  }
}






