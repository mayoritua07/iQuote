import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idea/model/quote.dart';
import 'package:idea/widgets/attachment.dart';
import 'package:idea/widgets/text.dart';

Random random = Random();
final connection = Connectivity();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  int index = 0;
  int queryNumber = 0;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  late Quote quote;
  List<Quote> quotesList = [];

  Future<void> retrieveData() async {
    storage.setMaxDownloadRetryTime(const Duration(minutes: 1));
    Map<String, dynamic> data;
    return db.collection("public").doc("quote$queryNumber").get().then(
        (response) async {
      data = response.data() as Map<String, dynamic>;
      final imageName = data["image"] as String;
      // Use image name with firebase storage to get uint8bytes
      await storage.ref().child("public_images/$imageName").getData().then(
          (value) async {
        final image = MemoryImage(value!);
        if (mounted) {
          await precacheImage(
            image,
            context,
          );
        }
        Quote newQuote = Quote(
            id: data["id"],
            content: data["content"],
            author: data["author"],
            image: image,
            isFavorite: false,
            notes: data["notes"] ?? []);
        quotesList.add(newQuote);
        queryNumber++;
      }, onError: (e) {});

      // if (await connection.checkConnectivity() == ConnectivityResult.none ||
      //     await connection.checkConnectivity() == ConnectivityResult.other) {
      //   if (mounted) {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(const SnackBar(content: Text("No connection")));
      //   }
      //   return;
      // }
    }, onError: (e) {});
  }

  nextQuote() {
    // setState(() {
    //   index++;
    //   _animationController.reset();
    //   _animationController.forward();
    // });
  }

  previousQuote() {
    // if (index > 0) {
    //   setState(() {
    //     index--;
    //     changePicture();
    //     _animationController.reset();
    //     _animationController.forward();
    //   });object
    // }
  }

  void toggleFavorite() {}

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween(begin: 0.2, end: 1.0).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  // Color.fromARGB(255, 194, 197, 206)

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    const List<Color> colorList = [
      Color.fromARGB(255, 54, 69, 79),
      Color.fromRGBO(211, 210, 231, 1)
    ];
    Color mainColor = colorList[isDarkMode ? 1 : 0];
    Color appBarColor = colorList[isDarkMode ? 0 : 1];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            shape: Border(bottom: BorderSide(width: 5, color: mainColor)),
            actions: [
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.offline_bolt,
                      size: 27,
                    ),
                    Text(
                      "Today's Devotional",
                      style: TextStyle(
                        fontSize: 18.spMin,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_rounded, size: 27))
            ],
            leading: IconButton(
              icon: const Icon(Icons.menu, size: 27),
              onPressed: () {
                showModalBottomSheet(
                  elevation: 1,
                  barrierColor: const Color.fromARGB(15, 0, 0, 0),
                  context: context,
                  builder: (ctx) {
                    return Container(
                      decoration: BoxDecoration(color: appBarColor),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/images/devo2.png",
                            width: 30,
                            height: 30,
                            color: mainColor,
                          ),
                          Icon(Icons.person, color: mainColor),
                          Icon(Icons.favorite, color: mainColor),
                          Icon(Icons.info, color: mainColor),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          FutureBuilder(
              future: retrieveData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          Text("Loading data")
                        ],
                      ),
                    ),
                  );
                }
                if (quotesList.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("No internet connection"),
                            const Icon(Icons.wifi_off),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    retrieveData();
                                  });
                                },
                                child: const Text("Reload"))
                          ]),
                    ),
                  );
                }

                quote = quotesList[index];
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            height: height * 0.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 0 ? '"Quote for the day!"' : "",
                                      style: TextStyle(
                                          fontSize: 17.spMin,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 15, color: mainColor),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    FadeTransition(
                                      opacity: _animation as Animation<double>,
                                      child: Text(
                                        quote.author,
                                        style: TextStyle(fontSize: 23.spMin),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.04,
                              right: width * 0.04,
                              bottom: height * 0.02),
                          child: Column(
                            children: [
                              GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity! < 0) {
                                    // swipe to left
                                    nextQuote();
                                  }
                                  if (details.primaryVelocity! > 0) {
                                    // swipe to right
                                    previousQuote();
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  clipBehavior: Clip.hardEdge,
                                  height: height * 0.7,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                    border:
                                        Border.all(color: mainColor, width: 5),
                                    image: DecorationImage(
                                        opacity: 0.8,
                                        fit: BoxFit.cover,
                                        image: quote.image),
                                  ),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: FadeTransition(
                                          opacity:
                                              _animation as Animation<double>,
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              ...quote.content.map((item) {
                                                if (item.runtimeType ==
                                                    String) {
                                                  return MyText(item);
                                                } else {
                                                  if (item["attachmentType"] ==
                                                      "bibleVerse") {
                                                    return Attachment(
                                                        displayText:
                                                            item["tag"],
                                                        url: item["link"],
                                                        type: AttachmentType
                                                            .bibleVerse);
                                                  } else {
                                                    return Attachment(
                                                        displayText:
                                                            item["tag"],
                                                        url: item["link"],
                                                        type: AttachmentType
                                                            .song);
                                                  }
                                                }
                                              })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: appBarColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.favorite,
                                              color: quote.isFavorite
                                                  ? Colors.red
                                                  : null,
                                              size: 27,
                                            ),
                                            onPressed: toggleFavorite,
                                          ),
                                          const SizedBox(
                                            width: 27,
                                          ),
                                          const Icon(
                                            Icons.share,
                                            size: 27,
                                          )
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: quote.notes.isNotEmpty ? 1 : 0.6,
                                      child: CircleAvatar(
                                        backgroundColor: null,
                                        radius: 34.spMin,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.message,
                                            size: 27,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        123, 158, 158, 158)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          label: Text(
                                            "Add a note",
                                            style:
                                                TextStyle(fontSize: 18.spMin),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.file_upload_outlined,
                                        size: 30,
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }, childCount: 1),
                );
              }),
        ],
      ),
    );
  }
}
