import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:foco_led_app/services/dry_control_services.dart';
import 'package:foco_led_app/widgets/device_switch.dart';

class DryControlWidget extends StatefulWidget {
  const DryControlWidget({Key? key}) : super(key: key);

  @override
  State<DryControlWidget> createState() => _LuzWidgetState();
}

class _LuzWidgetState extends State<DryControlWidget> {
  final DryControlServices _alarmaService = DryControlServices();
  final DatabaseReference focoRef = FirebaseDatabase.instance.ref(
    'dry-control/estado',
  );

  // Método que devuelve un Stream<bool> desde Firebase
  Stream<bool> get focoStream {
    return focoRef.onValue.map((event) {
      final valor = event.snapshot.value;
      return valor == true; // Se asegura de que sea booleano
    });
  }

  void updateAlarm(bool estado) async {
    final exito = await _alarmaService.cambiarEstado(
      estado: estado,
      device: 'ropa',
    );
    if (exito) {
      await focoRef.set(estado); // Actualiza Firebase
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
              estado ? Icons.checkroom : Icons.checkroom,
              size: 40,
              color: estado ? Colors.green : Colors.yellow,
            ),
            const Text('Control de ropa', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            DeviceSwitch(estado: estado, onChanged: updateAlarm),
          ],
        );
      },
    );
  }
}
