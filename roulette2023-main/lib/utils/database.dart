import 'dart:math';
import 'package:ntp/ntp.dart';
import 'package:roulette2023/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  static Timestamp now = Timestamp.now();
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference matchCollection =
      FirebaseFirestore.instance.collection('matches');
  static UserData currentUser =
      UserData('', '', now, 2000, 0, Random().nextInt(10000).toString(), 0, 0);

  // static void listenCurrUserChanges() {
  //   userCollection
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots()
  //       .listen((event) {
  //     currentUser = UserData.fromJson(event.data()! as Map<String, dynamic>);
  //   });
  // }

  static Future<UserData> updateCurrentUser() async {
    var snapshot =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    currentUser = UserData.fromJson(snapshot.data() as Map<String, dynamic>);
    return currentUser;
  }

  // static Future<void> setAvatar(int avatar) async {
  //   currentUser.avatar = avatar;
  //   await userCollection
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .update({'avatar': avatar});
  // }

  static Future<List<Map<String, dynamic>>> getMyBets() async {
    List<Future<Map<String, dynamic>>> games = await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bets')
        .get()
        .then((snap) => snap.docs.map((doc) async {
              var snapshot = await matchCollection.doc(doc.id).get();
              Map<String, dynamic> game = doc.data();
              game.addAll(snapshot.data() as Map<String, dynamic>);
              return game;
            }).toList());
    return await Future.wait(games);
  }

  static Future<void> storeUserData(
      {required String name,
      required String email,
      required String id,
      required Timestamp slotTime}) async {
    DocumentReference documentReferencer = userCollection.doc(id);
    UserData data = UserData(name, email, slotTime, 2000, 0,
        Random().nextInt(10000).toString(), 0, 0);
    currentUser = data;
    await documentReferencer.set(data.toJson());
  }

  static Future<void> storeBetData(
      String matchId, int amount, String college) async {
    final data = {"betAmount": amount, "college": college};
    if (currentUser.wallet < amount) {
      return Future.error("Insufficient balance");
    } else if (amount == 0) {
      return Future.error("Bet amount cannot be 0");
    }

    await userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bets')
        .doc(matchId)
        .get()
        .then((doc) {
      if (doc.exists) return Future.error("Already betted");
    });
    final waitList = <Future<void>>[];
    waitList.add(userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bets')
        .doc(matchId)
        .set(data));

    waitList.add(matchCollection
        .doc(matchId)
        .update({"roulette.${FirebaseAuth.instance.currentUser!.uid}": data}));

    waitList.add(userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"wallet": FieldValue.increment(-amount)}));
    await Future.wait(waitList)
        .whenComplete(() => currentUser.wallet -= amount);
  }

  static Future<void> updateWallet(int winAmount) {
    return userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "wallet": Database.currentUser.wallet + winAmount
    }).whenComplete(() => currentUser.wallet += winAmount);
  }

  static Future<void> updateSlotTime() {
    return userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {"slotTime": now}).whenComplete(() => currentUser.slotTime = now);
  }

  static Stream<QuerySnapshot> getLeaderboardData() {
    return userCollection.orderBy('score', descending: true).snapshots();
  }

  static Stream<QuerySnapshot> retrieveMatches() => matchCollection.snapshots();

  static Future<void> syncTime() {
    final local = DateTime.now().toLocal();
    return NTP.getNtpOffset(localTime: local).then((offset) =>
        now = Timestamp.fromDate(local.add(Duration(milliseconds: offset))));
  }
}
