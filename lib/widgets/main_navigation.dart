import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [HomeScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.blue, // Fondo azul
        selectedItemColor: Colors.white, // Íconos seleccionados blancos
        unselectedItemColor: Colors.black54, // Íconos no seleccionados en gris
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Foco'),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Acciones Realizadas',
          ),
        ],
      ),
    );
  }
}
