import 'package:ex_crud_flutter/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/user.dart';

class UserForm extends StatelessWidget {

  UserForm({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final Map<String, String> _form_Map = {};

  void _loadFormData(User user){
    _form_Map["id"] = user.id;
    _form_Map["name"] = user.name;
    _form_Map["email"] = user.email;
    _form_Map["avatarUrl"] = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {

     final User user =  ModalRoute.of(context)?.settings.arguments as User;
     if(user != null){
       _loadFormData(user);
     }

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final validator = _form.currentState?.validate();
              if (validator == true) {
                _form.currentState?.save();
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _form_Map["id"].toString(),
                    name: _form_Map["name"].toString(),
                    email: _form_Map["email"].toString(),
                    avatarUrl: _form_Map["avatarUrl"].toString(),
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _form_Map["name"],
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Nome Inválido!";
                  }
                  return null;
                },
                onSaved: (value) => _form_Map['name'] = value!,
              ),
              TextFormField(
                initialValue: _form_Map["email"],
                decoration: InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "E-mail Inválido!";
                  }
                  return null;
                },
                onSaved: (value) => _form_Map['email'] = value!,
              ),
              TextFormField(
                initialValue: _form_Map["avatarUrl"],
                decoration: InputDecoration(labelText: "Url"),
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Url Inválido!";
                  }
                  return null;
                },
                onSaved: (value) => _form_Map['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
