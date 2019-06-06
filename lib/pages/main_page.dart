import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:health_app/design/app_bar_widget.dart';
import 'package:health_app/design/card_widget.dart';
import 'package:health_app/design/circular_progress_reveal_widget.dart';
import 'package:health_app/model/record_model.dart';
import 'package:health_app/utils.dart';
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
    try {
      DataSnapshot snapshot = await FirebaseDatabase.instance
          .reference()
          .child("patients")
          .child("021107501405")
          .once();
      //await Future.delayed(Duration(seconds: 3));
      print(snapshot.value);
      setState(() {
        Map<String, dynamic> map = Map<String, dynamic>.from(snapshot.value);
        print(map.runtimeType);
        data = PatientInformation.fromJson(map);
        loading = false;
      });
    } catch (e) {
      showErrorSnackbarKeyed(
          key: scaffoldKey,
          context: context,
          errorMessage: "Что-то пошло не так",
          exception: e);
      setState(() {
        data = null;
        loading = false;
      });
    }
  }

  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              title: Text('Учёт'),
              action: IconButton(icon: Icon(Icons.refresh, color: Colors.blue), onPressed: () => loadData(context)),
            ),
            Expanded(
              child: (!loading && data != null)
                  ? RefreshIndicator(
                      onRefresh: () => loadData(context),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            PatientWidget(data: data),
                            SizedBox(height: 16.0),
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
                  : ((loading && data == null)
                      ? Center(
                          child:
                              CircularProgressRevealWidget(color: Colors.blue),
                        )
                      : Center(
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            iconSize: 36.0,
                            color: Colors.blue,
                            onPressed: () => loadData(context),
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
