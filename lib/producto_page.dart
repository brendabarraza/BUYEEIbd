import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrito_page.dart';
import 'carrito_provider.dart';
import 'producto_page.dart';
import 'favorites_provider.dart'; // Importa la página FavoritesPage
import 'favorites_page.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Importa CachedNetworkImage
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Producto {
  final String titulo;
  final String descripcion;
  final double precio;
  final int puntos;
  final String imagen;
  final String ima;

  Producto({
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.puntos,
    required this.imagen,
    required this.ima,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(),
      puntos: json['puntos'],
      imagen: json['imagen'],
      ima: json['ima'],
    );
  }
}

class ProductoPage extends StatefulWidget {
  final Producto producto;
  ProductoPage({required this.producto});
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  bool isFavorite = false;

  Future<void> _agregarProductoAFavoritos(Producto producto) async {
    final supabaseClient = Supabase.instance.client;
    final usuarioId = supabaseClient.auth.currentUser!.id;

    final userResponse = await supabaseClient
        .from('users')
        .select('favorites')
        .eq('id', usuarioId)
        .single()
        .execute();

    if (userResponse.error != null) {
      print('Error al obtener los favoritos del usuario: ${userResponse.error}');
      return;
    }
    final currentFavorites = userResponse.data['favorites'] as List<dynamic>;
    final updatedFavorites = [...currentFavorites, producto.titulo];

    final updateResponse = await supabaseClient
        .from('users')
        .upsert([
      {
        'id': usuarioId,
        'favorites': updatedFavorites,
      }
    ])
        .execute();
    if (updateResponse.error != null) {
      print('Error al agregar el producto a favoritos en Supabase: ${updateResponse.error}');
    } else {
      print('Producto agregado a favoritos en Supabase: $producto');
    }
  }



  Future<void> _eliminarProductoDeFavoritos(Producto producto) async {
    final supabaseClient = Supabase.instance.client;
    final usuarioId = supabaseClient.auth.currentUser!.id;

    final response = await supabaseClient
        .from('favorites')
        .delete()
        .eq('nombre', producto.titulo)
        .eq('usuario', usuarioId)
        .execute();

    if (response.error != null) {
      print('Error al eliminar el producto de favoritos en Supabase: ${response.error}');
    } else {
      print('Producto eliminado de favoritos en Supabase: $producto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        backgroundColor: Color(0xFF241E1E),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () async {
              setState(() {
                isFavorite = !isFavorite;
              });
              if (isFavorite) {
                await _agregarProductoAFavoritos(widget.producto);
              } else {
                await _eliminarProductoDeFavoritos(widget.producto);
              }
            },
          )
        ],
      ),
      backgroundColor: Color(0xFF000000),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.producto.ima),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.producto.titulo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  widget.producto.descripcion,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  '\$${widget.producto.precio.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Puntos: ${widget.producto.puntos}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    final carritoProvider = context.read<CarritoProvider>();
                    carritoProvider.agregarProducto(widget.producto);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarritoPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white), // Icono del carrito
                      SizedBox(width: 8), // Espacio entre el icono y el texto
                      Text(
                        'Agregar al carrito',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

