class User {
  final String id;
  final String nim;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profilePic;
  final String? faculty;
  final String? studyProgram;
  final String? graduationYear;
  final String? dateOfBirth;
  final String? cv;

  const User({
    required this.id,
    required this.nim,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profilePic,
    this.faculty,
    this.studyProgram,
    this.graduationYear,
    this.dateOfBirth,
    this.cv,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nim: json['nim'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePic: json['profile_pic'],
      faculty: json['faculty'],
      studyProgram: json['study_program'],
      graduationYear: json['graduation_year'],
      dateOfBirth: json['date_of_birth'],
      cv: json['cv'],
    );
  }
}
