import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Future<String> response = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', response: response),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.response}) : super(key: key);
  final String title;
  final Future<String> response;

  @override
  _MyHomePageState createState() => _MyHomePageState(response);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.response);

  Future<String> response;

  final client = http.Client();
  String link;

  Future<void> buttonClick() async {
    final myCall = await client.get(
        'https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html');
    print('${myCall.statusCode}');
    setState(() {
      response = Future<String>.value(myCall.body.substring(0, 194));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('connect'),
                color: Colors.blue,
                onPressed: buttonClick,
              ),
              FutureBuilder(
                  future: response,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text('Response: ${snapshot.data}');
                    }
                    return Text('Empty');
                  }),
            ],
          ),
        ));
  }
}
