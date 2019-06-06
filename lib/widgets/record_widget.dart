import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/divider_widget.dart';
import 'package:health_app/design/two_line_information_widget.dart';
import 'package:health_app/design/typography/typography.dart';
import 'package:health_app/model/record_model.dart';
import 'package:health_app/utils.dart';

class RecordWidget extends StatelessWidget {
  final Record data;

  const RecordWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(24.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(dateTimeToString(data.date), style: ModernTextTheme.caption),
          SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.spaceBetween,
              children: [
                TwoLineInformationWidget(
                  icon: FontAwesomeIcons.weight,
                  value: data.weight.toStringAsFixed(0),
                  iconColor: Colors.blue,
                  unit: 'кг.',
                  title: 'Вес',
                ),
                TwoLineInformationWidget(
                  icon: FontAwesomeIcons.arrowsAltV,
                  value: data.height.toStringAsFixed(0),
                  iconColor: Colors.blue,
                  unit: 'см.',
                  title: 'Рост',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          DividerWidget(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Комментарий",
                      style: ModernTextTheme.caption
                          .copyWith(color: Colors.white70)),
                  Text(data.comment,
                      style: ModernTextTheme.primary
                          .copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
