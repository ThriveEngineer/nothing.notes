import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nothing_note/home_page.dart';
import 'package:nothing_note/tasks_page.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
    int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List <Widget> _pages = [
    const HomePage(),
    const TasksPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      // Navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, 
          boxShadow: [
            BoxShadow(
              blurRadius: 20, 
              color: Theme.of(context).colorScheme.surface.withOpacity(.1),
              ),
             ],
          ),
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: GNav(
            rippleColor: Theme.of(context).colorScheme.secondary, // tab button ripple color when pressed
            hoverColor: Colors.black, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15, 
            tabActiveBorder: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1), // tab button border
            tabBorder: Border.all(color: Theme.of(context).colorScheme.primary, width: 1), // tab button border
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 800), // tab animation duration
            gap: 8, // the tab button gap between icon and text 
            color: Theme.of(context).colorScheme.inversePrimary, // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: Colors.redAccent, // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10), // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.notes_rounded,
                text: 'Notes',
              ),
              GButton(
                icon: Icons.task_rounded,
                text: 'Tasks',
              ),
            ],
            selectedIndex: _selectedIndex,
        onTabChange: (index) {
    _navigateBottomBar(index);
  },
          ),
          ),
          ),
         ),
    );
  }
}