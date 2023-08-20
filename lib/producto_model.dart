class CarritoItem {
  final int id;
  final DateTime createdAt;
  final String nombre;
  final String descripcion;
  final int puntos;
  final double precio;
  final String image;
  final String usuario;

  CarritoItem({
    required this.id,
    required this.createdAt,
    required this.nombre,
    required this.descripcion,
    required this.puntos,
    required this.precio,
    required this.image,
    required this.usuario,
  });

  factory CarritoItem.fromJson(Map<String, dynamic> json) {
    return CarritoItem(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      puntos: json['puntos'],
      precio: json['precio'],
      image: json['image'],
      usuario: json['usuario'],
    );
  }
}