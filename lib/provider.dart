import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/database/transecsonDB.dart';
import 'package:sembast/sembast.dart';

class pod {
  int id;
  String title, subtitle;
  pod(this.title, this.subtitle, {this.id = 99}) {}
}

class TransecPro with ChangeNotifier {
  List<pod> listpod = [pod("one", "one")];

  List<pod> data() => listpod;
  // transection
  addto(pod newpod) async {
    transectionDB transectiondb = transectionDB("test");
    await transectiondb.addtodb(newpod);
    saveDataToList();
  }

  Future saveDataToList() async {
    transectionDB transectiondb = transectionDB("test");

    listpod = await transectiondb.loaddata();
    for (pod i in listpod) {
      print(i.title + i.subtitle);
    }
    print(listpod.length);
    notifyListeners();
  }
}
