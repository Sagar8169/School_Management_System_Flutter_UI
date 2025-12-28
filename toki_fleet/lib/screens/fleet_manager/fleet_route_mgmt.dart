import 'package:flutter/material.dart';

class FleetRouteMgmt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Route Management"), backgroundColor: Colors.purple),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          ListTile(title: Text("Route 1 - Jubilee Hills"), trailing: Icon(Icons.edit)),
          Divider(),
          ListTile(title: Text("Route 2 - Gachibowli"), trailing: Icon(Icons.edit)),
          Divider(),
          ElevatedButton.icon(onPressed: () {}, icon: Icon(Icons.add), label: Text("Add New Route")),
        ],
      ),
    );
  }
}