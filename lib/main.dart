import 'package:flutter/material.dart';

import 'offices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List  <int> _listIndex = [] ;
  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual JSON Serialisation'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.offices.toString());
            print('Hello ${officesList.runtimeType}');

            return ListView.builder(

              itemCount: snapshot.data!.offices.length,
              itemBuilder: (context, index) {
                final savedValues = _listIndex.contains(index);
                print('Adress: ${snapshot.data!.offices[index].address}');
                return Card(
                  child: ListTile(
                    title: Text('${snapshot.data!.offices[index].name}'),
                    subtitle: Text('${snapshot.data!.offices[index].address}'),

                    leading:
                        Image.network('${snapshot.data!.offices[index].image}'),
                    trailing: Icon(savedValues ? Icons.add_shopping_cart : Icons.add_shopping_cart,
                    color: savedValues ? Colors.red : null),
                    onTap:(){
                      setState(() {if(!savedValues

                      ) {
                        _listIndex.add(index);
                        print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh : ${_listIndex}');
                      }else if (savedValues){
                        _listIndex.remove(index);
                      }
                      });
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('error');
          }
          return Center(child: CircularProgressIndicator());
        },

      ),
    );
  }
}


// Future<http.Response> getData() async {
//   var url = Uri.parse('https://about.google/static/data/locations.json');
//   return await http.get(url);
// }

// void loadData() {
//   getData().then((response){
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print(response.statusCode);
//     }
//   }).catchError((error){
//     debugPrint(error.toString());
//   });
// }
