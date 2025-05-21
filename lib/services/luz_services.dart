import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class LuzServices {
  final _db = FirebaseDatabase.instance.ref();

  Future<bool> cambiarEstado({
    required String device,
    required bool estado,
  }) async {
    try {
      final ahora = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      final fechaHora = formatter.format(ahora);

      // Guardar historial
      await _db.child('acciones').push().set({
        'nombre': device,
        'estado': estado,
        'timestamp': fechaHora,
        'tipo': 'light',
      });

      // Actualizar estado actual del foco
      await _db.child(device).child('estado').set(estado);

      print('✅ Estado actualizado y acción registrada para $device');
      return true;
    } catch (e) {
      print('❌ Error al actualizar foco $device: $e');
      return false;
    }
  }
}
