import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_apps/News_Repository/news_repository.dart';
import 'package:news_apps/ui/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Filterlist {
  bbcNews,
  aryNews,
  alJazeera,
  cnn,
  googleNews,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  Filterlist? selectedMenu;
  String name = 'bbc-news';
  final format = DateFormat('MMMM dd yyyy');

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.sizeOf(context);

    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset('images/category_icon.png',
                  height: 25, width: 25)),
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<Filterlist>(
                icon: const Icon(Icons.more_vert_outlined),
                initialValue: selectedMenu,
                onSelected: (Filterlist item) {
                  print(item.name);
                  print(Filterlist.alJazeera.name);
                  if (Filterlist.bbcNews == item) {
                   setState(() {
                     name = 'bbc-news';
                   });
                  }
                  if (Filterlist.aryNews == item) {
print('ary newz');
                    setState(() {
                      name = 'ary-news';
                    });
                  }
                  if (Filterlist.alJazeera == item) {
                   setState(() {
                     name = 'al-jazeera-english';
                   });
                  }
//print(name);
              //    print(selectedMenu);
                  setState(() {
                    selectedMenu = item;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Filterlist>>[
                      const PopupMenuItem<Filterlist>(
                          value: Filterlist.bbcNews, child: Text('BBC News')),
                      const PopupMenuItem<Filterlist>(
                          value: Filterlist.aryNews, child: Text('ARY News')),
                      const PopupMenuItem(
                          value: Filterlist.alJazeera,
                          child: Text('AlJazeera News')),
                      const PopupMenuItem(
                          value: Filterlist.cnn,
                          child: Text('CNN News')),
                      const PopupMenuItem(
                          value: Filterlist.googleNews,
                          child: Text('Google News')),
                    ]),
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: dimension.height * 0.55,
              child: FutureBuilder(
                  future: newsViewModel.fetchHeadlinesApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime datetime = DateTime.parse(snapshot
                              .data!.articles[index].publishedAt
                              .toString());

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  height: dimension.height * 0.6,
                                  width: dimension.width * 0.9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles[index].urlToImage
                                          .toString(),
                                      placeholder: (context, url) =>
                                          const SpinKitCircle(
                                        color: Colors.black54,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    height: dimension.height * 0.2,
                                    width: dimension.width * 0.85,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          width: dimension.width * 0.8,
                                          child: Text(
                                            snapshot.data!.articles[index].title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: dimension.width * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles[index]
                                                      .source.name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  format.format(datetime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                  }),
            )
          ],
        ));
  }
}
