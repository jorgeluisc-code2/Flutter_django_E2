import 'package:buscador_e2/searchService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  List<dynamic> searchResults = [];

  searchDjango(value) async {
    SearchService.searchDjangoApi(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  searchDjango2(value) async {
    SearchServiceRuc.searchDjangoApi2(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((value) {
          searchResults.add(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build function: ${searchResults.toString()}");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          
          actions: [
            RaisedButton(
                onPressed: () {},
                child: Text('Agregar'),
                color: Colors.redAccent[200],
                textColor: Colors.white)
          ],
          title: Text("Buscador Institutos Calagua"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue[300], Colors.blue])),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.blueAccent[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Text(
                    "Seleccione una institución",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  ),
                  DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text("ONG"),
                          value: "ONG",
                        ),
                        DropdownMenuItem(
                          child: Text("IPREDA"),
                          value: "IPREDA",
                        ),
                        DropdownMenuItem(child: Text("ENIEX"), value: "ENIEX"),
                      ],
                      onChanged: (val) {
                        searchDjango(val);
                        searchResults.clear();
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  searchResults.clear();
                  searchDjango2(val);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Busca aquí por El Ruc',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: null,
                  ),
                ),
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return buildResultCard(searchResults[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Container(
          decoration:
              new BoxDecoration(border: new Border(bottom: new BorderSide())),
          child: ListTile(
            tileColor: Colors.blue,
            title: Text(
              data['nombreInsti'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            hoverColor: Colors.blue,
            //title: Text(data['id'].toString() ?? "Empty"),
            subtitle: Text(
              data['domicilio'],
              style: TextStyle(color: Colors.white),
            ),
            leading: new Icon(
              Icons.account_balance_sharp,
              size: 40,
            ),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
        _buildCard(data)
      ],
    ),
  );
}

Widget _buildCard(data) => SizedBox(
      height: 210,
      child: Card(
        color: Colors.blue[50],
        borderOnForeground: false, // doesn't do anything on true also
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ListTile(
              trailing: Icon(Icons.done),
              selected: true,
              title: Text(data['tipoInstitucion'].toString() ?? "Empty",
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text(data['email']),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Representante :" + data['representante'],
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(
                Icons.accessibility_new_outlined,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text(
                data['ruc'],
              ),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
