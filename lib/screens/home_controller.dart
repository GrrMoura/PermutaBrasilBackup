import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:permuta_brasil/screens/config_screen.dart';
import 'package:permuta_brasil/screens/home_screen.dart';
import 'package:permuta_brasil/screens/cadastro/selecao_estados_screen.dart';

class HomeControler extends StatefulWidget {
  const HomeControler({super.key});

  @override
  State<HomeControler> createState() => _HomePageState();
}

class _HomePageState extends State<HomeControler> {
  int selectedPage = 0;

  final _pageList = [
    const HomeScreen(
      nomeUsuario: "Roberto Rocha",
      matchs: [
        {
          "nome": "Maria Silva",
          "estado": "SP",
          "telefone": "(11) 98765-4321",
          "imagem": "assets/images/saopaulo.png",
        },
        {
          "nome": "Carlos Souza",
          "estado": "RJ",
          "telefone": "(21) 91234-5678",
          "imagem": "assets/images/riodejaneiro.png",
        },
        {
          "nome": "Ana Costa",
          "estado": "MG",
          "telefone": "(31) 99876-5432",
          "imagem": "assets/images/minasgerais.png",
        },
      ],
    ),
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
