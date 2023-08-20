import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart' as p;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_bloc.dart'; // Asegúrate de importar el archivo donde defines AuthBloc
import 'auth_state.dart'; // Asegúrate de importar el archivo donde defines AuthState
import 'metodopago_page.dart';
import 'home_page.dart';
import 'user_state.dart';
import 'pago_provider.dart';
import 'auth_state.dart';
import 'auth_bloc.dart';
import 'home_page.dart';
import 'carrito_page.dart';
import 'favorites_page.dart';
import 'puntos_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'favorites_provider.dart';
import 'pedidos_provider.dart';
import 'pedidos_page.dart';
import 'carrito_provider.dart';
import 'pago_provider.dart';
import 'puntos_provider.dart';
import 'login_page.dart';
import 'producto_provider.dart';
import 'especiales_page.dart';
import 'frutales_page.dart';
import 'cremosos_page.dart';
import 'tortas_page.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_bloc.dart';
import 'auth_state.dart';
import 'metodopago_page.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'user_state.dart';
import 'metodopago_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Definir supabaseClient
  final supabaseClient = SupabaseClient(
    'https://cpkxkwfhzcipprzuejjm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwa3hrd2ZoemNpcHByenVlamptIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODkyODMzNjAsImV4cCI6MjAwNDg1OTM2MH0.fbjckPKRFLnwOvn4iUwietHqLYjmScBhhxWw3Kl4CaI',
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => PuntosProvider()),
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
        ChangeNotifierProvider(create: (_) => PagoProvider()),
        ChangeNotifierProvider(create: (_) => PedidosProvider()),
        ChangeNotifierProvider(create: (_) => UserState(userId: '4840239a-92a9-4758-81ce-a85f57f7af46')),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(supabaseClient),
        ),
      ],
      child: Builder(
        builder: (context) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          return MyApp(supabaseClient: supabaseClient, authBloc: authBloc);
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabaseClient;
  final AuthBloc authBloc;

  MyApp({required this.supabaseClient, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.isAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Cuadros de imágenes',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/metodopago': (context) => MetodoPagoPage(userId: p.Provider.of<UserState>(context, listen: false).userId),
            '/': (context) => MainPage(),
            '/login': (context) => LoginPage(),
            '/especiales': (context) => EspecialesPage(supabaseClient: supabaseClient),
            '/tortas': (context) => TortasPage(supabaseClient: supabaseClient),
            '/settings': (context) => SettingsPage(),
            '/about': (context) => AboutPage(),
            '/carrito': (context) => CarritoPage(),
            '/pedidos': (context) => PedidosPage(),
            '/cremosos': (context) => CremososPage(supabaseClient: supabaseClient),
            '/frutales': (context) => FrutalesPage(supabaseClient: supabaseClient),
          },
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String _pageTitle = 'INICIO';

  final List<Widget> _pages = [
    HomePage(),
    CarritoPage(),
    FavoritesPage(),
    PuntosPage(userPoints: 0),
    PedidosPage(),
  ];

  List<String> _pageTitles = [
    'INICIO',
    'CARRITO',
    'FAVORITOS',
    'PUNTOS',
    'PEDIDOS',
  ];

  List<String> _selectedProducts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageTitle = _pageTitles[index];
    });
  }

  void addToCart(String product) {
    setState(() {
      _selectedProducts.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF241E1E),
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF241E1E),
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF241E1E),
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF241E1E),
            icon: Icon(Icons.tag_faces_outlined),
            label: 'Puntos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

