// import 'package:kabirumar/provider/verification_masjid_provider.dart';

import 'package:llr/providers/auth_provider.dart';
import 'package:llr/providers/change_pass_provider.dart';
import 'package:llr/providers/reset_pass_provider.dart';
import 'package:llr/providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

var providers = [
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<SignUpProvider>(create: (context) => SignUpProvider()),
  ChangeNotifierProvider<ResetPassProvider>(
    create: (context) => ResetPassProvider(),
  ),
  ChangeNotifierProvider<ChangePassProvider>(
    create: (context) => ChangePassProvider(),
  ),
];
