import 'package:ex_crud_flutter/Models/user.dart';
import 'package:ex_crud_flutter/provider/users_provider.dart';
import 'package:ex_crud_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  //const UserTile({Key? key}) : super(key: key);
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final UsersProvider users_p = Provider.of(context, listen: false);
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.USER_FORM,
                    arguments: user,
                  );
                },
                color: Colors.blue,
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Excluir Usuario"),
                      content: Text("Tem certeza ?"),
                      actions: [
                        IconButton(
                          onPressed: () {Navigator.of(context).pop("Cancelado");},
                          icon: Icon(Icons.cancel),
                          
                        ),
                        IconButton(
                          onPressed: () {users_p.remove(user);Navigator.of(context).pop("Apagado");},
                          icon: Icon(Icons.domain_verification),
                        ),
                      ],
                    ),
                  ).then((confirmed) {
                    var snackBar = SnackBar(content: Text(confirmed.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });

                },
                color: Colors.red,
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
