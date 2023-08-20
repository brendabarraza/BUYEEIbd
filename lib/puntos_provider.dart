import 'package:flutter/foundation.dart';
import 'package:supabase/supabase.dart';

class PuntosProvider with ChangeNotifier {
  int _totalPoints = 0;
  String? _userId;

  void setUserId(String? userId) {
    _userId = userId;
    _initializeTotalPoints();
  }
  void addToTotalPoints(int points) async {
    try {
      final userId = await SupabaseService.getUserIdFromSession();
      if (userId != null) {
        final newTotalPoints = _totalPoints + points;
        print('Adding points: $points, newTotalPoints: $newTotalPoints');
        await _updateTotalPointsInSupabase(userId, newTotalPoints);
        _totalPoints = newTotalPoints;
        notifyListeners();
      } else {
        print('Usuario no autenticado. No se pueden sumar puntos.');
      }
    } catch (error) {
      print('Error adding points: $error');
    }
  }
  int get totalPoints => _totalPoints;

  PuntosProvider() {
    _initializeTotalPoints();
  }

  Future<void> _initializeTotalPoints() async {
    try {
      final userId = await SupabaseService.getUserIdFromSession();
      if (userId != null) {
        _userId = userId;
        _totalPoints = await SupabaseService.getTotalPointsForUser(_userId!);
        notifyListeners();
      }
    } catch (error) {
      print('Error initializing totalPoints: $error');
    }
  }

  Future<void> _updateTotalPointsInSupabase(String userId, int newTotalPoints) async {
    try {
      await SupabaseService.updateTotalPointsForUser(userId, newTotalPoints);
      print('Puntos actualizados exitosamente en Supabase.');
    } catch (error) {
      print('Error al actualizar los puntos en Supabase: $error');
    }
  }

  void subtractPoints(int points) async {
    try {
      final userId = await SupabaseService.getUserIdFromSession();
      if (userId != null) {
        final newTotalPoints = _totalPoints - points;
        print('Subtracting points: $points, newTotalPoints: $newTotalPoints');
        await _updateTotalPointsInSupabase(userId, newTotalPoints);
        _totalPoints = newTotalPoints;
        notifyListeners();
      } else {
        print('Usuario no autenticado. No se pueden restar puntos.');
      }
    } catch (error) {
      print('Error subtracting points: $error');
    }
  }
}

class SupabaseService {
  static final SupabaseClient _supabaseClient = SupabaseClient(
    'https://cpkxkwfhzcipprzuejjm.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwa3hrd2ZoemNpcHByenVlamptIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODkyODMzNjAsImV4cCI6MjAwNDg1OTM2MH0.fbjckPKRFLnwOvn4iUwietHqLYjmScBhhxWw3Kl4CaI',
  );

  static Future<String?> getUserIdFromSession() async {
    final session = _supabaseClient.auth.currentSession;
    return session?.user?.id;
  }

  static Future<int> getTotalPointsForUser(String userId) async {
    final response = await _supabaseClient
        .from('puntos')
        .select('puntosTotales')
        .eq('usuario', userId)
        .single()
        .execute();

    if (response.error != null) {
      throw response.error!;
    }

    return response.data['puntosTotales'] as int;
  }

  static Future<void> updateTotalPointsForUser(String userId, int newTotalPoints) async {
    final response = await _supabaseClient
        .from('puntos')
        .update({'puntosTotales': newTotalPoints})
        .eq('usuario', userId)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }
}





