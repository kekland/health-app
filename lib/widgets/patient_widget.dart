import 'package:flutter/material.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/typography/typography.dart';
import 'package:health_app/model/record_model.dart';

class PatientWidget extends StatelessWidget {
  final PatientInformation data;

  const PatientWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Здравствуйте", style: ModernTextTheme.caption),
          Text(data.name, style: ModernTextTheme.primary),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}