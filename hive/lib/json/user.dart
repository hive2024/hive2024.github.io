import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'user.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {
  User(this.name, this.email, this.lastLogin);

  String name;
  String email;
  String lastLogin;

  factory User.empty() => User("", "", "");
  //不同的类使用不同的mixin即可
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// @JsonSerializable(explicitToJson: true)
// class ActivityList {
//   ActivityList(this.data);

//   List<Actiity> data;

//   factory ActivityList.empty() => ActivityList([]);
//   //不同的类使用不同的mixin即可
//   factory ActivityList.fromJson(Map<String, dynamic> json) =>
//       _$ActivityListFromJson(json);
//   Map<String, dynamic> toJson() => _$ActivityListToJson(this);
// }

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Activity {
  Activity(this.id, this.title, this.subTitle, this.icon, this.desc,
      this.startTime, this.endTime, this.status, this.createTime, this.lang);

  int id;
  String? title;
  String? subTitle;
  String? icon;
  String? desc;
  String? startTime;
  String? endTime;
  int status;
  String? createTime;
  String? lang;

  factory Activity.empty() => Activity(0, "", "", "", "", "", "", 0, "", "");
  //不同的类使用不同的mixin即可
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Promotion {
  Promotion(this.uid, this.level, this.income, this.allIncome);
  String uid;
  int level;
  String income;
  String allIncome;

  factory Promotion.empty() => Promotion("", 0, "", "");
  //不同的类使用不同的mixin即可
  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);
  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Task {
  Task(this.id, this.level, this.status, this.title, this.desc, this.icon);

  int id;
  int level;
  int status;
  String? title;
  String? desc;
  String? icon;

  factory Task.empty() => Task(0, 0, 0, "", "", "");
  //不同的类使用不同的mixin即可
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UserInfo {
  UserInfo(
      this.uid,
      this.level,
      this.balance,
      this.phone,
      this.icon,
      this.chargeWalletAddress,
      this.settleWalletAddress,
      this.chartUrl,
      this.whatsappUrl,
      this.telegramUrl,
      this.messagerUrl,
      this.levelIcon);

  int uid;
  int level;

  String? balance;
  String? phone;
  String? icon;
  String? chargeWalletAddress;
  String? settleWalletAddress;
  String? chartUrl;
  String? whatsappUrl;
  String? telegramUrl;
  String? messagerUrl;
  String? levelIcon;

  factory UserInfo.empty() =>
      UserInfo(0, 0, "", "", "", "", "", "", "", "", "","");
  //不同的类使用不同的mixin即可
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UserRevenue {
  UserRevenue(
    this.uid,
    this.todaySum,
    this.teamSum,
    this.todayLevel1IncomeSum,
    this.todayLevel2IncomeSum,
    this.todaySelfIncomeSum,
    this.todayAllIncomeSum,
    this.mouthADIncomeSum,
    this.adAllIncomeSum,
  );

  int uid;
  int todaySum;
  int teamSum;
  String? todayLevel1IncomeSum;
  String? todayLevel2IncomeSum;
  String? todaySelfIncomeSum;
  String? todayAllIncomeSum;
  String? mouthADIncomeSum;
  String? adAllIncomeSum;

  factory UserRevenue.empty() => UserRevenue(0, 0, 0, "", "", "", "", "", "");
  //不同的类使用不同的mixin即可
  factory UserRevenue.fromJson(Map<String, dynamic> json) =>
      _$UserRevenueFromJson(json);
  Map<String, dynamic> toJson() => _$UserRevenueToJson(this);
}
