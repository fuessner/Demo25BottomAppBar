import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final tabs = [
      "Alle",
      "Freunde",
      "Familie",
      "Arbeit"
    ];
    final list = List<String>.generate(1337, (index) => '$index');

    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(title: Text("My ulitmate Chat"),
            bottom: TabBar(
              // isScrollbare teile die Tabs gleichmäßig auf
              isScrollable: false,
              tabs: [
                for (final t in tabs) Tab(text: t,)
              ],
            ),
          ),
          body: TabBarView(
            children: [
              for(final t in tabs)
                Center(
                  // child: Text(t),
                  // alternative:
                  child: ListView.builder(
                      itemBuilder: (context,i ) {
                        return ListTile(
                          title: Text("$t - ${list[i]}"),
                        );
                      },
                  ),
                ),
            ],
          ),
            bottomNavigationBar: _MyAppBar(),

          floatingActionButton: FloatingActionButton(
            onPressed: () => print("FAB"),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //   endDocked,
        )
    );
  }
}


class _MyAppBar extends StatelessWidget {
  // const _MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BottomAppBar(
        color: Theme.of(context).colorScheme.secondary ,
        shape: const CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary,),
          child: Row(
            children: [
              // if (FloatingActionButtonLocation.centerDocked)
              // Spacer(),  Das Menü geht nach rechts
              IconButton(
                tooltip: "Menü öffnen",
                icon: const Icon(Icons.menu),
                  onPressed: () => print("Open Menue here")
              ),
              Spacer(),
              IconButton(
                  tooltip: "Suchen",
                  icon: const Icon(Icons.search),
                  onPressed: () => print("Open search here")
              )
            ],
          ),
        ),
      );
  }
}
