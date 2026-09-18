// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:llr/features/auth/personal_info_screen.dart';
import 'package:llr/features/auth/presentation/forgot_pass/forgot_password_screen.dart';
import 'package:llr/features/auth/presentation/forgot_pass/verify_otp_screen.dart';
import 'package:llr/features/auth/presentation/login/login_screen.dart';
import 'package:llr/features/auth/presentation/reset_password_complete/reset_password_screen.dart';
import 'package:llr/features/auth/presentation/signup/signup_screen.dart';
import 'package:llr/features/auth/presentation/verification_complete/verification_complete_screen.dart'
    show VerificationCompleteScreen;
import 'package:llr/features/auth/presentation/verify_otp/verify_otp_screen.dart';
import 'package:llr/features/block/presentation/block_screen.dart';
import 'package:llr/features/chat/presentation/chat_list_screen.dart';
import 'package:llr/features/chat/presentation/chat_with_friend_screen.dart';
import 'package:llr/features/create_alumubs/presentation/create_alumbs.dart';
import 'package:llr/features/festival_details/presentation/album_media_screen.dart';
import 'package:llr/features/festival_details/presentation/festival_details_screen.dart';
import 'package:llr/features/festival_details/presentation/past_festival_screen.dart';
import 'package:llr/features/friend/presentation/add_friend_screen.dart';
import 'package:llr/features/friend/presentation/friend_request_screen.dart';
import 'package:llr/features/help_and_support/presentation/help_and_support_screen.dart';
import 'package:llr/features/navigation_screen.dart';
import 'package:llr/features/notification/notification_screen.dart';
import 'package:llr/features/privacy_policy/presentation/privacy_policy_screen.dart';
import 'package:llr/features/profile/presentation/all_alumbs_screen.dart';
import 'package:llr/features/profile/presentation/all_wishlist_screen.dart';
import 'package:llr/features/profile/presentation/edit_profile_screen.dart';
import 'package:llr/features/profile/presentation/user_profile_screen.dart';
import 'package:llr/features/terms_and_condition/presentation/terms_and_conditions_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String navigationScreen = '/navigation_screen';

  static const String loginScreen = '/login_screen';
  static const String signupScreen = '/signup_screen';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String verifyOtpScreen = '/verifyOtpScreen';
  static const String verificationCompleteScreen =
      '/verificationCompleteScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String confirmScreen = '/confirmScreen';
  static const String userVerifyScreen = '/userVerifyScreen';
  static const String homeScreen = '/homeScreen';
  static const String tripDetailsScreen = '/tripDetailsScreen';
  static const String bookingCardDetailsScreen = '/bookingCardDetailsScreen';
  static const String addToListScreen = '/addToListScreen';
  static const String setUpProfileScreen = '/setUpProfileScreen';
  static const String resetOtpVerifyScreen = '/resetOtpVerifyScreen';
  static const String festivalDetailsScreen = '/festivalDetailsScreen';
  static const String pastFestialvalDetailsScreen =
      '/pastFestialvalDetailsScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String friendRequestScreen = '/friendRequestScreen';
  static const String chatListScreen = '/chatListScreen';
  static const String chatWithFriendScreen = '/chatWithFriendScreen';
  static const String addFriendListScreen = '/addFriendListScreen';
  static const String createAlumbs = '/createAlumbs';
  static const String userProfileScreen = '/userProfileScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String allwishlistScreen = '/AllwishlistScreen';
  static const String allAlumbsScreen = "/AllAlumbsScreen";
  static const String termsAndConditionsScreen = "/termsAndConditionsScreen";
  static const String privacyPolicyScreen = "/privacyPolicyScreen";
  static const String helpAndSupportScreen = "/helpAndSupportScreen";
  static const String blockUserScreen = "/blockUserScreen";
  static const String albumMediaScreen = "/albumMediaScreen";
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const LoginScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const LoginScreen());
      case Routes.resetOtpVerifyScreen:
        final args = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: VerifyOtpResetPassor(email: args?['email']),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => VerifyOtpResetPassor(email: args?['email']),
            );

      case Routes.forgetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const ForgotPasswordScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const ForgotPasswordScreen(),
            );

      case Routes.allwishlistScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const AllWishlistScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const AllWishlistScreen(),
            );

      case Routes.allAlumbsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const AllAlumbsScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const AllAlumbsScreen());

      case Routes.userProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const UserProfileScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const UserProfileScreen(),
            );

      case Routes.addFriendListScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const AddFriendListScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const AddFriendListScreen(),
            );

      case Routes.createAlumbs:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: CreateAlbumScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const CreateAlbumScreen(),
            );
      case Routes.chatListScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const ChatListScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const ChatListScreen());

      case Routes.friendRequestScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const FriendRequestScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const FriendRequestScreen(),
            );

      case Routes.resetPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const ResetPasswordScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const ResetPasswordScreen(),
            );

      case Routes.pastFestialvalDetailsScreen:
        final args = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: PastFestivalDetailsScreen(id: args?['id']),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => PastFestivalDetailsScreen(id: args?['id']),
            );

      case Routes.albumMediaScreen:
        final args = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: AlbumMediaScreen(
                documents: args?['documents'] ?? [],
                initialIndex: args?['initialIndex'] ?? 0,
              ),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder:
                  (context) => AlbumMediaScreen(
                    documents: args?['documents'] ?? [],
                    initialIndex: args?['initialIndex'] ?? 0,
                  ),
            );

      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const NotificationScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const NotificationScreen(),
            );
      case Routes.setUpProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const PersonalInfoScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              settings: settings,
              builder: (context) => const PersonalInfoScreen(),
            );

      case Routes.signupScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const SignupScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const SignupScreen());

      case Routes.chatWithFriendScreen:
        final args = settings.arguments as Map?;

        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: ChatWithFriendScreen(
                id: args?['id'],
                roomId: args?['roomId'],
                name: args?['name'],
                image: args?['image'],
              ),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder:
                  (context) => ChatWithFriendScreen(
                    id: args?['id'],
                    roomId: args?['roomId'],
                    name: args?['name'],
                    image: args?['image'],
                  ),
            );

      case Routes.verifyOtpScreen:
        final args = settings.arguments as Map?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: VerifyOtpScreen(email: args?['email']),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => VerifyOtpScreen(email: args?['email']),
            );

      case Routes.verificationCompleteScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const VerificationCompleteScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const VerificationCompleteScreen(),
            );
      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const NavigationScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const NavigationScreen(),
            );

      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const EditAccountPage(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const EditAccountPage());

      case Routes.festivalDetailsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const FestivalDetailsScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const FestivalDetailsScreen(),
            );
      case Routes.termsAndConditionsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const TermsAndConditionsScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const TermsAndConditionsScreen(),
            );
      case Routes.privacyPolicyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const PrivacyPolicyScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const PrivacyPolicyScreen(),
            );
      case Routes.helpAndSupportScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const HelpAndSupportScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(
              builder: (context) => const HelpAndSupportScreen(),
            );
      case Routes.blockUserScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
              widget: const BlockUserScreen(),
              settings: settings,
            )
            : CupertinoPageRoute(builder: (context) => const BlockUserScreen());

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
    : super(
        settings: settings,
        reverseTransitionDuration: const Duration(milliseconds: 1),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return widget;
        },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
            child: child,
          );
        },
      );
}

class ScreenTitle extends StatefulWidget {
  final Widget widget;
  const ScreenTitle({super.key, required this.widget});

  @override
  State<ScreenTitle> createState() => _ScreenTitleState();
}

class _ScreenTitleState extends State<ScreenTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.widget);
  }
}
