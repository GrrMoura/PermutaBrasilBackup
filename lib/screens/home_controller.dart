import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permutabrasil/screens/config_screen.dart';
import 'package:permutabrasil/screens/home_screen.dart';
import 'package:permutabrasil/screens/pagamento/planos_screen.dart';
import 'package:permutabrasil/utils/app_colors.dart';

class HomeControler extends StatefulWidget {
  const HomeControler({super.key, this.selectedPage});
  final int? selectedPage;
  @override
  State<HomeControler> createState() => HomeControlerState();
}

class HomeControlerState extends State<HomeControler>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _pageList = [
    const ConfigScreen(),
    const HomeScreen(),
    const PlanoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _pageList.length,
      vsync: this,
      initialIndex: widget.selectedPage ?? 1,
    );
  }

  void goToPage(int page) {
    _tabController.animateTo(page);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics:
              const NeverScrollableScrollPhysics(), // se quiser travar swipe
          children: _pageList,
        ),
        bottomNavigationBar: ConvexAppBar(
          controller: _tabController,
          shadowColor: Colors.black,
          activeColor: Colors.white,
          //backgroundColor: const Color(0xff00296b),
          backgroundColor: AppColors.cAccentColor,
          elevation: 2,
          color: const Color(0xffc8dbf8),
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: FontAwesomeIcons.gear),
            TabItem(icon: FontAwesomeIcons.handshake),
            TabItem(icon: FontAwesomeIcons.creditCard),
          ],

          onTap: (int index) {
            _tabController.animateTo(index);
          },
        ));
  }
}
