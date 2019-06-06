class Record {
  double weight;
  double height;
  String comment;
  DateTime date;

  Record({this.weight, this.height, this.comment, this.date});

  Record.fromJson(Map json) {
    this.weight = (json['weight'] as num).toDouble();
    this.height = (json['height'] as num).toDouble();
    this.comment = json['comment'] as String;
    this.date = DateTime.parse(json['date']);
  }
}

class LatLng {
  double latitude;
  double longitude;

  LatLng({this.latitude, this.longitude});

  LatLng.fromJson(Map json) {
    latitude = (json['latitude'] as num).toDouble();
    longitude = (json['longitude'] as num).toDouble();
  }
}

class PatientInformation {
  String name;

  List<Record> records;
  String diseaseType;

  Duration interval;
  DateTime startTime;
  int count;

  String hospitalName;
  LatLng hospitalPosition;

  PatientInformation(
      {this.records,
      this.name,
      this.diseaseType,
      this.interval,
      this.hospitalName,
      this.hospitalPosition,
      this.count,
      this.startTime});

  PatientInformation.fromJson(Map json) {
    name = json['name'] as String;
    List recs = json['records'];
    records = [];
    for (Map rec in recs) {
      records.add(Record.fromJson(rec));
    }
    diseaseType = json['diseaseType'] as String;
    startTime =
        DateTime.fromMillisecondsSinceEpoch(json['timing']['startTime'] * 1000);
    count = json['timing']['count'] as int;
    interval = Duration(seconds: json['timing']['interval'] as int);
    hospitalName = json['hospital']['name'];
    hospitalPosition = LatLng.fromJson(json['hospital']['position']);
  }

  DateTime calculateNextHospitalAppointmentTime() {
    DateTime now = DateTime.now();
    print(startTime);
    print(interval);
    print(count);

    DateTime time = now;

    for (int i = 0; i < count; i++) {
      if (time.isAfter(now)) {
        return time;
      }
      time = time.add(interval);
    }
    return null;
  }
}
