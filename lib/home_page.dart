import 'package:flutter/material.dart';
import 'package:flutter_navigation_drawer/fragments/about_fragment.dart';
import 'package:flutter_navigation_drawer/fragments/contact_fragment.dart';

import 'fragments/profile_fragment.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Profile", Icons.person),
    DrawerItem("About", Icons.account_box_outlined),
    DrawerItem("Contact", Icons.call)
  ];

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return ProfileFragment();
      case 1:
        return AboutFragment();
      case 2:
        return ContactFragment();

      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(

        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        title: Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(

        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),

              accountName: Text("John Doe"),
              accountEmail: Text("jhondue@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Icon(
                    Icons.person_rounded,
                    size: 60,
                  ),
                ),
              ),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
