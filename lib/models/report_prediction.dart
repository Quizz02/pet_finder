class ReportPrediction {
  int? id;
  String? animalType;
  int? weight;
  String? status;
  int? day;
  int? month;
  int? hour;

  ReportPrediction({
    this.id,
    this.animalType,
    this.weight,
    this.status,
    this.day,
    this.month,
    this.hour
  });

  ReportPrediction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animalType = json['animalType'];
    weight = json['weight'];
    status = json['status '];
    day = json['day'];
    month = json['month'];
    hour = json['hour'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['animalType'] = this.animalType;
    data['weight'] = this.weight;
    data['status '] = this.status;
    data['day'] = this.day;
    data['month'] = this.month;
    data['hour'] = this.hour;

    return data;
  }

}