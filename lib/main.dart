import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?format=json&key=50df7505";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
    hintColor: Colors.amber,
    primaryColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
      hintStyle: TextStyle(color: Colors.white),
    )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dollar;
  double euro;
  double bitcoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text('Carregando os dados ....',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os dados ...',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                        textAlign: TextAlign.center),
                  );
                } else {
                  dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  bitcoin =
                      snapshot.data['results']['currencies']['BTC']['buy'];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),

                        TextField(
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$  ",
                          ),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),Divider(),
                          TextField(
                          decoration: InputDecoration(
                            labelText: "Dóllares",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "\$  ",
                          ),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),Divider(),
                          TextField(
                          decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "€  ",
                          ),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),Divider(),
                          TextField(
                          decoration: InputDecoration(
                            labelText: "BitCoin",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "BTC  ",
                          ),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
