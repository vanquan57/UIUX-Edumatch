import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_match/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load env
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}