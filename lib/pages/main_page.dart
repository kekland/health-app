import 'package:flutter/material.dart';
import 'package:health_app/design/app_bar_widget.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/circular_progress_reveal_widget.dart';
import 'package:health_app/model/record_model.dart';
import 'package:health_app/widgets/patient_widget.dart';
import 'package:health_app/widgets/record_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PatientInformation data;
  bool loading = false;

  Future loadData(BuildContext context) async {
    setState(() {
      data = null;
      loading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    PatientInformation newData = new PatientInformation(
      id: "0",
      name: "Умирбаев Алихан",
      diseaseType: "СПИД",
      hospitalName: "СПИД центр No. 1",
      hospitalPosition: LatLng(latitude: 100.0, longitude: 90.0),
      interval: Duration(days: 3),
      records: [
        for (int i = 0; i < 5; i++)
          Record(
            id: i.toString(),
            weight: 80.0 + i,
            height: 165.0 + i,
            comment: 'Вроде все заебись',
            date: DateTime(2019, 6, i + 1),
          ),
      ],
    );
    setState(() {
      data = newData;
      loading = false;
    });
  }

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              title: Text('Учёт'),
            ),
            Expanded(
              child: (!loading)
                  ? RefreshIndicator(
                      onRefresh: () => loadData(context),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            PatientWidget(data: data),
                            ...(data.records
                                .map((record) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: RecordWidget(data: record),
                                    ))
                                .toList()),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressRevealWidget(color: Colors.blue),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
