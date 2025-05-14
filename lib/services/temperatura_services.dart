import 'package:firebase_database/firebase_database.dart';

class TemperatureService {
  final _ref = FirebaseDatabase.instance.ref('temperatura');

  Future<String> getTemperature() async {
    final snapshot = await _ref.get();
    if (snapshot.exists) {
      return snapshot.value.toString();
    } else {
      return 'No data';
    }
  }

  Stream<String> temperatureStream() {
    return _ref.onValue.map((event) => event.snapshot.value.toString());
  }
}
