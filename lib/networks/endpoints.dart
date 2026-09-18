
const String url = "";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class EndPoints {
  EndPoints._();
  static String login() => "";
  static String signup() => "";
  static String verifyOtp() => "";
  static String forgetPass() => "";
  static String verifyForgetPass() => "";
  static String resendOtp() => "";
  static String resendForgetOtp() => "";
  static String resetPassword() => "";
  static String userProfile() => "";
  static String updateProfile() => "";
  static String logout() => "";
  static String allAlbums() => "";
  static String allbumsDetails(int id) => "";
  static String review() => "";
  static String reviewLike(int id) => "";
  static String reviewComment() => "";
  static String addFriend() => "";
  static String requestList() => "";
  static String myAllFriend() => "";

  static String acceptRequest() => "";
  static String sendRequest() => "";
  static String userChatList() => "";
  static String sendMessage(int id) => "";
  static String singleChat(int receiverId) => "";
  static String userDetails() => "";
  static String myAlumbs(int type) => "";
  static String createAlumbs() => "";
  static String deleteAccount() => "";
  static String festive() => "";
  static String wishList() => "";
  static String postWishList(int id) => "";
  static String searchFestival(String search) => "";
  static String unFriend(int id) => "";
  static String friendBlock() => "";
  static String blockUser() => "";
  static String unBlockUser() => "";
  static String faq() => "";
  static String contactMessage() => "";
  static String postWish(int id) => "";
  static String termsAndCondition() => "";
  static String privacyPolicy() => "";
  static String privateAlbums() => "";
  static String publicAlbums() => "";
  static String reportUser(int id) => "";
  static String reportFestival(int id) => "";
}
