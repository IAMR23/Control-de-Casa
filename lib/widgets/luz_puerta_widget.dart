import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foco_led_app/services/luz_puerta_services.dart';
import 'package:foco_led_app/widgets/device_switch.dart';

class LuzPuertaWidget extends StatefulWidget {
  const LuzPuertaWidget({Key? key}) : super(key: key);

  @override
  State<LuzPuertaWidget> createState() => _LuzWidgetState();
}

class _LuzWidgetState extends State<LuzPuertaWidget> {
  final LuzPuertaServices _focoService = LuzPuertaServices();
  final DatabaseReference focoRef = FirebaseDatabase.instance.ref(
    'foco-puerta/estado',
  );

  // Método que devuelve un Stream<bool> desde Firebase
  Stream<bool> get focoStream {
    return focoRef.onValue.map((event) {
      final valor = event.snapshot.value;
      return valor == true; // Se asegura de que sea booleano
    });
  }

  void actualizarFoco(bool encender) async {
    final exito = await _focoService.cambiarEstado(encender);
    if (exito) {
      await focoRef.set(encender); // Actualiza Firebase
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al comunicar con el dispositivo'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: focoStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error al cargar el estado del foco');
        }

        final estado = snapshot.data ?? false;

        return Column(
          children: [
            Icon(
              estado ? Icons.lightbulb : Icons.lightbulb_outline,
              size: 40,
              color: estado ? Colors.yellow : Colors.black,
            ),
            const Text('Foco entrada', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            DeviceSwitch(estado: estado, onChanged: actualizarFoco),
          ],
        );
      },
    );
  }
}
