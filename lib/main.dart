import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:medi_app/screens/AddOrderScreen.dart';
import 'package:medi_app/screens/AllStockScreen.dart';
import 'package:medi_app/screens/ApprovalScreen.dart';
import 'package:medi_app/screens/LoginScreen.dart';
import 'package:medi_app/screens/ProfileScreen.dart';
import 'package:medi_app/screens/SignUpScreen.dart';
import 'package:medi_app/viewModel/MyViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyViewModel(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MyViewModel>(context);
    if (vm.isLoading == true) {
      return MaterialApp(home: Scaffold(body: CircularProgressIndicator()));
    }
    Widget startScreen;
    if (vm.userId == null) {
      startScreen = const SignUpScreen();
    } else {
      startScreen = const ApprovalScreen();
    }

    return MaterialApp(
     home: startScreen,
      routes: {

        Routes.APPROVAL_ROUTES: (context) => ApprovalScreen(),
        Routes.LOGIN_ROUTES: (context) => LoginScreen(),
        Routes.ORDER_ROUTES: (context) => AddOrderScreen(),
        Routes.STOCK_ROUTES: (context) => AllStockScreen(),
        Routes.PROFILE_ROUTES: (context) => ProfileScreen(),
        Routes.BOTTOM_ROUTES: (context) => BottomNavBar(),
        Routes.CREATE_ROUTES: (context) => SignUpScreen(),
      },
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PageController _pageController = PageController();
  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );

  final List<Widget> _screens = [
    AddOrderScreen(),
    AllStockScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _notchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100, // soft light background
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent.shade100,
              Colors.lightBlueAccent.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlueAccent.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: AnimatedNotchBottomBar(
          notchBottomBarController: _notchController,
          kBottomRadius: 18,
          kIconSize: 28,
          color: Colors.lightBlueAccent.shade100,
          // base background
          notchColor: Colors.lightBlueAccent.shade200,
          // notch highlight
          showLabel: true,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: const Icon(
                Icons.add_box_outlined,
                color: Colors.white70,
              ),
              activeItem: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ),
              itemLabel: 'Add Order',
            ),
            BottomBarItem(
              inActiveItem: const Icon(
                Icons.inventory_2_outlined,
                color: Colors.white70,
              ),
              activeItem: const Icon(
                Icons.inventory_2_rounded,
                color: Colors.white,
              ),
              itemLabel: 'All Stock',
            ),
            BottomBarItem(
              inActiveItem: const Icon(
                Icons.person_outline,
                color: Colors.white70,
              ),
              activeItem: const Icon(Icons.person, color: Colors.white),
              itemLabel: 'Profile',
            ),
          ],
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}

class Routes {
  static const CREATE_ROUTES = '/create';
  static const APPROVAL_ROUTES = '/approval';
  static const LOGIN_ROUTES = '/login';
  static const ORDER_ROUTES = '/order';
  static const STOCK_ROUTES = '/stock';
  static const PROFILE_ROUTES = '/profile';
  static const BOTTOM_ROUTES = '/bottom';
}
