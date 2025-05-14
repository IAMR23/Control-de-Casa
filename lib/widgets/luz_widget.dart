import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foco_led_app/services/light_services.dart';
import 'package:foco_led_app/widgets/light_switch.dart';

class LuzWidget extends StatefulWidget {
  const LuzWidget({Key? key}) : super(key: key);

  @override
  State<LuzWidget> createState() => _LuzWidgetState();
}

class _LuzWidgetState extends State<LuzWidget> {
  final FocoService _focoService = FocoService();
  final DatabaseReference focoRef = FirebaseDatabase.instance.ref(
    'foco/estado',
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

        final encendido = snapshot.data ?? false;

        return Column(
          children: [
            Icon(
              encendido ? Icons.lightbulb : Icons.lightbulb_outline,
              size: 40,
              color: encendido ? Colors.yellow : Colors.black,
            ),
            const Text('Foco', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            LightSwitch(encendido: encendido, onChanged: actualizarFoco),
          ],
        );
      },
    );
  }
}
