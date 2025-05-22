import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Iniciar sesión
  static Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Éxito
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Usuario no encontrado';
      } else if (e.code == 'wrong-password') {
        return 'Contraseña incorrecta';
      } else {
        return 'Error: ${e.message}';
      }
    } catch (e) {
      return 'Error inesperado';
    }
  }

  // Registrar nuevo usuario (opcional)
  static Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return 'Error: ${e.message}';
    } catch (e) {
      return 'Error inesperado';
    }
  }

  // Cerrar sesión
  static Future<void> logout() async {
    await _auth.signOut();
  }

  // Obtener usuario actual
  static User? get currentUser => _auth.currentUser;

  // Stream de autenticación
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
}
