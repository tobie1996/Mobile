import 'package:flutter/material.dart';
import 'package:gspresence/menu/homeMenu.dart';
import 'package:gspresence/pages/add_contact_page.dart';
import 'package:gspresence/pages/home_page.dart';
import 'package:gspresence/poste/home_poste.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("WELCOME"),
      ),
      body: Center(
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            Dashboard(
              icon: 'Icons.teams',
              title: 'personnel',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const HomePage();
                }));
              },
            ),
            Dashboard(
              icon: 'Icons.school',
              title: 'Poste',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return const Homeposte();
                }));
              },
            ),
            Dashboard(
              icon: 'Icons.settings',
              title: 'Paramettres',
              onTap: () {},
            ),
            Dashboard(
              icon: 'Icons.money',
              title: 'utilisateurs',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}