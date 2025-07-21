import 'package:flutter/material.dart';
import '../../movie/page/movie_page.dart';
import '../widgets/bottom_bar.dart';
import '../../../../core/utils/colors.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
    MoviePage(),
    Center(child: Text('text1')),
    Center(child: Text('text2')),
    Center(child: Text('text3')),
    Center(child: Text('text4')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: AppColors.navBar, // Set the padding area color
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: BottomNavigationBar(
            backgroundColor: AppColors.navBar, // Use your defined color
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: homeBottomNavItems,
            selectedItemColor: AppColors.primary, //  for selected
            unselectedItemColor: AppColors.white, //  for unselected
            type: BottomNavigationBarType.fixed, // Ensures background color is applied
          ),
        ),
      ),
    );
  }
}