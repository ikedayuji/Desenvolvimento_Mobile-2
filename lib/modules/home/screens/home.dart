import 'package:flutter/material.dart';
import '../../tasks/screens/main_task.dart';
import '../../users/screens/usuarios.dart';
import 'cep_search_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text("Lista de tarefas"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainTask()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt),
            title: const Text("Lista de usuários"),
            subtitle: const Text("Pessoas cadastradas"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              print("Você tocou na lista");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Usuarios()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Buscar CEP"),
            subtitle: const Text("Encontre informações de endereço"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CepSearchScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Álbum de fotos"),
            subtitle: const Text("Visualização de imagens"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              print("Você tocou na lista");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              print("Você tocou na lista");
            },
          )
        ],
      ),
    );
  }
}
