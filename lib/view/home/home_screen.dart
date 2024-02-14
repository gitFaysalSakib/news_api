import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/model/news_channel_headlines_model.dart';
import 'package:news_api/view_models/news_view_model.dart';

import 'home_page_widget/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList {bbcNews,aryNews,independent,abcnews}
class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name= 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    print(height);

    return Scaffold( 
      appBar: PreferredSize(
          preferredSize: Size(0, 59),
          child: HomeAppBarWidget()),
      
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: Image.asset('images/category_icon.png'),
      //   ),
      //   title: Text(
      //     'News',
      //     style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
      //   ),

      //   actions: [
      //     PopupMenuButton<FilterList>(
      //                   initialValue: selectMenu,

      //       onSelected: (FilterList item){
      //         if(FilterList.bbcNews == item.name){
      //           name = 'bbc-news';
      //         }
      //         if(FilterList.abcnews == item.name){
      //           name = 'abc-news';
      //         }
      //         setState(() {
      //           selectMenu = item;
      //         });
      //       },
      //       icon: Icon(Icons.more_vert, color: Colors.black),
      //       itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList> >[
      //         PopupMenuItem(
      //           value: FilterList.bbcNews,
      //           child: Text('BBC News'),),
      //            PopupMenuItem(
      //           value: FilterList.abcnews,
      //           child: Text('ABC News'))

      //       ]
      //       )
      //   ],
      // ),
      body: ListView(
        children: [
          SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final apiDataDisplay =
                                snapshot.data!.articles![index];
                            DateTime dateTime = DateTime.parse(
                                apiDataDisplay.publishedAt.toString());
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * .04,
                                  vertical: height * 0.02),
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.6,
                                      width: width * .9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: height * .02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                            imageUrl: apiDataDisplay.urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                                  child: spinKt2,
                                                ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                                      Icons.error_outline,
                                                      color: Colors.red,
                                                    )),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 20,
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            alignment: Alignment.bottomCenter,
                                            height: height * .22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    apiDataDisplay.title
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Spacer(),
                                                Container(
                                                  width: width * 0.7,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        apiDataDisplay
                                                            .source!.name
                                                            .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Text(
                                                        format.format(dateTime),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

const spinKt2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
