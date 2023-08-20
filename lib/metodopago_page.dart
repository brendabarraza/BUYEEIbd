import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MetodoPagoPage extends StatefulWidget {
  final String userId; // Add this line
  MetodoPagoPage({required this.userId}); // Add this constructor
  @override
  _MetodoPagoPageState createState() => _MetodoPagoPageState();
}

class _MetodoPagoPageState extends State<MetodoPagoPage> {
  String? userId;
  final TextEditingController numeroTarjetaController = TextEditingController();
  final TextEditingController fechaVencimientoController = TextEditingController();
  final TextEditingController codigoController = TextEditingController();
  final supabaseClient = SupabaseClient(
    'https://cpkxkwfhzcipprzuejjm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwa3hrd2ZoemNpcHByenVlamptIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODkyODMzNjAsImV4cCI6MjAwNDg1OTM2MH0.fbjckPKRFLnwOvn4iUwietHqLYjmScBhhxWw3Kl4CaI',
  );

  Future<void> createMetodoPago() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      print('El usuario no está autenticado.');
      return;
    }
    userId = user.id; // Almacena el User ID en la variable userId
    final response = await supabaseClient
        .from('metodopago')
        .upsert([
      {
        'numtar': numeroTarjetaController.text,
        'fecha': fechaVencimientoController.text,
        'codigo': codigoController.text,
        'usuario_email': user.email, // Usar el email del usuario
      }
    ])
        .execute();
    if (response.error != null) {
      print('Error al guardar los datos en la tabla: ${response.error}');
    } else {
      print('Datos guardados exitosamente');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Método de Pago'),
        backgroundColor: Color(0xFF241E1E),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selecciona tu método de pago',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: numeroTarjetaController,
              decoration: InputDecoration(labelText: 'Número de Tarjeta'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: fechaVencimientoController,
              decoration: InputDecoration(labelText: 'Fecha de Vencimiento'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: codigoController,
              decoration: InputDecoration(labelText: 'Codigo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await createMetodoPago();
              },
              child: Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = supabaseClient.auth.currentUser;
                if (user == null) {
                  print('El usuario no está autenticado.');
                  return;
                }
                final response = await supabaseClient
                    .from('metodopago')
                    .select()
                    .eq('usuario_email', user.email) // Usar el email del usuario
                    .execute();
                if (response.error != null) {
                  print('Error al obtener los métodos de pago: ${response.error}');
                } else {
                  print('Métodos de pago:');
                  for (final row in response.data as List) {
                    print('Número de Tarjeta: ${row['numtar']}, Fecha de Vencimiento: ${row['fecha']}, Codigo: ${row['codigo']}');
                  }
                }
              },
              child: Text('Mostrar Métodos de Pago'),
            ),

            ElevatedButton(
              onPressed: () async {
                final user = supabaseClient.auth.currentUser;
                final response = await supabaseClient
                    .from('metodopago')
                    .update({
                  'fecha': fechaVencimientoController.text,
                })
                    .eq('usuario', user?.id)
                    .eq('numtar', numeroTarjetaController.text)
                    .eq('numtar', codigoController.text)
                    .execute();

                if (response.error != null) {
                  print('Error al actualizar el método de pago: ${response.error}');
                } else {
                  print('Método de pago actualizado exitosamente');
                }
              },
              child: Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}






