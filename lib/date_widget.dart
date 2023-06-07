/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final bool dateIsSelected;

  DateWidget({
    required this.date,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    required this.dateIsSelected,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
          width: width,
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: selectionColor,
          ),
          duration: const Duration(milliseconds: 700),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: dateIsSelected
                    ? <Widget>[ TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds:500),
                      tween: Tween<double>(begin: 1, end: 15),
                      builder: (_, size, __) => {
                        Text(' ', style: monthTextStyle),
                        Text(new DateFormat("EEEE", locale).format(date).toUpperCase(), style: TextStyle(fontSize: size, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)),
                        Text(new DateFormat("d MMM y", locale).format(date).toUpperCase(), style: TextStyle(fontSize: size, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold))
                      }
                    )
                      ]
                    : <Widget>[
                        Text(new DateFormat("MMM", locale).format(date).toUpperCase(), // Month
                            style: monthTextStyle),
                        Text(date.day.toString(), // Date
                            style: dateTextStyle),
                        Text(new DateFormat("E", locale).format(date).toUpperCase(), // WeekDay
                            style: dayTextStyle)
                      ],
              ),
            ),
          )),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected!(this.date);
        }
      },
    );
  }
}
