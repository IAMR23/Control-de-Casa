import 'package:firebase_database/firebase_database.dart';

class FocoService {
  final _db = FirebaseDatabase.instance.ref();

  Future<bool> cambiarEstado(bool encender) async {
    try {
      final ahora = DateTime.now().toUtc().toIso8601String(); // formato ISO

      await _db.child('acciones').push().set({
        'estado': encender,
        'timestamp': ahora,
      });

      print('✅ Acción guardada: $encender a las $ahora');
      return true;
    } catch (e) {
      print('❌ Error al guardar acción: $e');
      return false;
    }
  }
}
