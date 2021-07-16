import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class transectionDB {
  //manage database
  String db_name;

  transectionDB(this.db_name);

  Future<Database> openDB() async {
    //find store location
    var location = await getApplicationDocumentsDirectory();
    String dblocation = join(location.path, db_name);
    // create db
    DatabaseFactory dbfactory = await databaseFactoryIo;
    Database db = await dbfactory.openDatabase(dblocation);
    return db;
  }

  Future<int> addtodb(pod pod) async {
    // go to store
    Database db = await this.openDB();
    var store = intMapStoreFactory.store("transection");
    // json
    int keyid =
        await store.add(db, {"title": pod.title, "subtitle": pod.subtitle});
    db.close();
    return keyid;
  }

  Future<List<pod>> loaddata() async {
    Database db = await this.openDB();
    var store = intMapStoreFactory.store("transection");
    var snapshot = await store.find(db);
    List<pod> listpoddb = [];
    for (var data in snapshot) {
      listpoddb.add(pod(data["title"].toString(), data["subtitle"].toString(),
          id: data.key));
    }
    return listpoddb;
  }

  deletedata(int id) async {
    Database db = await this.openDB();
    var store = intMapStoreFactory.store("transection");
    final finder = Finder(filter: Filter.byKey(id));
    store.delete(db, finder: finder);
    //check database
    var snapshot = await store.find(db);
  }
}
