import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'auth_bloc.dart';
import 'auth_state.dart';
import 'carrito_model.dart';
import 'producto_page.dart';
import 'carrito_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'favorites_model.dart';
import 'producto_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'auth_bloc.dart';
import 'auth_state.dart';
import 'carrito_model.dart';
import 'producto_page.dart' as Productos; // Usa un prefijo para diferenciarlo
import 'favorites_provider.dart' as Favoritos; // Usa un prefijo para diferenciarlo
import 'carrito_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'favorites_model.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<Favoritos.FavoritesProvider>(context);
    final List<Productos.Producto> productos = favoritesProvider.productos;
    final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);


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
        title: Text('FAVORITOS'),
      ),
      backgroundColor: Color(0xFF444141),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.isAuthenticated) {
              final usuarioId = BlocProvider.of<AuthBloc>(context).supabaseClient.auth.user()!.id;
              return FutureBuilder<List<FavoritesItem>>(
                future: _getFavoritesItems(context, usuarioId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error al cargar tus favoritos: ${snapshot.error}');
                  } else {
                    final favoritesItems = snapshot.data;
                    if (favoritesItems != null && favoritesItems.isNotEmpty) {
                      return ListView.builder(
                        itemCount: favoritesItems.length,
                        itemBuilder: (context, index) {
                          final item = favoritesItems[index];
                          return ListTile(
                            title: Text(item.nombre),
                            subtitle: Text(item.descripcion),
                            leading: Image.network(item.imagen), // Carga y muestra la imagen
                            trailing: GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '\$${item.precio.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
    );
  }

  Future<List<FavoritesItem>> _getFavoritesItems(BuildContext context, String usuarioId) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    if (usuarioId != null) {
      return authBloc.getFavoritesItems(usuarioId);
    } else {
      // Handle the case when usuarioId is null
      return [];
    }
  }
}











/*  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final List<Producto> productos = favoritesProvider.productos;
    final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);

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
        title: Text('FAVORITOS'),
      ),
      backgroundColor: Color(0xFF444141),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          Producto producto = productos[index];
          return Dismissible(
            key: Key(producto.titulo),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              favoritesProvider.eliminarProductoFavorito(producto);
            },
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: producto.imagen,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 50,
                height: 50,
              ),
              title: Text(
                producto.titulo,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                producto.descripcion,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              trailing: GestureDetector(
                onTap: () {
                  carritoProvider.agregarProducto(producto);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${producto.precio.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/