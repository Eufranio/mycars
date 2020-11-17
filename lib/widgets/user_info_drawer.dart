import 'package:flutter/material.dart';
import 'package:mycars/models/user.dart';
import 'package:mycars/repository/user_repository.dart';
import 'package:provider/provider.dart';

class UserInfoDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<UserState>(context, listen: false) as LoggedState;
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context, state.user),
          Expanded(
            child: _buildInfo(context, state.user),
          ),
          _buildButton(context, state.user),
          _buildVersion(context)
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, User user) => Container(
    width: double.infinity,
    child: DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: CircleAvatar(radius: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(user.photo),
            )
        ),
      ),
    ),
  );

  Widget _buildInfo(BuildContext context, User user) => Column(
    children: [
      ListTile(
        leading: Icon(Icons.edit, color: Colors.orange,),
        title: Text(user.name, style: TextStyle(fontSize: 18)),
      ),
      ListTile(
        leading: Icon(Icons.mail, color: Colors.orange,),
        title: Text(user.email, style: TextStyle(fontSize: 18)),
      )
    ],
  );

  Widget _buildButton(BuildContext context, User user) => RaisedButton.icon(
    icon: Icon(Icons.exit_to_app, color: Colors.white),
    label: Text('Sair', style: TextStyle(color: Colors.white, fontSize: 18)),
    color: Colors.red,
    onPressed: () {
      var repository = Provider.of<UserRepository>(context, listen: false);
      repository.logOut();
    },
  );
  
  Widget _buildVersion(BuildContext context) => Padding(
    padding: EdgeInsets.all(10),
    child: Text('MyCars v1.0.0'),
  );

}