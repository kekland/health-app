class Record {
  String id;
  double weight;
  double height;
  String comment;
  DateTime date;

  Record({this.id, this.weight, this.height, this.comment, this.date});

  Record.fromJson(Map<String, dynamic> json) {
    this.id = json['id'] as String;
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

  LatLng.fromJson(Map<String, dynamic> json) {
    latitude = (json['latitude'] as num).toDouble();
    longitude = (json['longitude'] as num).toDouble();
  }
}

class PatientInformation {
  String id;
  String name;

  List<Record> records;
  String diseaseType;
  Duration interval;
  
  String hospitalName;
  LatLng hospitalPosition;

  PatientInformation({this.id, this.records, this.name, this.diseaseType, this.interval, this.hospitalName, this.hospitalPosition});

  PatientInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    records = (json['records'] as List<dynamic>).map((rec) => Record.fromJson(rec)).toList();
    diseaseType = json['diseaseType'] as String;
    interval = Duration(seconds: json['interval'] as int);
    hospitalName = json['hospital']['name'];
    hospitalPosition = LatLng.fromJson(json['hospital']['position']);
  }
}