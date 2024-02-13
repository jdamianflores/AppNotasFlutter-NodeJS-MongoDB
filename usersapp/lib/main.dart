import 'package:flutter/material.dart'; //diseño material
import 'package:http/http.dart' as http; //peticiones http
import 'dart:async'; //manejar codigo asincrono
import 'dart:convert'; //convertir los datos en formato json

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Map data = {}; //  = new Map()
  List usersData = [];

  getUsers() async {
    var url = Uri.parse('http://10.0.2.2:4000/api/notes'); //localhost
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      usersData = data['notes'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Notas'),
          //backgroundColor: Colors.indigo.shade900,
        ),
        body: ListView.builder(
            itemCount: usersData == null ? 0 : usersData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${usersData[index]["title"]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Contenido: ${usersData[index]["content"]}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Author: ${usersData[index]["author"]}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Fecha: ${usersData[index]["date"]}"),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
