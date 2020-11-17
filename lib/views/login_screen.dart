import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycars/repository/user_repository.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userRepository = Provider.of<UserRepository>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: FlutterLogo(size: 150),
              ),
              StreamBuilder<UserState>(
                stream: userRepository.user,
                initialData: UnloggedState.singleton,
                builder: (context, snapshot) {
                  switch (snapshot.data.runtimeType) {
                    case UnloggedState:
                      return _buildButton(context);
                    case LoggingInState:
                      return _buildLoading(context);
                    default:
                      return Text('No data!');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) => OutlineButton(
    onPressed: () {
      var repository = Provider.of<UserRepository>(context, listen: false);
      repository.logInWithGoogle()
          .catchError((_) => Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Text('Houve um erro ao fazer o login!'),
          )
        )
      );
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    borderSide: BorderSide(color: Colors.green),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("images/google_logo.png"), height: 35),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Entrar com o Google', style: TextStyle(fontSize: 20, color: Colors.green)),
          )
        ],
      ),
    ),
  );

  Widget _buildLoading(BuildContext context) => CircularProgressIndicator();

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

}