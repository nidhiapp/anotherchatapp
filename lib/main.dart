import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes.dart';
import 'package:new_chatapp_chitchat/UIHelpers/routes/routes_name.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/firebase_options.dart';
import 'package:new_chatapp_chitchat/view_models/profile_page_provider.dart';
import 'package:new_chatapp_chitchat/views/home_Screen.dart';
import 'package:new_chatapp_chitchat/views/login_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProfilePageProvider())
      
    ],
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primarycolor),
        useMaterial3: true,
      ),
      
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    ));
  }
}
