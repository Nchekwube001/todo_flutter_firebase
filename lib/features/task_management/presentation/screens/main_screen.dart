import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "package:flutter_todo/features/authentication/controllers/auth_controller.dart";
import "package:flutter_todo/features/authentication/presentation/screens/account_screen.dart";
import "package:flutter_todo/features/task_management/presentation/screens/add_task_screen.dart";
import "package:flutter_todo/features/task_management/presentation/screens/all_tasks_screen.dart";
import "package:flutter_todo/features/task_management/presentation/screens/completed_tasks_screen.dart";
import "package:flutter_todo/features/task_management/presentation/screens/incomplete_tasks_screen.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndx = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: TabBarView(
        controller: _tabController,
        children: [
          AllTasksScreen(),
          IncompleteTasksScree(),
          AddTaskScreen(),
          CompletedTasksScreen(),
          AccountScreen(),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.dangerous_outlined),
              label: 'Incomplete',
              activeIcon: Icon(Icons.dangerous)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Task',
              activeIcon: Icon(Icons.add)),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              label: 'Completed',
              activeIcon: Icon(Icons.check_box)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Account',
              activeIcon: Icon(Icons.person))
        ],
        currentIndex: currentIndx,
        onTap: (value) {
          setState(() {
            currentIndx = value;
            _tabController.index = value;
          });
        },
        iconSize: 20.0,
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
