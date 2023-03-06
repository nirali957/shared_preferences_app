class UserModel {
  final String? title;
  final String? date;

  UserModel({
    this.title,
    this.date,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        date = json['date'] as String?;

  Map<String, dynamic> toJson() => {'title': title, 'date': date};
}
