import 'package:flutter/material.dart';

class PlaceHolder extends StatelessWidget {
  final String title;
  const PlaceHolder({Key? key,  this.title='Placeholder'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('This is just a placeholder'),
      ),
    );
  }
}
