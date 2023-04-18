import 'package:flutter/material.dart';
import 'package:my_app/widgets/draggable_card.dart';
import 'package:my_app/services/api.dart'; // Importa el archivo que contiene la función fetchUsers
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



// ignore: prefer_const_constructors
final secureStorage = FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>> futureUsers = Future.value([]);
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadUsers();
}

void _loadUsers() async {
  String? accessToken = await secureStorage.read(key: 'access_token');
  if (accessToken != null) {
    futureUsers = fetchUsers(accessToken);
    setState(() {}); // Actualiza el estado para volver a construir el widget con los nuevos datos
  } else {
    // Maneja el caso en que el token de acceso no esté disponible, por ejemplo, mostrando un mensaje de error
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Inicio'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: snapshot.data!.map((user) {
                return DraggableCard(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/300x400'), // Reemplaza con la URL de la imagen del usuario si la tienes
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user['full_name']} (${user['age']})',
                              style: const TextStyle(color: Color.fromARGB(255, 164, 146, 146), fontSize: 24)),
                          Text(user['email'],
                              style: const TextStyle(color: Color.fromARGB(255, 57, 27, 27), fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
        },
      ),
    );
  }
}
