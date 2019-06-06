import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/divider_widget.dart';
import 'package:health_app/design/two_line_information_widget.dart';
import 'package:health_app/design/typography/typography.dart';
import 'package:health_app/model/record_model.dart';
import 'package:health_app/utils.dart';

class PatientWidget extends StatelessWidget {
  final PatientInformation data;

  const PatientWidget({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(24.0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Здравствуйте,", style: ModernTextTheme.caption),
          Text(data.name, style: ModernTextTheme.title),
          DividerWidget(),
          TwoLineInformationWidget(
            icon: FontAwesomeIcons.hospitalSymbol,
            iconColor: ModernTextTheme.captionIconColor,
            title: "В больницу",
            value: dateTimeToString(data.calculateNextHospitalAppointmentTime().toLocal() ?? DateTime.now()),
            unit: "",
          ),
          SizedBox(height: 16.0),
          TwoLineInformationWidget(
            icon: FontAwesomeIcons.hospital,
            iconColor: ModernTextTheme.captionIconColor,
            title: "Название",
            value: data.hospitalName,
            unit: "",
          ),
        ],
      ),
    );
  }
}