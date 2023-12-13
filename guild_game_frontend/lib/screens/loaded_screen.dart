import 'package:flutter/material.dart';

class LoadedScreen extends StatelessWidget {
  const LoadedScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loaded Screen'),
      ),
      body: const Center(
        child: Text('Loaded Screen'),
      ),
    );
  }
}