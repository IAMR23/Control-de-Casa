import 'package:firebase_database/firebase_database.dart';

class ProximidadService {
  final _ref = FirebaseDatabase.instance.ref('proximidad');

  Future<String> getProximidad() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }

  Stream<String> proximidadStream() {
    return _ref.onValue.map((event) => event.snapshot.value.toString());
  }
}
