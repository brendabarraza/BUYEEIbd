import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/favorites_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_state.dart';
import 'carrito_model.dart';
import 'favorites_page.dart';
import 'favorites_provider.dart';
import 'favorites_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Cubit<AuthState> {
  final SupabaseClient _supabaseClient;

  AuthBloc(this._supabaseClient) : super(AuthState(isAuthenticated: false));

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signIn(email: email, password: password);
      if (response.error != null) {
        emit(AuthState(isAuthenticated: false, error: response.error!.message));
        return false;
      } else {
        final user = _supabaseClient.auth.user();
        if (user != null) {
          emit(AuthState(isAuthenticated: true, message: 'Credenciales correctas'));
          return true;
        } else {
          emit(AuthState(isAuthenticated: false, error: 'Error al autenticar'));
          return false;
        }
      }
    } catch (e) {
      emit(AuthState(isAuthenticated: false, error: 'Error: $e'));
      return false;
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    emit(AuthState(isAuthenticated: false));
  }
  Future<List<FavoritesItem>> getFavoritesItems(String usuarioId) async {
    final response = await _supabaseClient.from('favorites').select().eq('usuario', usuarioId).execute();
    if (response.error != null) {
      throw response.error!.message;
    } else {
      final favoritesItemsData = response.data as List<dynamic>;
      final favoritesItems = favoritesItemsData.map((data) => FavoritesItem.fromJson(data)).toList();
      return favoritesItems;
    }
  }
  Future<List<CarritoItem>> getCarritoItems(String usuarioId) async {
    final response = await _supabaseClient.from('carrito').select().eq('usuario', usuarioId).execute();
    if (response.error != null) {
      throw response.error!.message;
    } else {
      final carritoItemsData = response.data as List<dynamic>;
      final carritoItems = carritoItemsData.map((data) => CarritoItem.fromJson(data)).toList();
      return carritoItems;
    }
  }


  SupabaseClient get supabaseClient => _supabaseClient;
  User? get currentUser => _supabaseClient.auth.currentUser;
}

