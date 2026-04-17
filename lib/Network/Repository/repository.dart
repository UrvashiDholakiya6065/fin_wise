import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_wise/Model/add_balance_model.dart';
import 'package:fin_wise/Model/chat_model.dart';
import 'package:fin_wise/Model/expense_model.dart';
import 'package:fin_wise/Model/login_model.dart';
import 'package:fin_wise/Model/notification_model.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/FirebaseInstanceClass/firebase_instance_class.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../Model/categorie_model.dart';
import '../../Screens/BottomNavScreens/Profile/ProfileWidgets/conversation_id.dart';

class Repository {
  Future<void> registerUser({required UserModel userModel}) async {
    try {
      print("User Model email:::${userModel.email}");
      print("User Model passs:::${userModel.password}");
      FirebaseInstanceClass.userCredential = await FirebaseInstanceClass.auth
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );
      print(
        "Register function called ${FirebaseInstanceClass.userCredential?.user}",
      );
      // String? uid = await SharedPref.getUserUid();

      String? uid = FirebaseInstanceClass.userCredential?.user?.uid;

      await FirebaseInstanceClass.fireStore
          .collection('users')
          .doc(uid)
          .set(userModel.toJson());

      print("User Registered Successfully");
    } catch (e) {
      throw Exception("Registration Failed: $e");
    }
  }

  Future<LoginModel?> loginUser({required LoginModel loginModel}) async {
    try {
      FirebaseInstanceClass.userCredential = await FirebaseInstanceClass.auth
          .signInWithEmailAndPassword(
            email: loginModel.email,
            password: loginModel.password,
          );

      final String? idToken = await FirebaseInstanceClass.userCredential?.user
          ?.getIdToken();
      print("GetId Token ::::::::$idToken}");
      String? uid = await SharedPref.getUserUid();

      final doc = await FirebaseInstanceClass.fireStore
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        print("User Login Successfully");
        return LoginModel.fromJson(doc.data()!);
      }
    } catch (e) {
      throw Exception("Login Failed: $e");
    }
    return null;
  }

  Future<UserModel?> getUserById() async {
    try {
      String? uid = await SharedPref.getUserUid();
      print("UID from SharedPref: $uid");

      final doc = await FirebaseInstanceClass.fireStore
          .collection('users')
          .doc(uid)
          .get();
      print("Doc exists: ${doc.exists}");
      print("Doc data: ${doc.data()}");
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
    return null;
  }

  Future<void> addCategories({required CategorieModel categorieModel}) async {
    try {
      final docRef = FirebaseInstanceClass.fireStore
          .collection('categories')
          .doc();
      categorieModel = CategorieModel(
        categorieName: categorieModel.categorieName,
        userId: (await SharedPref.getUserUid()) ?? "unknown",
        cateId: docRef.id,
      );

      SharedPref.setCateId(cateId: docRef.id);

      await docRef.set(categorieModel.toJson());

      print("Category Added Successfully with ID: ${docRef.id}");
      print("Category Added Successfully");
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  Future<List<CategorieModel>> getCategories() async {
    try {

      String? uid = await SharedPref.getUserUid();
      final snapshot = await FirebaseInstanceClass.fireStore
          .collection('categories')
          .where('userId', isEqualTo: uid)
          .get();

      return snapshot.docs
          .map((doc) => CategorieModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch categories: $e");
    }
  }

  /// Add Expense...........................................................................
  Future<void> addExpense({required ExpenseModel expenseModel}) async {
    try {
      await FirebaseInstanceClass.fireStore
          .collection('expense')
          .doc()
          .set(expenseModel.toJson());

      print("Category Added Successfully");
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  Future<List<ExpenseModel>> getExpensesByCategory(String cateId) async {
    try {
      String? uid = await SharedPref.getUserUid();

      final snapshot = await FirebaseInstanceClass.fireStore
          .collection('expense')
          .where('userId', isEqualTo: uid)
          .where('cateId', isEqualTo: cateId)
          .get();

      return snapshot.docs
          .map((doc) => ExpenseModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch expenses: $e");
    }
  }

  ///Add Balance ..........................................................................
  Future<void> addBalance({required AddBalanceModel addBalanceModel}) async {
    try {
      await FirebaseInstanceClass.fireStore
          .collection('balance')
          .doc()
          .set(addBalanceModel.toJson());

      print(" add balance Successfully");
    } catch (e) {
      throw Exception("Failed to add balance: $e");
    }
  }

  Future<AddBalanceModel?> getBalance() async {
    try {
      String? uid = await SharedPref.getUserUid();

      final snapshot = await FirebaseInstanceClass.fireStore
          .collection('balance')
          .where('userId', isEqualTo: uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return AddBalanceModel.fromJson(snapshot.docs.first.data());
      }
    } catch (e) {
      throw Exception("Failed to fetch balance: $e");
    }

    return null;
  }

  Future<void> addNotification({
    required NotificationModel notificationModel,
  }) async {
    try {
      await FirebaseInstanceClass.fireStore
          .collection('notification')
          .doc()
          .set(notificationModel.toJson());

      print(" add notification Successfully");
    } catch (e) {
      throw Exception("Failed to notification: $e");
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final data = await FirebaseInstanceClass.fireStore
          .collection('notification')
          .get();

      return data.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch notifications: $e");
    }
  }

  Future<void> updateUser({required UserModel userModel}) async {
    try {
      String? uid = await SharedPref.getUserUid();

      await FirebaseInstanceClass.fireStore
          .collection('users')
          .doc(uid)
          .update(userModel.toJson());

      print("User Updated Successfully");
    } catch (e) {
      throw Exception("Update Failed: $e");
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = FirebaseInstanceClass.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        ),
      );

      await user.updatePassword(newPassword);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'password': newPassword, 'updatedAt': FieldValue.serverTimestamp()},
      );
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'wrong-password'
          ? "Current password is incorrect"
          : "Failed to change password please check current password";
      throw Exception(message);
    }
  }

  Future<UserModel?> getCurrentUserDetails() async {
    try {
      final user = FirebaseInstanceClass.auth.currentUser;

      if (user != null) {
        final userId = user.uid;

        final userData = await FirebaseInstanceClass.fireStore
            .collection('users')
            .doc(userId)
            .get();

        if (userData.exists) {
          return UserModel.fromJson(userData.data()!).copyWith(
            uid: user.uid,
          );
        }
      }

      return null;
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  Future<List<UserModel>> getAllAdmins() async {
    try {
      final snapshot = await FirebaseInstanceClass.fireStore
          .collection("users")
          .where("role", isEqualTo: "admin")
          .get();

      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data()).copyWith(
          uid: doc.id,
        );
      }).toList();
    } catch (e) {
      print("Error fetching doctors: $e");
      return [];
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await FirebaseInstanceClass.fireStore
          .collection("users")
          .where("role", isEqualTo: "user")
          .get();

      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data()).copyWith(
          uid: doc.id,
        );
      }).toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  // Future<void> sendMessage({required ChatModel chatModel}) async {
  //   try {
  //     String conversationId = getConversationId(
  //       chatModel.senderId ?? "",
  //       chatModel.receiverId ?? "",
  //     );
  //
  //     print("Conversation ID::: $conversationId");
  //     print("Message JSON::: ${chatModel.toJson()}");
  //
  //
  //     await FirebaseFirestore.instance
  //         .collection("conversations")
  //         .doc(conversationId)
  //         .collection("chat")
  //         .add(chatModel.toJson());
  //
  //     print("Message sent successfully");
  //   } catch (e, stack) {
  //     print("FIRESTORE ERROR: $e");
  //     print("STACK: $stack");
  //   }
  // }



  Future<void> sendMessage({required ChatModel chatModel}) async {
    try {
      String conversationId = getConversationId(
        chatModel.senderId ?? "",
        chatModel.receiverId ?? "",
      );

      final chatRef = FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversationId)
          .collection("chat");

      final conversationRef = FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversationId);

      await chatRef.add(chatModel.toJson());

      await conversationRef.set({
        "lastMessage": chatModel.msg,
        "lastMessageTime": FieldValue.serverTimestamp(),
        "lastSenderId": chatModel.senderId,
        "lastMessageRead": false,
      }, SetOptions(merge: true));

      print("Message sent successfully");
    } catch (e) {
      print("Error: $e");
    }
  }
  Stream<List<ChatModel>> getMessages(String conversationId) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationId)
        .collection("chat")
        .orderBy("time")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      return ChatModel.fromJson(doc.data(), doc.id);
    }).toList());
  }

  // Future<void> markMessagesAsRead(String conversationId, String currentUserId) async {
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection("conversations")
  //       .doc(conversationId)
  //       .collection("chat")
  //       .where("receiverId", isEqualTo: currentUserId)
  //       .where("isRead", isEqualTo: false)
  //       .get();
  //
  //   for (var doc in snapshot.docs) {
  //     await doc.reference.update({"isRead": true});
  //   }
  //   await FirebaseFirestore.instance
  //       .collection("conversations")
  //       .doc(conversationId)
  //       .update({
  //     "lastMessageRead": true,
  //   });
  // }

  Future<void> markMessagesAsRead(
      String conversationId,
      String currentUserId,
      ) async {

    final convoRef = FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationId);

    final convo = await convoRef.get();

    if (!convo.exists) return;

    final data = convo.data() as Map<String, dynamic>;

    if (data['lastSenderId'] == currentUserId) {
      return;
    }

    final snapshot = await convoRef
        .collection("chat")
        .where("receiverId", isEqualTo: currentUserId)
        .where("isRead", isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({"isRead": true});
    }

    await convoRef.update({
      "lastMessageRead": true,
    });
  }
  Stream<int> getUnreadCount(String conversationId, String currentUserId) {
    return FirebaseFirestore.instance
        .collection("conversations")
        .doc(conversationId)
        .collection("chat")
        .where("receiverId", isEqualTo: currentUserId)
        .where("isRead", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
  Future<void> deleteMessages(
      String conversationId,
      List<String> messageIds,
      ) async {
    for (var id in messageIds) {
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(conversationId)
          .collection('chat')
          .doc(id)
          .delete();
    }
  }
  Future<void> editMessage(String conversationId, String messageId, String newMsg) async {
    try {
      await FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversationId)
          .collection("chat")
          .doc(messageId)
          .update({
        'msg': newMsg,
        'isEdited': true,
      });
      print("Message edited successfully");
    } catch (e) {
      print("Failed to edit message: $e");
    }
  }


}
