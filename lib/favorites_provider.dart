import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'producto_page.dart';
import 'package:supabase/supabase.dart';
import 'package:provider/provider.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Producto> _productosFavoritos = [];
  List<Producto> get productos => _productosFavoritos;

  Future<void> agregarProductoFavorito(Producto producto) async {
    final supabaseClient = Supabase.instance.client;
    final usuarioId = supabaseClient.auth.currentUser!.id;

    final response = await supabaseClient.from('favorites').upsert([
      {
        'nombre': producto.titulo,
        'descripcion': producto.descripcion,
        'puntos': producto.puntos,
        'precio': producto.precio,
        'imagen': producto.imagen,
        'usuario': usuarioId,
      }
    ]).execute();

    if (response.error != null) {
      print('Error al agregar el producto favorito: ${response.error}');
    } else {
      print('Producto favorito agregado correctamente');
    }
  }

  Future<void> eliminarProductoFavorito(Producto producto) async {
    final supabaseClient = Supabase.instance.client;
    final usuarioId = supabaseClient.auth.currentUser!.id;

    final response = await supabaseClient.from('favorites')
        .delete()
        .eq('nombre', producto.titulo)
        .eq('usuario', usuarioId)
        .execute();

    if (response.error != null) {
      print('Error al eliminar el producto favorito: ${response.error}');
    } else {
      print('Producto favorito eliminado correctamente');
    }
  }
}
