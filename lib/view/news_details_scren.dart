import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_api/view/home/home_screen.dart';

class NewsDetailsScreen extends StatefulWidget {
  String newsImage;

  String newsTitle;
  String newsAuthor;
  String newsDesc;
  String newsContent;
  String newsSource;
  NewsDetailsScreen(
      {required this.newsImage,
      required this.newsTitle,
      required this.newsAuthor,
      required this.newsDesc,
      required this.newsContent,
      required this.newsSource});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final format =  DateFormat('MMMM dd,yyyy');

  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    //DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(id: 'bbc-news',)));

},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[600],
            )),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: Kheight * 0.45,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: "${widget.newsImage}",
                  //fit: BoxFit.cover ,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text(
                  widget.newsTitle.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      child: Text(
                        widget.newsSource.toString(),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                    ),
                    // Text('${format.format(dateTime)}',
                    // softWrap: true,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: GoogleFonts.poppins( fontSize: 12,
                    //       color: Colors.black87,
                    //       fontWeight: FontWeight.w500),
                    // ),
                  ],
                ),
                Text(widget.newsDesc.toString(),style: GoogleFonts.poppins(fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),),
                        SizedBox(height: Kheight*0.03,),
                        SizedBox(height: Kheight*0.03,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
