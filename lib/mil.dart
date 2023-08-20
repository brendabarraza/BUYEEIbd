import 'package:flutter/material.dart';
import 'puntos_provider.dart';
import 'package:provider/provider.dart';
import 'carrito_provider.dart';
import 'carrito_page.dart';
import 'producto_page.dart';
import 'frutales_page.dart';

class Mil extends StatelessWidget {
  final List<List<dynamic>> items;

  Mil({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF241E1E),
        title: Text(''),
      ),
      backgroundColor: Color(0xFF241E1E),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          String image = items[index][0];
          String title = items[index][1];
          String description = items[index][2];
          int value1 = items[index][3];
          int value2 = items[index][4];
          int value3 = items[index][5];
          int value4 = items[index][6];

          return ListTile(
            leading: Image.asset(image),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '$description',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      final puntosProvider = Provider.of<PuntosProvider>(context, listen: false);
                      if (puntosProvider.totalPoints >= 1000) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmar'),
                              content: Text('¿Deseas gastar tus puntos en este producto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Cierra el diálogo sin realizar ninguna acción
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    puntosProvider.subtractPoints(1000);
                                    Producto producto = Producto(
                                      titulo: title,
                                      descripcion: description,
                                      precio: 0,
                                      puntos: 0,
                                      ima: image,
                                      imagen: '',
                                    );

                                    // Obtener la instancia del CarritoProvider
                                    final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);
                                    carritoProvider.agregarProducto(producto);

                                    Navigator.pop(context); // Cierra el diálogo
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarritoPage(),
                                      ),
                                    );
                                  },
                                  child: Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Puntos insuficientes'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), // Forma ovalada del botón
                      primary: Colors.brown, // Color del botón
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Canjear', // Texto del botón
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.discount,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),                ),
              ],
            ),
          );
        },
      ),
    );
  }
}












