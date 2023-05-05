class GuestModel {
  final String? location;
  final String? dDay;
  final DateTime? date;
  final int? requiredNumber;
  final int? age;
  final int? basketballSkill;
  final String? gender;

  GuestModel({
    required this.location,
    required this.dDay,
    required this.age,
    required this.date,
    required this.basketballSkill,
    required this.requiredNumber,
    required this.gender,
  });

  GuestModel.fromJson({
    required Map<String, dynamic> json,
  })
      : location = json['location'],
        dDay = json['dDay'],
        date = DateTime.parse(json['date']),
        requiredNumber = json['requiredNumber'],
        age = json['age'],
        basketballSkill = json['basketballSkill'],
        gender = json['gender'];

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'dDay': dDay,
      'date': '${date!.year}${date!.month.toString().padLeft(2, '0')}${date!.day
          .toString().padLeft(2, '0')}',
      'requiredNumber': requiredNumber,
      'age': age,
      'basketballSkill': basketballSkill,
      'gender': gender,
    };
  }
}