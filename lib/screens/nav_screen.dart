import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/screens.dart';
import '../widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      Scaffold(),
      Scaffold(),
      Scaffold(),
      Scaffold(),
      Scaffold(),
    ];

    final List<IconData> _icons = const [
      Icons.home,
      Icons.ondemand_video,
      MdiIcons.accountCancelOutline,
      MdiIcons.accountGroupOutline,
      MdiIcons.bellOutline,
      Icons.menu
    ];
    int _selectedIndex = 0;

    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _screens,
        ), // This also works
        // body: IndexedStack(
        //   index: _selectedIndex,
        //   children: _screens,
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CustomTabBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
