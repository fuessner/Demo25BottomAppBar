import 'package:demo20navigation/Tabbar.dart';
import 'package:flutter/material.dart';
import 'Tabbar.dart';

// Video
// https://www.youtube.com/watch?v=S0SPcUrZaZQ&list=PLNmsVeXQZj7qokXX4II7FCZthJcrirT4o

void main() {
  // WIR STARTEN JETZT DAS PROGRAMM VON TABBAR.DART
  //  runApp(TabBarDemo());
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Um das Menü einzubinden machen wir direkt im home: ein
      // widget rein.
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home:  TabBarDemo() // DrawerExample(restorationID: "0",)
    );
  }
}

// Für das Untere Menü brauchen wir noch eine Klasse
// Wir haben hier ja nur ein Widget ganz am Anfang geschrieben
// Ein Widget kann sich zustände nicht merken. Aus diesem Grunde
// fügen wir für das Bottom Menü noch ein STFUL ein damit dieses
// widget voll funktionieren kann.
// -------------------------------------------------------------

class DrawerExample extends StatefulWidget {
    const DrawerExample ({Key? key, required this.restorationID}) : super(key: key);

  final String restorationID;

  @override
  State<StatefulWidget> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample>  with RestorationMixin {
  // der RestorationMixin wird für die RestorableInt benötigt.
  // RestorableInt ist ein Integer der wieder hergestellt werden kann.
  final RestorableInt _currentIndex = RestorableInt(0);
  @override

    Widget build(BuildContext context) {
      // drawer besteht eigentlich aus einer Liste. Weil es letztendlich
      // ein Menü ist.
      final drawerElements = ListView(
        children: [
          // Ganz oben könnte jetzt ein DrawerHeader stehen
          // Da würden dann die Infos zum User stehen. Hier im Beispiel
          // machen wir einen DrawerHeader
          UserAccountsDrawerHeader(accountName: Text("Rolf"),
            accountEmail: Text("Rolf@vmm.de"),
            currentAccountPicture: const
            CircularProgressIndicator(backgroundColor: Colors.black,),
          ),
          ListTile(title: Text("Dashboard"),
            onTap: ()
            {
              print("Tapped");
            },
          ),
          Divider(),
          ListTile(title: Text("Impressum"),),
        ],
      );
      var bottomNavBarItems = const [
           BottomNavigationBarItem(icon: Icon(Icons.account_box),
              label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm),
              label: "Alarm"),
        ];

      return Scaffold(
        appBar: AppBar(
          title: Text("Nav Bar Example"),
          // actions ist ein Menü auf der rechten Seite. Es werden drei
          // Punkte angezeigt
          actions: [
            PopupMenuButton(
                padding: EdgeInsets.zero,
                // für print sollte hier eine funktion aufgerufen werden.
                onSelected: (value ) => print(value),
                // da das PopMenuItem aus verschieden elementen besteht
                // muss <PopupMenuEntry<String>> mit angegeben werden
                itemBuilder: (context) =>  <PopupMenuEntry<String>>[
                  PopupMenuItem<String> (
                      value: "Teilen",
                      child: ListTile(
                          leading: const Icon(Icons.share),
                        title: Text("Teilen"),
                      )
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                      value: "Logout",
                      child: ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text("Logout"),
                      )
                  ),
                ]
            )
          ],
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              print("Inkwell");
            },
            child: Center(
              child: _MyBottomNavView(
                key: UniqueKey(),
                item: bottomNavBarItems[_currentIndex.value],
              )
            ),
          ),
        ),
        // der drawer zeigt dann das Menü
        drawer: Drawer(
          child: drawerElements,
        ),
        // Beispiel für eine kleine AppBar unten:
        // bottomNavigationBar: BottomAppBar(
        //   child: Text("Hello world")),
        bottomNavigationBar:
        BottomNavigationBar(
          showUnselectedLabels: false,
          items: bottomNavBarItems,  // siehe var index oben
          // Der Index ist dafür da, dass wir wissen auf welchen Buttom
          // wir uns gerade befinden. Beim Starten = 0
          currentIndex: _currentIndex.value,
          onTap: (index) {
            setState(() {
              _currentIndex.value = index;
            });
          },
        ),
      );
    }


  // diese beiden klassen dienen dazu um den alten Zustand des Widget
  // wieder herzustellen.
  @override
  String? get restorationId => widget.restorationID;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
  }
}

class _MyBottomNavView extends StatelessWidget {
  _MyBottomNavView({Key? key, required this.item}) : super(key: key);
  final BottomNavigationBarItem item;
  String? myLabel = "";
  @override

  Widget build(BuildContext context)
  {
    myLabel = item.label;
      return Text(myLabel!);
  }

}
// -------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  // @override
  // State<MyHomePage> createState() => _MyAppState();
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState  extends State<MyHomePage> {
  final items = List<String>.generate(50, (i) => "Eintrag ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = "delte me";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold (
        appBar: AppBar (
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
                key: Key(item),
                child:
              ListTile(
              title: Text('$item')
            ),
              // Background ist dafür, wenn wir nach links oder rechts ziehen
              // das der Hintergrund rot wird.
              background: Container(color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30),
              ),
              // Secondary Background ist, wenn man von rechts nach links zieht
              secondaryBackground: Container(color: Colors.blue,
                child: Icon(Icons.save),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
              ),
              // Nachdem ich ein Dismissible deklariert habe kann ich mit der
              // funktion oniDismissen (es wurde gewischt) eine funktion
              // aufrufen.
              onDismissed: (swipewohin) {
                setState(() {
                  items.removeAt(index);
                });
                String msg = "deleted";
                if (swipewohin == DismissDirection.startToEnd)
                  {
                    msg = "deleted";
                  }
                else
                  if (swipewohin == DismissDirection.endToStart)
                  {
                   msg = "saved";
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("$item $msg")
                  )
                );
                }
            );
          }
        ),
      ),
    );
  }

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
