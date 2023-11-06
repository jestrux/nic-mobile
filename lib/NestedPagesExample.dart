import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKeyMain = GlobalKey();

GlobalKey<NavigatorState> navItemOne = GlobalKey();

GlobalKey<NavigatorState> navItemTwo = GlobalKey();

GlobalKey<NavigatorState> navItemThree = GlobalKey();

void main() {
  runApp(const MyApp());
}

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            child: const Text('go'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const PurplePage()),
              );
            },
            child: const Text('log in'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('sign up'),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested Navigation',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKeyMain,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

int _selectedIndex = 0;

class MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin<MyHomePage> {
  @override
  bool get wantKeepAlive => true;

  final List<NavigationDestination> _destinations = [
    const NavigationDestination(
      icon: Icon(Icons.one_k_outlined),
      selectedIcon: Icon(Icons.one_k),
      label: 'one',
    ),
    const NavigationDestination(
      icon: Icon(Icons.two_k_outlined),
      selectedIcon: Icon(Icons.two_k),
      label: 'two',
    ),
    const NavigationDestination(
      selectedIcon: Badge(
        label: Text("10"),
        child: Icon(Icons.three_k),
      ),
      icon: Badge(
        label: Text("10"),
        child: Icon(Icons.three_k_outlined),
      ),
      label: 'three',
    ),
  ];

  final List<Widget> _pages = [
    ScreenOne(
      key: const Key("one"),
      navigatorKey: navItemTwo,
    ),
    ScreenTwo(
      key: const Key("two"),
      navigatorKey: navItemOne,
    ),
    Container(
      color: Colors.green,
    ),
  ];
  PageController _pageController =
      PageController(initialPage: _selectedIndex, keepPage: true);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
      _pageController =
          PageController(initialPage: _selectedIndex, keepPage: true);
    });
  }

  GlobalKey<NavigatorState> _navigatorKey() {
    switch (_selectedIndex) {
      case 0:
        return navItemOne;
      case 1:
        return navItemTwo;
      default:
        return navItemThree;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    NavigationRailLabelType labelType = NavigationRailLabelType.all;

    final isSmallScreen = MediaQuery.of(context).size.width < 720;

    return WillPopScope(
        onWillPop: () async {
          final NavigatorState navigator = _navigatorKey().currentState!;
          if (!navigator.canPop()) {
            return true;
          }
          navigator.pop();
          return false;
        },
        child: isSmallScreen
            ? Scaffold(
                body: NewWidget(pageController: _pageController, pages: _pages),
                bottomNavigationBar: NavigationBar(
                  onDestinationSelected: (int index) {
                    _onItemTapped(index);
                  },
                  selectedIndex: _selectedIndex,
                  destinations: _destinations,
                ),
              )
            : Scaffold(
                body: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        _onItemTapped(index);
                      },
                      labelType: labelType,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.one_k_outlined),
                          selectedIcon: Icon(Icons.one_k),
                          label: Text('one'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.two_k_outlined),
                          selectedIcon: Icon(Icons.two_k),
                          label: Text('two'),
                        ),
                        NavigationRailDestination(
                          selectedIcon: Badge(
                              label: Text("10"), child: Icon(Icons.three_k)),
                          icon: Badge(
                              label: Text("10"),
                              child: Icon(Icons.three_k_outlined)),
                          label: Text('three'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: NewWidget(
                          pageController: _pageController, pages: _pages),
                    )
                  ],
                ),
              ));
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required PageController pageController,
    required List<Widget> pages,
  })  : _pageController = pageController,
        _pages = pages;

  final PageController _pageController;
  final List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: _pages,
    );
  }
}

class ScreenOne extends StatefulWidget {
  const ScreenOne({required this.navigatorKey, required Key? key})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne>
    with AutomaticKeepAliveClientMixin<ScreenOne> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: () async {
        final NavigatorState navigator = navItemThree.currentState!;
        if (!navigator.canPop()) {
          return true;
        }
        navigator.pop();
        return false;
      },
      child: Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BuildContext? desiredContext0;

                        desiredContext0 = navigatorKeyMain.currentContext;

                        Navigator.of(desiredContext0!).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(),
                              body: Container(
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('purple'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(),
                              body: Container(
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('yellow'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BuildContext? desiredContext;

                        desiredContext = widget.navigatorKey.currentContext;

                        Navigator.of(desiredContext!).push(
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(),
                              body: Container(
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('pink'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({required this.navigatorKey, required Key? key})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo>
    with AutomaticKeepAliveClientMixin<ScreenTwo> {
  @override
  bool get wantKeepAlive => true;

  void _push(BuildContext context, String name) {
    BuildContext? desiredContext;

    if (name == 'Page A') {
      desiredContext = widget.navigatorKey.currentContext;

      Navigator.of(desiredContext!).push(
        CupertinoPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Nested screen - Page A'),
            ),
            body: Center(
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const PurplePage()),
                        );
                      },
                      child: const Text("A --> next"))
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      desiredContext = navigatorKeyMain.currentContext;

      Navigator.of(desiredContext!).push(
        CupertinoPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Nested screen - Page B'),
            ),
            body: Center(
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const PurplePage(),
                        ),
                      );
                    },
                    child: const Text("B --> next"),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Navigator(
        key: widget.navigatorKey,
        //   initialRoute: '/',

        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => _push(context, 'Page A'),
                            child: const Text(
                              'Page A',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _push(context, 'Page B'),
                            child: const Text(
                              'Page B',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(
                                navigatorKeyMain.currentContext!,
                              ).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const InitialPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text("Go back to first screen"),
                          )
                        ],
                      ),
                    ),
                  ));
        },
      ),
    );
  }
}

class PurplePage extends StatefulWidget {
  const PurplePage({Key? key}) : super(key: key);

  @override
  State<PurplePage> createState() => _PurplePageState();
}

class _PurplePageState extends State<PurplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.purple,
        ));
  }
}
