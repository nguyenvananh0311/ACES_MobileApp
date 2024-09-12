import 'package:ems/services/signalR/signalrServiceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'activities/home.dart';
import 'activities/notification.dart';
import 'activities/profile.dart';

class MainScreen extends StatefulWidget {
  final String companyId;
  final int employeeId;
  final String? employeeName;
  final Function(Locale) onLocaleChange;
  const MainScreen({
    super.key,
    required this.companyId,
    required this.employeeId,
    required this.onLocaleChange,
    this.employeeName
  });

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _pages;
  late PageController _pageController = PageController(initialPage: _currentIndex);

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(companyId: widget.companyId, employeeId: widget.employeeId, onLocaleChange: widget.onLocaleChange, employeeName: widget.employeeName),
      NotificationScreen(companyId: widget.companyId, employeeId: widget.employeeId, onLocaleChange: widget.onLocaleChange,),
      ProfileScreen(companyId: widget.companyId, employeeId: widget.employeeId, onLocaleChange: widget.onLocaleChange,),
    ];
    // _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // void _onPageChanged(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   final signalRServiceProvider = Provider.of<SignalRServiceProvider>(context, listen: false);
  //   signalRServiceProvider.reload(widget.employeeId, widget.companyId);
  // }
  void _onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
      final signalRServiceProvider = Provider.of<SignalRServiceProvider>(context, listen: false);
      signalRServiceProvider.reload(widget.employeeId, widget.companyId);
    }
  // void _onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  // }

  @override
  Widget build(BuildContext context) {
    final signalRServiceProvider = Provider.of<SignalRServiceProvider>(context);

    return Scaffold(
      body: _pages[_currentIndex],
      //dùng để trượt
      // body: PageView(
      //   controller: _pageController,
      //   onPageChanged: _onPageChanged,
      //   children: _pages,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.notifications, size: 30,),
                if (signalRServiceProvider.total > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${signalRServiceProvider.total}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'NOTIFICATION',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ME',
          ),
        ],
      ),
    );
  }
}
