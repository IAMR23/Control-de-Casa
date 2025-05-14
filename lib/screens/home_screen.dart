import 'package:flutter/material.dart';
import 'package:foco_led_app/widgets/historial_widget.dart';
import 'package:foco_led_app/widgets/humedad_widget.dart';
import 'package:foco_led_app/widgets/luz_widget.dart';
import 'package:foco_led_app/widgets/sensor_proximidad_widget.dart';
import 'package:foco_led_app/widgets/temperatura_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final gridItems = [
      HumedadWidget(),
      SensorProximidadWidget(),
      TemperaturaWidget(),
      LuzWidget(),
      /*  Column(
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
      ), */
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Control Total')),
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
          ],
        ),
      ),
    );
  }
}
