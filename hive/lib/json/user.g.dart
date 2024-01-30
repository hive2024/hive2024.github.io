// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['email'] as String,
      json['lastLogin'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'lastLogin': instance.lastLogin,
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      json['id'] as int,
      json['title'] as String?,
      json['subTitle'] as String?,
      json['icon'] as String?,
      json['desc'] as String?,
      json['startTime'] as String?,
      json['endTime'] as String?,
      json['status'] as int,
      json['createTime'] as String?,
      json['lang'] as String?,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('subTitle', instance.subTitle);
  writeNotNull('icon', instance.icon);
  writeNotNull('desc', instance.desc);
  writeNotNull('startTime', instance.startTime);
  writeNotNull('endTime', instance.endTime);
  val['status'] = instance.status;
  writeNotNull('createTime', instance.createTime);
  writeNotNull('lang', instance.lang);
  return val;
}

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      json['uid'] as String,
      json['level'] as int,
      json['income'] as String,
      json['allIncome'] as String,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'uid': instance.uid,
      'level': instance.level,
      'income': instance.income,
      'allIncome': instance.allIncome,
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['id'] as int,
      json['level'] as int,
      json['status'] as int,
      json['title'] as String?,
      json['desc'] as String?,
      json['icon'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'level': instance.level,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('desc', instance.desc);
  writeNotNull('icon', instance.icon);
  return val;
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['uid'] as int,
      json['level'] as int,
      json['balance'] as String?,
      json['phone'] as String?,
      json['icon'] as String?,
      json['chargeWalletAddress'] as String?,
      json['settleWalletAddress'] as String?,
      json['chartUrl'] as String?,
      json['whatsappUrl'] as String?,
      json['telegramUrl'] as String?,
      json['messagerUrl'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'level': instance.level,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('balance', instance.balance);
  writeNotNull('phone', instance.phone);
  writeNotNull('icon', instance.icon);
  writeNotNull('chargeWalletAddress', instance.chargeWalletAddress);
  writeNotNull('settleWalletAddress', instance.settleWalletAddress);
  writeNotNull('chartUrl', instance.chartUrl);
  writeNotNull('whatsappUrl', instance.whatsappUrl);
  writeNotNull('telegramUrl', instance.telegramUrl);
  writeNotNull('messagerUrl', instance.messagerUrl);
  return val;
}

UserRevenue _$UserRevenueFromJson(Map<String, dynamic> json) => UserRevenue(
      json['uid'] as int,
      json['todaySum'] as int,
      json['teamSum'] as int,
      json['todayLevel1IncomeSum'] as String?,
      json['todayLevel2IncomeSum'] as String?,
      json['todaySelfIncomeSum'] as String?,
      json['todayAllIncomeSum'] as String?,
      json['mouthADIncomeSum'] as String?,
      json['adAllIncomeSum'] as String?,
    );

Map<String, dynamic> _$UserRevenueToJson(UserRevenue instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
    'todaySum': instance.todaySum,
    'teamSum': instance.teamSum,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('todayLevel1IncomeSum', instance.todayLevel1IncomeSum);
  writeNotNull('todayLevel2IncomeSum', instance.todayLevel2IncomeSum);
  writeNotNull('todaySelfIncomeSum', instance.todaySelfIncomeSum);
  writeNotNull('todayAllIncomeSum', instance.todayAllIncomeSum);
  writeNotNull('mouthADIncomeSum', instance.mouthADIncomeSum);
  writeNotNull('adAllIncomeSum', instance.adAllIncomeSum);
  return val;
}
