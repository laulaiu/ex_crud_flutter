
import 'dart:math';

import 'package:ex_crud_flutter/Models/user.dart';
import 'package:ex_crud_flutter/data/dummy_users.dart';
import 'package:flutter/cupertino.dart';

//Users é o nome do provider e o User e o modelo
class UsersProvider with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(User user){
    if(user == null){
      return;
    }

    if(user.id != null && user.id.trim().isNotEmpty &&_items.containsKey(user.id)){
      _items.update(user.id, (value) => User(id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl));
    }else{
      final id = (Random().nextInt(990)+10).toString();
      _items.putIfAbsent(id, () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl
      ));
    }

    notifyListeners();

  }


  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
     notifyListeners();
    }
  }


}
