import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:name_generator/themes/dark_theme_style.dart';
import 'package:name_generator/themes/theme_dark.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState(){
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(_){
      return themeChangeProvider;
    },
    child: Consumer<DarkThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
        title: 'Name Generator',
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        debugShowCheckedModeBanner: false,
        home: const RandomWords());
      }),
    );

    
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              Checkbox(value: themeChange.darkTheme,
               onChanged: (bool? value){
                themeChange.darkTheme = value!;
              }),
            ],
          ),
          Expanded(
            child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              if (i.isOdd) return const Divider();
                
              final index = i ~/ 2;
              if (index >= _suggestions.length) {
                _suggestions.addAll(generateWordPairs().take(10));
              }
              final alreadySaved = _saved.contains(_suggestions[index]);
              return ListTile(
                title: Text(
                  _suggestions[index].asPascalCase,
                  style: _biggerFont,
                ),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                ),
                onTap: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
              );
            },
                  ),
          ),]
      ),
    );
  }
}
