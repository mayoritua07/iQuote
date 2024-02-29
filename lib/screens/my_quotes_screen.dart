import 'dart:math';
import 'package:flutter/material.dart';

Random random = Random();

class MyQuotesScreen extends StatefulWidget {
  const MyQuotesScreen({super.key});

  @override
  State<MyQuotesScreen> createState() => _MyQuotesScreenState();
}

class _MyQuotesScreenState extends State<MyQuotesScreen> {
  bool isGridView = true;
  String quote =
      "This is the quote to be displayed for all eyes to see and ears to hear.";
  int index = 0;
  List<String> quoteList = [];
  Color containerColor = const Color.fromARGB(181, 166, 33, 243);

  bool hasNotes = true;
  bool isFavorite = true;
  bool isPublished = true;

  @override
  void initState() {
    changeContainerColor();
    super.initState();
  }

  void getQuote() {}

  void onNotesButton() {}

  void changeContainerColor() {}

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void previousButton() {
    if (index == 0) {
      return;
    }
    setState(() {
      index--;
      changeContainerColor();
    });
  }

  void nextButton() {
    setState(() {
      index++;
      changeContainerColor();
    });
  }

  void share() {}

  void publishQuote() {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
            icon: Icon(
              isGridView ? Icons.list : Icons.grid_on,
              size: 20,
            ),
          ),
        ],
      ),
      body: isGridView
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: height / 10,
                  child: Center(
                    child: Text("My Quotes",
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.64,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        opacity: 0.7,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          "assets/images/bulb.png",
                        )),
                    color: containerColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 40),
                          child: Text(
                            quote,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Icon(
                          Icons.insert_comment_rounded,
                          color: hasNotes
                              ? const Color.fromARGB(95, 248, 248, 248)
                              : Colors.black38,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: isFavorite
                                      ? Color.fromARGB(232, 244, 67, 54)
                                      : Colors.black38,
                                  size: 30,
                                ),
                                onPressed: toggleFavorite),
                            IconButton(
                              icon: Icon(
                                Icons.publish,
                                color: isPublished
                                    ? const Color.fromARGB(96, 255, 255, 255)
                                    : Colors.black38,
                                size: 30,
                              ),
                              onPressed: publishQuote,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.black38,
                                  size: 30,
                                ),
                                onPressed: share),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 15),
                      child: Text(
                        "~ Itua David",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: onNotesButton,
                        child: const Icon(
                          Icons.insert_comment_rounded,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: previousButton,
                        child: const Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: nextButton,
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                Container(
                  height: height / 10,
                  color: Theme.of(context).colorScheme.background,
                  child: Center(
                    child: Text("My Quotes",
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 25; i++)
                          ListTile(
                            title: const Text("Id: Q. 101"),
                            subtitle: const Text(
                              "This is where the quote begins. It is long and will continue through out",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.red : Colors.black38,
                              size: 20,
                            ),
                            shape: const Border(
                              bottom: BorderSide(style: BorderStyle.solid),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
