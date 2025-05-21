import 'package:flutter/material.dart';
import 'package:foco_led_app/widgets/alarm_widget.dart';
import 'package:foco_led_app/widgets/door_widget.dart';
import 'package:foco_led_app/widgets/dry_control_widget.dart';
import 'package:foco_led_app/widgets/humedad_widget.dart';
import 'package:foco_led_app/widgets/luz_puerta_widget.dart';
import 'package:foco_led_app/widgets/luz_widget.dart';
import 'package:foco_led_app/widgets/mermaid_widget.dart';
import 'package:foco_led_app/widgets/temperatura_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Widgets separados que estarán fuera de la grilla
    final humedadWidget = HumedadWidget();
    final temperaturaWidget = TemperaturaWidget();

    // Resto de widgets que irán dentro de la grilla
    final gridItems = [
      LuzWidget(),
      LuzPuertaWidget(),
      DoorWidget(),
      AlarmWidget(),
      DryControlWidget(),
      MermaidWidget(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Control Total')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Humedad y Temperatura en una fila separada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: humedadWidget),
                const SizedBox(width: 16),
                Expanded(child: temperaturaWidget),
              ],
            ),
            const SizedBox(height: 20),

            // Grilla con el resto de widgets
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
