


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:news_api/view_models/news_view_model.dart';

// // import '../../../bloc/news_bloc.dart';
// // import '../../../bloc/news_event.dart';
// // import '../../cateogires_screen.dart';


// enum FilterList { bbcNews, aryNews , independent , reuters, cnn, alJazeera}
// FilterList? selectedMenu ;

// class HomeAppBarWidget extends StatefulWidget {
//   @override
//   State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
// }

// class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
//   //   late  String name;
//   String name = 'bbc-news' ;

//     NewsViewModel newsViewModel = NewsViewModel();

//   @override
//   Widget build(BuildContext context) {
//       print(name);

//     return  AppBar(
//       leading: IconButton(
//         onPressed: (){
//          // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen()));
//         },
//         icon: Image.asset('images/category_icon.png' ,
//           height: 30,
//           width: 30,
//         ),
//       ),
//       title: Text('News' , style: GoogleFonts.poppins(fontSize: 24 , fontWeight: FontWeight.w700),),
//       actions: [
//         PopupMenuButton<FilterList>(
//             initialValue: selectedMenu,
//             icon: Icon(Icons.more_vert , color: Colors.black,),
//             onSelected: (FilterList item){

//               if(FilterList.bbcNews.name == item.name){
//                 name = 'bbc-news' ;
//                                 print(name);
//                                 setState(() {
//                                        newsViewModel.fetchNewsChannelHeadlinesApi(name);

//                                 });
       


//               }
//               if(FilterList.aryNews.name ==item.name){
//                 name  = 'ary-news';
//                 print(name);
//                                   setState(() {
//                                        newsViewModel.fetchNewsChannelHeadlinesApi(name);

//                                 });

//               }

//               if(FilterList.alJazeera.name ==item.name){
//                 name  = 'al-jazeera-english';
//                                 print(name);
//                                                     newsViewModel.fetchNewsChannelHeadlinesApi(name);


//               }
              
//                    // newsViewModel.fetchNewsChannelHeadlinesApi(name);


//               //context.read<NewsBloc>()..add(FetchNewsChannelHeadlines(name));


//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
//               PopupMenuItem<FilterList>(
//                 value: FilterList.bbcNews ,
//                 child: Text('BBC News'),
//               ),
//               PopupMenuItem<FilterList>(
//                 value: FilterList.aryNews ,
//                 child: Text('Ary News'),
//               ),
//               PopupMenuItem<FilterList>(
//                 value: FilterList.alJazeera ,
//                 child: Text('Al-Jazeera News'),
//               ),
//             ]
//         )
//       ],
//     );
//   }
// }