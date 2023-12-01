import 'package:flutter/material.dart';
import '../../tasks/screens/main_task.dart';
import '../../users/screens/usuarios.dart';
import 'cep_search_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListItem(
            icon: Icons.task,
            title: 'Lista de Tarefas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainTask()),
              );
            },
          ),
          _buildListItem(
            icon: Icons.people_alt,
            title: 'Lista de Usuários',
            subtitle: 'Pessoas cadastradas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Usuarios()),
              );
            },
          ),
          _buildListItem(
            icon: Icons.location_on,
            title: 'Buscar CEP',
            subtitle: 'Encontre informações de endereço',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CepSearchScreen()),
              );
            },
          ),
          _buildListItem(
            icon: Icons.photo,
            title: 'Álbum de Fotos',
            subtitle: 'Visualização de imagens',
            onTap: () {},
          ),
          _buildListItem(
            icon: Icons.settings,
            title: 'Configurações',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
