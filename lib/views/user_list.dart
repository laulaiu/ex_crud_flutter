import 'dart:math';

import 'package:ex_crud_flutter/Models/user.dart';
import 'package:ex_crud_flutter/provider/users_provider.dart';
import 'package:ex_crud_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/user_tile.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersProvider users_p = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de usuarios"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.USER_FORM
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: users_p.count,
          itemBuilder: (ctx, i) => UserTile(users_p.byIndex(i)),
        ));
  }
}
