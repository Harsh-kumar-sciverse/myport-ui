import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_port/screens/error_screen.dart';
import 'package:my_port/screens/history.dart';
import 'package:my_port/screens/home.dart';
import 'package:my_port/screens/login.dart';
import 'package:my_port/screens/main_dashboard.dart';
import 'package:my_port/screens/patient_details.dart';
import 'package:my_port/screens/place_sample_screen.dart';
import 'package:my_port/screens/show_gif_video.dart';
import './screens/initialization_screen.dart';
import './constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './provider/sample_provider.dart';
import './screens/view_details.dart';

class MyPort extends StatefulWidget {
  const MyPort({Key? key}) : super(key: key);

  @override
  State<MyPort> createState() => _MyPortState();
}

class _MyPortState extends State<MyPort> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SampleProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppConstants.primaryBlue,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        home: const ShowGifVideo(),
        routes: {
          Login.routeName: (_) => const Login(),
          Home.routeName: (_) => const Home(),
          PlaceSample.routeName: (_) => const PlaceSample(),
          PatientDetails.routeName: (_) => const PatientDetails(),
          ShowGifVideo.routeName: (_) => const ShowGifVideo(),
          History.routeName: (_) => const History(),
          MainDashboard.routeName: (_) => const MainDashboard(),
          ErrorScreen.routeName: (_) => const ErrorScreen(),
          ViewDetails.routeName: (_) => const ViewDetails(),
        },
      ),
    );
  }
}
