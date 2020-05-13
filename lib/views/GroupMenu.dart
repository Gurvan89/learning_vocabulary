import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GroupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
              height: 80,
              child: DrawerHeader(
                  child: Text(
                    'Group menu',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  decoration: BoxDecoration(color: Colors.grey))),
          ListTile(
              trailing: Switch(value:false,onChanged: (t)=>print("toto"),),
              leading: Icon(Icons.directions_boat),
              title: Text("Sailing")),
          ListTile(
              trailing: Switch(value:false,onChanged: (t)=>print("toto"),),
              leading: Icon(Icons.local_activity), title: Text("Sewing")),
          ListTile(
              trailing: Switch(value:false,onChanged: (t)=>print("toto"),),
              leading: Icon(Icons.import_contacts),
              title: Text("Book"),
              onTap: () => {Navigator.of(context).pop()}),
        ],
      ),
    );
  }
}
