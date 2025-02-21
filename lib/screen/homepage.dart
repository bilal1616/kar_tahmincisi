import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:kartahmincisi/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Kar Tahmincisi',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: navigationProvider.toggleMenu,
        ),
      ),
      body: Row(
        children: [
          // ✅ Dinamik ve kaydırılabilir menü
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: navigationProvider.isMenuOpen ? 250 : 70,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SideMenu(
                    showToggle: false,
                    controller: navigationProvider.sideMenuController,
                    style: SideMenuStyle(
                      displayMode: navigationProvider.isMenuOpen
                          ? SideMenuDisplayMode.open
                          : SideMenuDisplayMode.compact,
                      backgroundColor: Colors.white,
                      hoverColor: Colors.blue[100],
                      selectedColor: Colors.lightBlue,
                      selectedTitleTextStyle:
                          const TextStyle(color: Colors.black),
                      selectedIconColor: Colors.white,
                    ),
                    title: navigationProvider.isMenuOpen
                        ? Column(
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 275,
                                  maxWidth: 275,
                                ),
                                child: Image.asset('assets/hava.jpeg'),
                              ),
                              const Divider(indent: 8.0, endIndent: 8.0),
                            ],
                          )
                        : null,
                    items: navigationProvider.buildAllMenuItems(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(
            child: PageView(
              controller: navigationProvider.pageController,
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        "assets/manzara.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedOpacity(
                        opacity: navigationProvider.isMenuOpen ? 0.7 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10.0,
                            sigmaY: 10.0,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: navigationProvider.isMenuOpen ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: const Center(
                        child: Text(
                          '🌨️ Kar Tahmincisi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
