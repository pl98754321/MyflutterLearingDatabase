import 'package:flutter/material.dart';
import 'package:flutter_application_1/FormPage.dart';
import 'package:flutter_application_1/database/transecsonDB.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return TransecPro();
          },
        )
      ],
      child: MaterialApp(
          title: "titlePLuem",
          home: MyHomepage(),
          theme: ThemeData(primaryColor: Colors.green)),
    );
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  void initState() {
    // TODO: implement initState
    TransecPro provider = Provider.of<TransecPro>(context, listen: false);
    provider.saveDataToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
      ),
      body: Bodywid(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Formpage();
                },
              ),
            );
          },
          label: Row(
            children: [
              Icon(Icons.add),
              Text("เพิ่ม"),
            ],
          )),
    );
  }
}

//
class Bodywid extends StatefulWidget {
  const Bodywid({Key? key}) : super(key: key);

  @override
  _BodywidState createState() => _BodywidState();
}

class _BodywidState extends State<Bodywid> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, TransecPro tran, Widget? child) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: tran.listpod.length,
              itemBuilder: (context, int index) {
                pod eachpod = tran.listpod[index];
                return ListTile(
                  title: Text(eachpod.title),
                  subtitle: Text(eachpod.subtitle),
                  onLongPress: () {
                    TransecPro provider =
                        Provider.of<TransecPro>(context, listen: false);
                    print("delete id = " + eachpod.id.toString());
                    provider.deletedatadb(eachpod.id);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
