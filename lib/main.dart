import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycars/repository/user_repository.dart';
import 'package:mycars/routes/Routes.dart';
import 'package:mycars/views/home_screen.dart';
import 'package:mycars/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final UserRepository repository = UserRepository();
  runApp(MultiProvider(
    providers: [
      Provider.value(value: repository),
      StreamProvider.value(value: repository.user, updateShouldNotify: (_, __) => true)
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCars',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.green,
            contentTextStyle: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20)))
        ),
      ),
      routes: {
        Routes.login: (_) => LoginScreen(),
        Routes.home: (_) => HomeScreen()
      },
      home: Consumer<UserState>(
        builder: (context, state, _) {
          if (state is LoggedState) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
