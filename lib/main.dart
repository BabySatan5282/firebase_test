import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:new_firebase/repo/auth_repository.dart';
import 'package:new_firebase/screens/home_page/home_page.dart';
import 'package:new_firebase/screens/singin_page/singin_page.dart';
import 'package:new_firebase/screens/singup_page/singup_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc/auth_bloc.dart';
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else {
                  return const SingInPage();
                }
              }),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   MapController controller = MapController(
//     initMapWithUserPosition: false,
//     initPosition:
//         GeoPoint(latitude: 16.82943614665318, longitude: 96.19162794232987),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           controller.addMarker(
//               GeoPoint(
//                   latitude: 16.828470827244857, longitude: 96.19883771948864),
//               markerIcon: const MarkerIcon(
//                 icon: Icon(Icons.local_activity),
//               ));
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: OSMFlutter(
        
//         mapIsLoading: const Center(
//           child: CircularProgressIndicator(),
//         ),
//         showDefaultInfoWindow: false,
//         controller: controller,
//         trackMyPosition: true,
//         initZoom: 15,
//         stepZoom: 1.0,
//         userLocationMarker: UserLocationMaker(
//           personMarker: const MarkerIcon(
//             icon: Icon(
//               Icons.location_on,
//               color: Colors.red,
//               size: 48,
//             ),
//           ),
//           directionArrowMarker: const MarkerIcon(
//             icon: Icon(
//               Icons.double_arrow,
//               size: 48,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
