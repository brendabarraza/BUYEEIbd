import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/nosotros.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'En Buyeei, nos apasiona crear momentos dulces y refrescantes que deleiten tus sentidos y te hagan sonreír. Somos una marca de helados dedicada a ofrecerte la más alta calidad y sabores irresistibles que te transportarán a un mundo de placer helado.\n\nEn Buyeei, creemos en la importancia de la creatividad y la innovación. Nuestro equipo de expertos en helados está constantemente experimentando y desarrollando nuevas recetas para ofrecerte una variedad de sabores que despierten tus papilas gustativas. Desde los clásicos atemporales hasta las combinaciones audaces y vanguardistas, siempre encontrarás algo que se adapte a tu gusto en nuestro amplio catálogo de helados.\n\nAdemás, nos enorgullece decir que nuestra pasión por los helados se combina con un firme compromiso con la sostenibilidad y la responsabilidad social. Nos esforzamos por minimizar nuestro impacto en el medio ambiente, utilizando envases y materiales ecoamigables, y trabajamos en estrecha colaboración con organizaciones benéficas locales para apoyar a nuestras comunidades.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 130,
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'SEGUINOS EN NUESTRAS REDES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 820,
          left: 68,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            color: Colors.transparent,
            child: IconButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: CachedNetworkImage(
                imageUrl:
                'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Instagram.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvSW5zdGFncmFtLnBuZyIsImlhdCI6MTY4OTM4MTEwOSwiZXhwIjoxNzIwOTE3MTA5fQ.fO5PcGI3nqgnpfSRIdCGXmBft75ELoLuUoNoUR2omTI&t=2023-07-15T00%3A31%3A49.967Z',
                placeholder: (context, url) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 110,
                height: 110,
              ),
            ),
          ),
        ),
        Positioned(
          top: 820,
          left: 119,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            color: Colors.transparent,
            child: IconButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: CachedNetworkImage(
                imageUrl:
                'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Facebook.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvRmFjZWJvb2sucG5nIiwiaWF0IjoxNjg5MzgxMTI3LCJleHAiOjE3MjA5MTcxMjd9.BhRV63RAGfow2M_ijbVskJPQRYKnOl1yWbiQZfYxC_g&t=2023-07-15T00%3A32%3A07.656Z',
                placeholder: (context, url) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 110,
                height: 110,
              ),
            ),
          ),
        ),
        Positioned(
          top: 820,
          right: 192,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
            color: Colors.transparent,
            child: IconButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              icon: CachedNetworkImage(
                imageUrl:
                'https://cpkxkwfhzcipprzuejjm.supabase.co/storage/v1/object/sign/productos/Twitter.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJwcm9kdWN0b3MvVHdpdHRlci5wbmciLCJpYXQiOjE2ODkzODExNDUsImV4cCI6MTcyMDkxNzE0NX0.kvqs3280S5WR-pvPIY3nDEqPKVnJn7SE0PuSQqhEuDY&t=2023-07-15T00%3A32%3A25.774Z',
                placeholder: (context, url) =>
                    CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 110,
                height: 110,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



