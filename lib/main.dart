import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countdown_app/Resources/Firestore_Methods.dart';
import 'package:countdown_app/Views/CountdownSetScreen.dart';
import 'package:countdown_app/Widget/timecar.dart';
import 'package:countdown_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CountDown',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Countdown'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('DateTime').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DateTime dt =
                  (snapshot.data!.docs[index].data()['datetime'] as Timestamp)
                      .toDate();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimeCard(
                    dt: dt,
                    title: snapshot.data!.docs[index].data()['name'],
                    desc: snapshot.data!.docs[index].data()['desc'],
                    id: snapshot.data!.docs[index].data()['id']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CountdownSetScreen(),
            ),
          );
        },
        backgroundColor: buttonColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
