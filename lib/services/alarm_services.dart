import 'package:firebase_database/firebase_database.dart';

class AlarmServices {
  final _db = FirebaseDatabase.instance.ref();

  Future<bool> cambiarEstado(bool encender) async {
    try {
      final ahora = DateTime.now().toUtc().toIso8601String();

      // Guardar historial
      await _db.child('acciones').push().set({
        'estado': encender,
        'timestamp': ahora,
      });

      // Actualizar estado actual del foco
      await _db.child('alarma').child('estado').set(encender);

      print('✅ Estado actualizado y acción registrada');
      return true;
    } catch (e) {
      print('❌ Error al actualizar la alarma: $e');
      return false;
    }
  }
}
