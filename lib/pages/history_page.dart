import 'package:bmi_calculator/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  late double _deviceHeight, _deviceWidth;
  SharedPreferences? _prefs;
  String? _bmiDate;
  List<String>? _bmiData;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dataCard(),
          const SizedBox(
            height: 20,
          ),
          _updateDataButton(),
        ],
      ),
    );
  }

  Widget _dataCard() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          _prefs = snapshot.data as SharedPreferences;
          _bmiDate = _prefs!.getString('bmiDate');
          _bmiData = _prefs!.getStringList('bmiData');

          return Center(
            child: InfoCard(
              height: _deviceHeight * 0.25,
              width: _deviceWidth * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _statusText(_bmiData != null ? _bmiData![1] : 'Not Found'),
                  _dateText(_bmiDate ?? 'Not Found', _bmiDate != null ? true : false),
                  _bmiText(_bmiData != null ? _bmiData![0] : '0'),
                ],
              ),
            ),
          );
        }
        else {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Widget _statusText(String status) {
    return Text(
      status,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateText(String date, bool foundDate) {
    if(foundDate) {
      DateTime parsedDate = DateTime.parse(date);
      date = "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
    }
    return Text(
      date,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _bmiText(String bmi) {
    return Text(
      bmi,
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _updateDataButton() {
    return SizedBox(
      height: _deviceHeight * 0.07,
      width: _deviceWidth * 0.75,
      child: CupertinoButton.filled(
        child: const Text(
          'Update',
        ),
        onPressed: () {
          setState(() {
            _bmiDate = _prefs!.getString('bmiDate');
            _bmiData = _prefs!.getStringList('bmiData');
          });
        },
      ),
    );
  }
}