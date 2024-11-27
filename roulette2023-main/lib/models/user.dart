import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name, email;
  int won , lost;
  int score;
  Timestamp slotTime;
  num wallet;
  String avatar;

  UserData(this.name, this.email, this.slotTime, this.wallet, this.score,
      this.avatar , this.won , this.lost);

  UserData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        slotTime = (json['slotTime'] is int)
            ? Timestamp.fromMillisecondsSinceEpoch(json['slotTime'])
            : json['slotTime'],
        wallet = json['wallet'],
        score = json['score'],
        avatar = json['avatar'],
        won = json['won'],
        lost = json['lost'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'slotTime': slotTime,
        'wallet': wallet,
        'score': score,
        'avatar': avatar,
        'won':won,
        'lost':lost
      };
}
