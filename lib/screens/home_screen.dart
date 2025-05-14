import 'package:flutter/material.dart';
import 'package:foco_led_app/models/light.dart';
import 'package:foco_led_app/services/light_services.dart';
import 'package:foco_led_app/widgets/historial_widget.dart';
import 'package:foco_led_app/widgets/humedad_widget.dart';
import 'package:foco_led_app/widgets/light_switch.dart';
import 'package:foco_led_app/widgets/sensor_proximidad_widget.dart';
import 'package:foco_led_app/widgets/temperatura_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Light foco = Light(estado: false, timestamp: '');
  final FocoService _focoService = FocoService();

  void actualizarFoco(bool encender) async {
    final exito = await _focoService.cambiarEstado(encender);
    if (exito) {
      setState(() {
        foco.estado = encender;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al comunicar con el dispositivo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gridItems = [
      HumedadWidget(),
      SensorProximidadWidget(),
      TemperaturaWidget(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            foco.estado ? Icons.lightbulb : Icons.lightbulb_outline,
            size: 100,
            color: foco.estado ? Colors.yellow : Colors.grey,
          ),
          const SizedBox(height: 24),
          FocoSwitch(encendido: foco.estado, onChanged: actualizarFoco),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Control Foco LED')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: gridItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => gridItems[index],
            ),
            const SizedBox(height: 32),
            const Text(
              'Historial',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(height: 200, child: HistorialWidget()),
          ],
        ),
      ),
    );
  }
}
