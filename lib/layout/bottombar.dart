import 'package:flutter/material.dart';

import '../modules/calc/screens/calc.dart';
import '../modules/forms/screens/formulario.dart';
import '../modules/home/screens/home.dart';

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomBarState();
  }
}

class BottomBarState extends State<BottomBar> {
  int abaSelecionada = 0;

  final List<Widget> telas = [
    Home(),
    Calc(),
    Formulario(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eric App"),
        centerTitle: true,
        leading: Icon(Icons.favorite),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: abaSelecionada,
        onTap: (index) {
          setState(() {
            abaSelecionada = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_sharp),
            label: "Calculadora",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 202, 53, 33),
        unselectedItemColor: Color.fromARGB(158, 19, 182, 146),
      ),
      body: telas[abaSelecionada],
    );
  }
}
