import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nombre = '';
  String apellido = '';
  String dni = '';
  String correo = '';
  String genero = 'Género';
  String direccion = '';
  String ciudad = '';

  List<String> generoOpciones = ['Género', 'Masculino', 'Femenino', 'Otro'];

  bool isNombreCompleto = true;
  bool isApellidoCompleto = true;
  bool isDniCompleto = true;
  bool isCorreoCompleto = true;
  bool isGeneroCompleto = true;
  bool isDireccionCompleta = true;
  bool isCiudadCompleta = true;

  bool isGuardadoExitoso = false;

  // Configura aquí tus credenciales de Supabase
  final supabase = SupabaseClient(
    'https://cpkxkwfhzcipprzuejjm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwa3hrd2ZoemNpcHByenVlamptIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODkyODMzNjAsImV4cCI6MjAwNDg1OTM2MH0.fbjckPKRFLnwOvn4iUwietHqLYjmScBhhxWw3Kl4CaI',
  );

  @override
  void initState() {
    super.initState();
    obtenerDatosPerfil();
  }

  Future<void> obtenerDatosPerfil() async {
    final response = await supabase
        .from('perfil')
        .select()
        .eq('usuario', '4840239a-92a9-4758-81ce-a85f57f7af46')
        .single()
        .execute(); // Añadimos el método execute() para obtener la respuesta real

    if (response.error == null && response.data != null) {
      setState(() {
        nombre = response.data['nombre'] ?? '';
        apellido = response.data['apellido'] ?? '';
        dni = response.data['DNI']?.toString() ?? '';
        correo = response.data['correo electronico'] ?? '';
        genero = response.data['genero'] ?? 'Género';
        direccion = response.data['direccion'] ?? '';
        ciudad = response.data['ciudad'] ?? '';
      });
    } else {
      print('Error al obtener los datos del perfil: ${response.error?.message}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF241E1E),
        title: Text('PERFIL'),
      ),
      backgroundColor: Color(0xFF444141),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              _buildTextField(
                  'Nombre', 'Nombre', (value) => nombre = value, isNombreCompleto),
              SizedBox(height: 16),
              _buildTextField(
                  'Apellido', 'Apellido', (value) => apellido = value, isApellidoCompleto),
              SizedBox(height: 16),
              _buildTextField('Número de DNI', 'DNI', (value) => dni = value, isDniCompleto),
              SizedBox(height: 16),
              _buildTextField(
                  'Correo electrónico', 'Correo electrónico', (value) => correo = value, isCorreoCompleto),
              SizedBox(height: 16),
              _buildTextField('Dirección', 'Dirección', (value) => direccion = value, isDireccionCompleta),
              SizedBox(height: 16),
              _buildTextField('Ciudad', 'Ciudad', (value) => ciudad = value, isCiudadCompleta),
              SizedBox(height: 16),
              _buildGenderDropdown(),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isNombreCompleto = nombre.isNotEmpty;
                    isApellidoCompleto = apellido.isNotEmpty;
                    isDniCompleto = dni.isNotEmpty;
                    isCorreoCompleto = correo.isNotEmpty;
                    isGeneroCompleto = genero != 'Género';
                    isDireccionCompleta = direccion.isNotEmpty;
                    isCiudadCompleta = ciudad.isNotEmpty;

                    if (isNombreCompleto &&
                        isApellidoCompleto &&
                        isDniCompleto &&
                        isCorreoCompleto &&
                        isGeneroCompleto &&
                        isDireccionCompleta &&
                        isCiudadCompleta) {
                      isGuardadoExitoso = true;
                    } else {
                      isGuardadoExitoso = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Visibility(
                visible: !(isNombreCompleto &&
                    isApellidoCompleto &&
                    isDniCompleto &&
                    isCorreoCompleto &&
                    isGeneroCompleto &&
                    isDireccionCompleta &&
                    isCiudadCompleta),
                child: Text(
                  'Por favor, complete todos los campos obligatorios.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Visibility(
                visible: isGuardadoExitoso,
                child: Text(
                  'Se ha guardado tu información correctamente.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, ValueChanged<String> onChanged,
      [bool isComplete = true]) {
    return TextField(
      style: TextStyle(color: isComplete ? Colors.white : Colors.red),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[700],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[700]!),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[700]!),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField(
        value: genero,
        items: generoOpciones.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(color: option == 'Género' ? Colors.grey : Colors.white),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            genero = value!;
          });
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}










