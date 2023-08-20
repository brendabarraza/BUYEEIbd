
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isAuthenticated;
  final String? error;
  final String? message;

  AuthState({required this.isAuthenticated, this.error, this.message});

  @override
  List<Object?> get props => [isAuthenticated, error, message];

}

