import 'package:flutter/material.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key});

  @override
  State<Calc> createState() => CalcState();
}

class CalcState extends State<Calc> {
  int myVar = 0;
  TextEditingController control1 = TextEditingController();
  TextEditingController control2 = TextEditingController();
  String selectedOperation = 'Selecione uma operação';

  void _selectOperation(String operation) {
    setState(() {
      selectedOperation = operation;
    });
  }

  void _calculate() {
    int n1 = int.tryParse(control1.text) ?? 0;
    int n2 = int.tryParse(control2.text) ?? 0;
    setState(() {
      if (selectedOperation == 'Somar') {
        myVar = n1 + n2;
      } else if (selectedOperation == 'Subtrair') {
        myVar = n1 - n2;
      } else if (selectedOperation == 'Multiplicar') {
        myVar = n1 * n2;
      } else if (selectedOperation == 'Dividir') {
        myVar = n1 ~/ n2;
      } else if (selectedOperation == 'Elevar') {
        myVar = n1 ^ n2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: control1,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Primeiro valor",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: control2,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Segundo valor",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      selectedOperation,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Somar'),
                                onTap: () {
                                  _selectOperation('Somar');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Subtrair'),
                                onTap: () {
                                  _selectOperation('Subtrair');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Multiplicar'),
                                onTap: () {
                                  _selectOperation('Multiplicar');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Dividir'),
                                onTap: () {
                                  _selectOperation('Dividir');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Elevar'),
                                onTap: () {
                                  _selectOperation('Elevar');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                    ),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onPressed: _calculate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "$myVar",
              style: const TextStyle(
                color: Color.fromARGB(255, 13, 140, 199),
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
