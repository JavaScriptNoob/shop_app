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
      title: 'Coworking',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _listIndex = [];
  var _myCollection;
  late Future<OfficesList> officesList;

  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coworking'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _dataPushed, icon: const Icon(Icons.list))
        ],
      ),
      body: FutureBuilder<OfficesList>(
        ///// Creates a widget that builds itself based on the latest snapshot of
        /// interaction with a [Future].
        future: officesList, //Parsed json type List(instance)
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            _myCollection = snapshot.data!.offices;
            return ListView.builder(
              itemCount: snapshot.data!.offices.length,
              itemBuilder: (context, index) {
                final savedValues = _listIndex.contains(index);

                return Card(
                  elevation: savedValues ? 10 : 2,
                  color: savedValues ? Colors.white: null,
                  shape: savedValues
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.white70, width: 1),
                        )
                      : null,
                  child: ListTile(
                    title: Text('${snapshot.data!.offices[index].name}'),
                    subtitle: Text('${snapshot.data!.offices[index].address}'),
                    leading:
                        Image.network('${snapshot.data!.offices[index].image}'),
                    trailing: Icon(
                        savedValues
                            ? Icons.train_outlined
                            : Icons.train_outlined,
                        color: savedValues ? Colors.red : null,
                        size: savedValues ? 30.0 : null),
                    onTap: () {
                      setState(() {
                        if (!savedValues) {
                          _listIndex.add(index);

                        } else if (savedValues) {
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

  void _dataPushed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<int> indexes = _listIndex;

      return Scaffold(
          appBar: AppBar(
            title: Text("Hello"),
          ),
          body: ListView.builder(
              itemCount: _listIndex.length,
              itemBuilder: (context, item) {

                return Card(
                    child: ListTile(
                        title: Text('${_myCollection[item].name}'),
                        subtitle: Text('${_myCollection[item].address}'),
                    trailing:Image.network('${_myCollection[item].image}'),
                    ));

              }));
    }));
  }


}

