import 'package:bmi_calculator/pages/bmi_page.dart';
import 'package:bmi_calculator/pages/history_page.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  late double _deviceHeight;

  final List<Widget> _tabs = [
    const BMIPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          "BMI Calculator"
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          height: _deviceHeight * 0.06,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 25,
              ),
              label: 'BMI',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
                size: 25,
              ),
              label: 'History',
            ),
          ],
        ),
        tabBuilder: (context, index) => CupertinoTabView(
          builder: (context) => _tabs[index],
        ),
      ),
    );
  }
}