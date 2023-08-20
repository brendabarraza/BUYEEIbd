import 'package:flutter/material.dart';
import 'producto_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'carrito_model.dart'; // Importa el modelo de datos si lo necesitas
import 'producto_model.dart'; // Asegúrate de importar el modelo de datos si lo necesitas

class CremososPage extends StatefulWidget {
  final SupabaseClient supabaseClient;

  CremososPage({required this.supabaseClient});

  @override
  _CremososPageState createState() => _CremososPageState();
}

class _CremososPageState extends State<CremososPage> {
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    _fetchProductos();
  }

  Future<void> _fetchProductos() async {
    final response = await widget.supabaseClient.from('cremosos').select().execute();

    if (response.error != null) {
      print('Error al obtener los productos desde Supabase: ${response.error}');
      return;
    }

    final productosData = response.data as List<dynamic>;

    final productosList = productosData.map((data) => Producto(
      titulo: data['nombre'] as String,
      descripcion: data['descripcion'] as String,
      precio: data['precio'] as double,
      puntos: data['puntos'] as int,
      imagen: data['imagen'] as String,
      ima: data['ima'] as String,
    )).toList();

    print('Productos obtenidos desde Supabase: $productosList');

    setState(() {
      productos = productosList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helados Cremosos'),
        backgroundColor: Color(0xFF241E1E),
      ),
      backgroundColor: Color(0xFF362618),
      body: productos.isEmpty // Verifica si la lista de productos está vacía
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        mainAxisSpacing: 20, // Espaciado vertical entre filas
        crossAxisSpacing: 10, // Espaciado horizontal entre columna
        children: productos.map((producto) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductoPage(producto: producto),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4, // Tamaño de la tarjeta
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.44, // Establece la altura de la imagen
                    child: CachedNetworkImage(
                      imageUrl: producto.imagen,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            producto.titulo,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${producto.precio.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

