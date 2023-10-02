import 'package:flutter/material.dart';
import 'package:subspace/modals/blog_modal.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUPSPACE"),
      ),
    );
  }
}
