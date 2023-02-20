import 'package:ayyami/constants/colors.dart';
import 'package:ayyami/constants/dark_mode_colors.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  CustomRadio(this.darkMode, this.selectedlanguage, {super.key});

  bool darkMode;
  Function(String) selectedlanguage;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(RadioModel(false, 'English', 'en'));
    sampleData.add(RadioModel(false, 'اردو', 'ur'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //highlightColor: Colors.red,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
              widget.selectedlanguage(sampleData[index].language);
              print('${sampleData[index].isSelected} current selected box');
            },
            child: RadioItem(sampleData[index], widget.darkMode),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  bool darkMode;

  RadioItem(this._item, this.darkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    print('${_item.isSelected} is selected from radio item ${_item.language}');
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(_item.text),
          ),
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              gradient: _item.isSelected
                  ? AppColors.backgroundGradient
                  : AppColors.transparentGradient,
              border: Border.all(width: 1.0, color: darkMode ? AppDarkColors.headingColor : AppColors.headingColor),
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  String language;
  final String text;

  RadioModel(this.isSelected, this.text, this.language);
}
