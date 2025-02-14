
import 'package:flutter/widgets.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) :super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void Dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF6CFF03),
          title: const Text(
            'Login',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic
            ),
          ),
          centerTitle: false,
          elevation: 2,
         ),
         body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/download.png',fit: BoxFit.cover),
                ),
                const SizedBox(height: 20),
                const Text(
                  'DolotGunStore',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    child: const Text('User Name'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){
                      print('Button pressed')
                    },
                    child: const Text('Password'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: (){
                      print('Sign In pressed ...')
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF23F400)),
                    child: const Text('Sign In'),
                  )
                  )
                )
              ],
            )),
         ),
        ),
      );
  }
  
  FFButtonOptions({required int height, required EdgeInsetsDirectional padding, required EdgeInsetsDirectional iconPadding, required color, required textStyle, required int elevation, required BorderRadius borderRadius}) {}
}

FFButtonWidget({required Null Function() onPressed, required String text, required options}) {
}

class FlutterFlowTheme {
  static of(BuildContext context) {}
}

class HomePageModel {
  void dispose() {}
}

