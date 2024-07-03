import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:permuta_brasil/screens/config_screen.dart';
import 'package:permuta_brasil/screens/home.dart';

class HomeControler extends StatefulWidget {
  const HomeControler({super.key});

  @override
  State<HomeControler> createState() => _HomePageState();
}

class _HomePageState extends State<HomeControler> {
  int selectedPage = 0;

  final _pageList = [
    const HomeScreen(),
    const ConfigScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageList[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          shadowColor: Colors.black,
          activeColor: const Color(0xffa0c2ed),
          backgroundColor: const Color(0xff00296b),
          elevation: 2,
          color: const Color(0xffc8dbf8),
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: Icons.home),
            TabItem(icon: Icons.person),
          ],
          initialActiveIndex: selectedPage,
          onTap: (int index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
