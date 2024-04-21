import 'package:bmi_calculator/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BMIPageState();
  }
}

class _BMIPageState extends State<BMIPage> {
  late double _deviceHeight, _deviceWidth;
  int _age = 25, _weight = 60, _height = 170, _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Center(
        child: SizedBox(
          height: _deviceHeight * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ageSelect(),
                  _weightSelect(),
                ],
              ),
              _heightSlider(),
              _genderSlidingSegmented(),
              _calculateBMIButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ageSelect() {
    return InfoCard(
      height: _deviceHeight * 0.2,
      width: _deviceWidth * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Age (years)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _age.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      if(_age > 0) {
                        _age--;
                      }
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                  child: const Text(
                    '-'
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age++;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                  child: const Text(
                    '+'
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weightSelect() {
    return InfoCard(
      height: _deviceHeight * 0.2,
      width: _deviceWidth * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Weight (kg)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _weight.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      if(_weight > 0) {
                        _weight--;
                      }
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                  child: const Text(
                    '-'
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight++;
                    });
                  },
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                  child: const Text(
                    '+'
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heightSlider() {
    return InfoCard(
      height: _deviceHeight * 0.2,
      width: _deviceWidth * 0.90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Height (cm)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _height.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: _deviceWidth * 0.75,
            child: CupertinoSlider(
              value: _height.toDouble(),
              min: 0,
              max: 250,
              divisions: 250,
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                });
              }
            ),
          ),
        ],
      ),
    );
  }
  Widget _genderSlidingSegmented() {
    return InfoCard(
      height: _deviceHeight * 0.12,
      width: _deviceWidth * 0.90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children: const {
              0: Text('Male'),
              1: Text('Female'),
            },
            onValueChanged: (value) {
              setState(() {
                _gender = value as int;
              });
            }
          ),
        ],
      ),
    );
  }

  Widget _calculateBMIButton() {
    return SizedBox(
      height: _deviceHeight * 0.07,
      width: _deviceWidth * 0.7,
      child: CupertinoButton.filled(
        child: const Text(
          'Calculate BMI',
        ),
        onPressed: () {
          if(_weight > 0 && _height > 0) {
            double bmi  = _weight / pow(_height / 100, 2);
            _showResultDialog(bmi);
          }
        },
      ),
    );
  }

  void _showResultDialog(double bmi) {
    String? status;
    if(bmi < 18.5) {
      status = 'Underweight';
    }
    else if(bmi >= 18.5 && bmi < 24.9) {
      status = 'Normal';
    }
    else if(bmi >= 25 && bmi < 29.9) {
      status = 'Overweight';
    }
    else {
      status = 'Obese';
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            status!,
          ),
          content: Text(
            bmi.toStringAsFixed(2),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                'Ok',
              ),
              onPressed: () {
                _saveResult(bmi.toStringAsFixed(2), status!);
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  void _saveResult(String bmi, String status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'bmiDate',
      DateTime.now().toString(),
    );
    await prefs.setStringList(
      'bmiData',
      <String>[
        bmi,
        status,
      ],
    );
  }
}