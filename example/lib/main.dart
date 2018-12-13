import 'package:flutter/material.dart';
import 'package:provider_widget/provider_widget.dart';

void main() => runApp(
      ProviderWidget<ProviderStore>(
        child: MyApp(),
        provided: ProviderStore([
          CounterState(),
        ]),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ProviderWidget demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterState counterState;

  @override
  void initState() {
    super.initState();
    counterState = ProviderWidget.of<ProviderStore>(context).get(CounterState);
  }

  void _incrementCounter() {
    setState(() {
      counterState.counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '${counterState.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
            new FlatButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CounterOverviewScreen(),
                    ),
                  ),
              child: Text("See overview"),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class CounterOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterState counterState =
        ProviderWidget.of<ProviderStore>(context).get(CounterState);
    return Scaffold(
      body: Center(
          child: Text(
        "You clicked ${counterState.counter} times",
        style: TextStyle(fontSize: 40.0),
      )),
    );
  }
}

class CounterState implements ProvidedComponent {
  int counter = 0;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

class Api implements ProvidedComponent {
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
