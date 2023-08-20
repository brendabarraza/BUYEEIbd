 class FavoritesItem {
  final String nombre;
  final String descripcion;
  final int puntos;
  final double precio;
  final String imagen;
  final String usuario;

  FavoritesItem({
    required this.nombre,
    required this.descripcion,
    required this.puntos,
    required this.precio,
    required this.imagen,
    required this.usuario,
  });

  factory FavoritesItem.fromJson(Map<String, dynamic> json) {
    return FavoritesItem(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      puntos: json['puntos'],
      precio: json['precio'],
      imagen: json['imagen'],
      usuario: json['usuario'],
    );
  }
}