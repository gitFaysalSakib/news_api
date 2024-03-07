import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/model/news_category_model.dart';
import 'package:news_api/model/news_channel_headlines_model.dart';
import 'package:news_api/view/category_screen.dart';
import 'package:news_api/view/news_details_scren.dart';
import 'package:news_api/view_models/news_view_model.dart';

enum FilterList { bbcNews, aryNews, independent, abcnews, alJazeera }

FilterList? selectedMenu;

class HomeScreen extends StatefulWidget {
  String id;
  HomeScreen({required this.id});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String nameNews = 'bbc-news';

  @override
  void initState() {
    super.initState();

    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      appBar:
          //  PreferredSize(preferredSize: Size(0, 59),
          //  child: HomeAppBarWidget(),),
          AppBar(
        leading: IconButton(
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  nameNews = "bbc-news";
                  setState(() {
                    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
                  });
                }
                if (FilterList.aryNews.name == item.name) {
                  nameNews = "ary-news";
                  setState(() {
                    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
                  });
                }

                if (FilterList.abcnews.name == item.name) {
                  nameNews = "abc-news";
                  setState(() {
                    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
                  });
                }
                if (FilterList.independent.name == item.name) {
                  nameNews = "independent";
                  setState(() {
                    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
                  });
                }
                 if (FilterList.alJazeera.name == item.name) {
                  nameNews = "al-jazeera";
                  setState(() {
                    newsViewModel.fetchNewsChannelHeadlinesApi(nameNews);
                  });
                }

                //context.read<NewsBloc>()..add(FetchNewsChannelHeadlines(name));
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text('BBC News'),
                    ),
                    PopupMenuItem<FilterList>(
                      value: FilterList.aryNews,
                      child: Text('Ary News'),
                    ),
                    PopupMenuItem<FilterList>(
                      value: FilterList.abcnews,
                      child: Text('Abcnews'),
                    ),
                    PopupMenuItem<FilterList>(
                      value: FilterList.independent,
                      child: Text('Independent'),
                    ),
                    PopupMenuItem<FilterList>(
                      value: FilterList.alJazeera,
                      child: Text('AlJazeera'),
                    ),
                  ])
        ],
      ),

      //HomeAppBarWidget(name:"name",)),

      body: ListView(
        children: [
          SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi(nameNews),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // print(widget.id);
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
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailsScreen(
                                                        newsTitle:
                                                            apiDataDisplay.title
                                                                .toString(),
                                                        newsImage:
                                                            apiDataDisplay
                                                                .urlToImage
                                                                .toString(),
                                                        newsAuthor:
                                                            apiDataDisplay
                                                                .author
                                                                .toString(),
                                                        newsDesc: apiDataDisplay
                                                            .description
                                                            .toString(),
                                                        newsContent:
                                                            apiDataDisplay
                                                                .content
                                                                .toString(),
                                                        newsSource:
                                                            apiDataDisplay
                                                                .source
                                                                .toString(), pageIdentity: nameNews,
                                                      )));
                                        },

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
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                      imageUrl: apiDataDisplay
                                                          .urlToImage
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                                child: spinKt2,
                                                              ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                            Icons.error_outline,
                                                            color: Colors.red,
                                                          )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        // child: ClipRRect(
                                        //   borderRadius: BorderRadius.circular(15),
                                        //   child: CachedNetworkImage(
                                        //       imageUrl: apiDataDisplay.urlToImage
                                        //           .toString(),
                                        //       fit: BoxFit.cover,
                                        //       placeholder: (context, url) =>
                                        //           Container(
                                        //             child: spinKt2,
                                        //           ),
                                        //       errorWidget:
                                        //           (context, url, error) => Icon(
                                        //                 Icons.error_outline,
                                        //                 color: Colors.red,
                                        //               )),
                                        // ),
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
                  })),
          Padding(
              padding: EdgeInsets.all(20),
              child: FutureBuilder<NewsCategoryModel>(
                  future: newsViewModel.fetchNewsCategoires(nameNews),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // print(widget.id);
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 50,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          shrinkWrap: true,

                          //scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final apiDataDisplay =
                                snapshot.data!.articles![index];
                            DateTime dateTime = DateTime.parse(
                                apiDataDisplay.publishedAt.toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                       Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetailsScreen(
                                                        newsTitle:
                                                            apiDataDisplay.title
                                                                .toString(),
                                                        newsImage:
                                                            apiDataDisplay
                                                                .urlToImage
                                                                .toString(),
                                                        newsAuthor:
                                                            apiDataDisplay
                                                                .author
                                                                .toString(),
                                                        newsDesc: apiDataDisplay
                                                            .description
                                                            .toString(),
                                                        newsContent:
                                                            apiDataDisplay
                                                                .content
                                                                .toString(),
                                                        newsSource:
                                                            apiDataDisplay
                                                                .source
                                                                .toString(), pageIdentity: nameNews,
                                                      )));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            apiDataDisplay.urlToImage.toString(),
                                        fit: BoxFit.cover,
                                        height: height * .18,
                                        width: width * .3,
                                        placeholder: (context, url) => Container(
                                          child: Center(
                                            child: SpinKitCircle(
                                              color: Colors.blue,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          apiDataDisplay.title.toString(),
                                          maxLines: 3,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              apiDataDisplay.source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                            Text(
                                              format.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
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
