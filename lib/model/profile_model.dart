class ProfileModel {
  final String? profilePictureUrl;
  final String? name;
  final int? basketballSkill;
  final String? location;
  final int? age;
  final String? gender;

  ProfileModel({
    required this.gender,
    required this.name,
    required this.age,
    required this.basketballSkill,
    required this.location,
    required this.profilePictureUrl,
  });

  ProfileModel.fromJson({
    required Map<String, dynamic> json,
  })
      : gender = json['gender'],
        name = json['name'],
        profilePictureUrl = json['profilePictureUrl'],
        location = json['location'],
        age = json['age'],
        basketballSkill = json['basketballSkill'];

  Map<String, dynamic> toJson() {
    return {
      'profilePictureUrl': profilePictureUrl,
      'name': name,
      'basketballSkill': basketballSkill,
      'location': location,
      'age': age,
      'gender': gender,
    };
  }

  ProfileModel copyWith({
    String? profilePictureUrl,
    String? name,
    int? basketballSkill,
    String? location,
    int? age,
    String? gender,
  }) {
    return ProfileModel(
      gender: gender ?? this.gender,
      name: name ?? this.name,
      age: age ?? this.age,
      basketballSkill: basketballSkill ?? this.basketballSkill,
      location: location ?? this.location,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,);
  }

}
