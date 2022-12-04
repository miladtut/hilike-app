import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hilike/Models/chat.dart';
import 'package:hilike/Models/message.dart';
import 'package:hilike/Models/message_support.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/Chat/Chat.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/utils.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseApi {
  static var pathhh;
  static int? x;

  static Future createThread(Map thread) async{
    print('////////////////////////////////////////////////////////////////');
    print('user');
    print('////////////////////////////////////////////////////////////////');
    final ref = FirebaseFirestore.instance.collection('chats');
    await ref.doc("${thread['sender_id']}_${thread['receiver_id']}").set({
      'id':[
        thread['sender_id'],
        thread['receiver_id']
      ],
      "sender_id":thread['sender_id'],
      "receiver_id":thread['receiver_id'],
      "sender_image":thread['sender_image'],
      "sender_nickname":thread['sender_nickname'],
      "sender_distance":thread['sender_distance'],
      "sender_plan":thread['sender_plan'],
      "updated_at":thread['updated_at'],
      "sender_gender":thread['sender_gender'],
      "sender_country":thread['sender_country'],
      "sender_age":thread['sender_age'],

      "receiver_nickname":thread['receiver_nickname'],
      "receiver_image":thread['receiver_image'],
      "receiver_plan":thread['receiver_plan'],
      "receiver_gender":thread['receiver_gender'],
      "receiver_country":thread['receiver_country'],
      "receiver_age":thread['receiver_age'],

      "text":""
    });
  }

  static Stream<List> getFireThreads(int? myID){
    return FirebaseFirestore.instance
        .collection('chats')
        .where('id',arrayContains:storage.account.id.toString())
        .snapshots()
        .transform(Utils.transformer(Fchat.fromJson));

  }
  static Future sendMessage(
      String chatThread, String message, int giftId) async {

    final ref = FirebaseFirestore.instance
        .collection('chats');
    final newMessage = Message(
      text: message,
      isGift: giftId != 0,
      giftId: giftId,
      senderId: storage.account.id ?? 0,
      status: 'waiting',
      messagedoc: "",
      createdAt: DateTime.now(),
      dflag: 0,
      sflag: 0,
    );

    print('88888888888888888888888888888888888');
    print(chatThread);
    print('88888888888888888888888888888888888');
    await ref.doc(chatThread).update({
      "text":message
    });

    await ref.doc(chatThread).collection('messages').add(newMessage.toJson()).then((ref) {
      updateMessageStatus(ref.path, "sent");
      print("object${ref.path}");
    }).catchError((error) {
      print(error);
    });
  }

  static Future sendMessageSupport(
      String chatThread, String message, int giftId, String problem) async {
    final refMessages = FirebaseFirestore.instance
        .collection('chats/$chatThread/messages');
    final newMessage = MessageSupport(
      text: message,
      isGift: giftId != 0,
      giftId: giftId,
      senderId: storage.account.id ?? 0,
      status: 'waiting',
      messagedoc: "",
      problem: problem,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson()).then((ref) {
      updateMessageStatus(ref.path, "delivered");
      print("object${ref.path}");
    }).catchError((error) {
      print(error);
    });
  }

  static Future<int> count(String chatThreads) async {
    int count = await FirebaseFirestore.instance
        .collection('chats/$chatThreads/messages')
        .where("sender_id", isNotEqualTo: storage.account.id)
        .get()
        .then((value) => value.docs
            .where((element) => element.data()["status"] == "delivered")
            .length);
    return count;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> countThreads() {
    return FirebaseFirestore.instance.collection('chats').snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> countThreads2() {
    return FirebaseFirestore.instance.collection('chats').snapshots();
  }

  static Future updateMessageStatus(String path, String newStatus) async {
    final message = FirebaseFirestore.instance.doc(path);
    message.update({"status": newStatus});
    print("path = $path");
    message.update({"messagedoc": path});
  }

  static Future updateMessageStatussss(String path, String newStatus,
      {bool? fseen}) async {
    final message = FirebaseFirestore.instance.doc(path);
    // if (newStatus == "delivered") {
    //   message.update({"status": newStatus, "dflag": 1});
    // } else if (fseen == true) {
    //   message.update({"status": newStatus, "sflag": 1});
    // } else {
    message.update({"status": newStatus});
    // }

    print("done");
    // message.update({"messagedoc": path});
  }

  // static Future updateMessageCounter() async {
  //   final message =
  //       FirebaseFirestore.instance.doc("users/${storage.account.id}");
  //   message.update({"messages_count": NavigationRow.messageCount! + 1});
  // }

  // static Future updateMessageCounterMin(int num) async {
  //   final message =
  //       FirebaseFirestore.instance.doc("users/${storage.account.id}");
  //   message.update({"messages_count": NavigationRow.messageCount! - num});
  // }

  static Future deleteToken() async {
    final message =
        FirebaseFirestore.instance.doc("users/${storage.account.id}");
    message.update({"fcmToken": ""});
    print("done");
    // message.update({"messagedoc": path});
  }

  static Future updateAllMessageStatus(String chatThreads) async {
    String path = 'chats/$chatThreads/messages/';

    FirebaseFirestore.instance
        .collection(path)
        .where("status", isEqualTo: "delivered")
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.data()['sender_id'] != storage.account.id) {
                if (element.data().isNotEmpty &&
                    element.data()['messagedoc'].toString().length > 0)
                  // AudioCache().play(file.path);
                  updateMessageStatussss(element.data()['messagedoc'], 'seen',
                      fseen: true);
              }
            }));

    // message.update({"messagedoc": path});
  }

  static Future badgeMessageCount() async {
    final message =
        FirebaseFirestore.instance.doc("users/${storage.account.id}");
    message.get();
    return await message.get().then((value) => value.data()!["messages_count"]);

    // message.update({"messagedoc": path});
  }

  static Future<bool> isUserOnline() async {
    final message =
    FirebaseFirestore.instance.doc("users/${storage.account.id}");
    message.get();
    return await message.get().then((value) => value.data()!["is_online"]);
  }

  static Future updateAllMessageStatus2(String chatThreads) async {
    String path = 'chats/$chatThreads/messages/';

    FirebaseFirestore.instance
        .collection(path)
        .where("status", isEqualTo: "sent")
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.data()['sender_id'] != storage.account.id) {
                if (element.data().isNotEmpty &&
                    element.data()['messagedoc'].toString().length > 0)
                  updateMessageStatussss(element.data()['messagedoc'], 'seen');
              }
            }));

    // message.update({"messagedoc": path});
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> mainMessageCount() {
    return FirebaseFirestore.instance
        .doc('users/${storage.account.id}')
        .snapshots();
  }

  static Stream<List<Message>> getMessages(
      {String chatThread = "", var llimitval}) {
    if (llimitval == null) {
      return FirebaseFirestore.instance
          .collection('chats/$chatThread/messages')
          // .limit(10)
          .orderBy("created_at", descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('chats/$chatThread/messages')
          .orderBy("created_at", descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
    }
  }



  static Stream<List<MessageSupport>> getSupportMessages(
      {String chatThread = "", var llimitval}) {
    if (llimitval == null) {
      return FirebaseFirestore.instance
          .collection('chats/$chatThread/messages')
          // .limit(10)
          .orderBy("created_at", descending: true)
          .snapshots()
          .transform(Utils.transformer(MessageSupport.fromJson));
    } else {
      return FirebaseFirestore.instance
          .collection('chats/$chatThread/messages')
          .orderBy("created_at", descending: true)
          // .where(
          //   "created_at",
          //   isLessThan: llimitval,
          // )
          // .limit(50)
          .snapshots()
          .transform(Utils.transformer(MessageSupport.fromJson));
    }
  }
}
