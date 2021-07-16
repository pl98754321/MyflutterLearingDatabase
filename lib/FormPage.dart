import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider.dart';
import 'package:provider/provider.dart';

class Formpage extends StatelessWidget {
  const Formpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: Formpagebody(),
    );
  }
}

class Formpagebody extends StatefulWidget {
  const Formpagebody({Key? key}) : super(key: key);

  @override
  _FormpagebodyState createState() => _FormpagebodyState();
}

class _FormpagebodyState extends State<Formpagebody> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final controllerA = TextEditingController();
    final controllerB = TextEditingController();
    List<String> list = [];
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text("Form"),
              TextFormField(
                autofocus: true,
                controller: controllerA,
                validator: (String? str) {
                  if (str == "") {
                    return "กรุณาป้อน";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controllerB,
                validator: (String? str) {
                  if (str == "") {
                    return "กรุณาป้อน";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState?.validate() ?? true) {
                          pod newpod = pod(controllerA.text, controllerB.text);
                          TransecPro provider =
                              Provider.of<TransecPro>(context, listen: false);

                          provider.addto(newpod);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("submit"),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
