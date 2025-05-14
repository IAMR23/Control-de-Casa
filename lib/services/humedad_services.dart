import 'package:firebase_database/firebase_database.dart';

class HumedadService {
  final _ref = FirebaseDatabase.instance.ref('humedad');

  Future<String> getHumedad() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }

  Stream<String> humedadStream() {
    return _ref.onValue.map((event) => event.snapshot.value.toString());
  }
}
