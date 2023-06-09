import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EcommerceApp {
  static const String appName = 'e-Shop';

  static late SharedPreferences sharedPreferences;
  static  User? user;
  static late FirebaseAuth auth;
  static late FirebaseFirestore firestore;
  static late final String weekday = 'weekday';
  static late final String mealtime = 'mealtime';
  // static String collectionUser = "users";
  // static String collectionOrders = "orders";
  // static String userCartList = 'userCart';
  // static String subCollectionAddress = 'userAddress';

  static final String userName = 'kitchenname';
  static final String avg_rating = '5.0';
  static final String userEmail = 'email';
  // static final String userPhotoUrl = 'photoUrl';
  static final String userUID = 'uid';
  static final String userpassword = 'password';
  static final String kitchenstatus = 'true';
  static final String menuitem = 'menuitem';
  static final String price = 'price';
  static final String thumbnailUrl = 'thumbnailurl';
  static final String userAvatarUrl = 'url';
  // static final String userkitchen = 'kitchenname';
  static final String userphone = 'phone';
  // static final String userlunchtime = 'lunchtime';
  // static final String userdinnertime = 'dinnertime';
  // static final String userlunchprice = 'lunchprice';
  // static final String userdinnerprice = 'dinnerprice';
  static final String language = "English";
  static final String addressID = 'addressID';
  // static final String totalAmount = 'totalAmount';
  // static final String productID = 'productIDs';
  // static final String paymentDetails = 'paymentDetails';
  // static final String orderTime = 'orderTime';
  // static final String isSuccess = 'isSuccess';
}
