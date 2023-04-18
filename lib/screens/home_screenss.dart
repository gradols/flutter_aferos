/*
import 'package:flutter/material.dart';


int counter = 0;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            const Text('Numero de clicks'),
            Text('$counter'),
          ],
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
        
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
      
            FloatingActionButton(
      
              child: const Icon(Icons.exposure_plus_1) ,
              onPressed: () => setState(() => counter++),
            ),
            const SizedBox(width: 20 ),
      
            FloatingActionButton(
              child: const Icon(Icons.clear) ,
              onPressed: () => setState(() => counter = 0 ),
            ),
            const SizedBox(width: 20 ),
      
            FloatingActionButton(
              child: const Icon(Icons.exposure_minus_1) ,
              onPressed: () => setState(() => counter--),
            ),
          ],
        ),
      ), 
    );
  }
}
*/