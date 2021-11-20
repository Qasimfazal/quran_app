import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/Model/audioSurah.dart';
import 'package:quran_app/customization/animator.dart';
import 'package:quran_app/customization/player.dart';
import 'package:quran_app/customization/textStyles.dart';
import 'package:quran_app/customization/widgets.dart';

class AudioSurahAyats extends StatefulWidget {
  final List<AudioAyat> ayatsList;
  final  urduTranslation;
  final  englishTranslation;
  final String surahName;
  final String surahEnglishName;
  final String englishMeaning;
  final String verses;
  final String type;
  final String ayahNum;
  AudioSurahAyats(
      {this.ayatsList,
        this.englishTranslation,this.urduTranslation,
      this.englishMeaning,
      this.surahEnglishName,
      this.surahName,
      this.verses,
      this.type,
      this.ayahNum});
  @override
  _AudioSurahAyatsState createState() => _AudioSurahAyatsState();
}

class _AudioSurahAyatsState extends State<AudioSurahAyats> {
  var _pageSize = 7;
  ScrollController _controller;
  // final PagingController<int, AudioAyat> _pagingController =
  // PagingController(firstPageKey: 0);
  int x = 0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    super.initState();
  }
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        if(_pageSize < widget.ayatsList.length){
          _pageSize = _pageSize +7;
          if(_pageSize > widget.ayatsList.length){
            int a = _pageSize - widget.ayatsList.length;
            _pageSize = _pageSize - a;
          }
        }else{
          _pageSize = widget.ayatsList.length;
        }
      ///  reach the bottom

      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        /// reach the top
      });
    }
  }
  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     final newItems = widget.ayatsList;
  //     final isLastPage = newItems.length < _pageSize;
  //     if (isLastPage) {
  //       _pagingController.appendLastPage(newItems);
  //     } else {
  //       var nextPageKey = pageKey + newItems.length;
  //       if(nextPageKey == newItems.length){
  //         _pagingController.appendPage(newItems,nextPageKey);
  //       }else{
  //         nextPageKey = nextPageKey - (newItems.length + _pageSize);
  //         _pagingController.appendPage(newItems,nextPageKey);
  //       }
  //     }
  //   } catch (error) {
  //     _pagingController.error = error;
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appBar(context, title: widget.surahName),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                mainContainer(context),
                SizedBox(
                  height: 15,
                ),
            // Container(
            //   height: 500,
            //   child: PagedListView<int, AudioAyat>(
            //     pagingController: _pagingController,
            //     builderDelegate: PagedChildBuilderDelegate<AudioAyat>(
            //       itemBuilder: (context, item, index){
            //         return listItem(width, index);
            //       }
            //     ),
            //   ),
            // ),
                Container(
                  height: MediaQuery.of(context).size.height*0.67,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: _pageSize > widget.ayatsList.length ?widget.ayatsList.length:_pageSize,
                      itemBuilder: (context, index) {
                        return listItem(width, index);
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget listItem(double width, int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: WidgetAnimator(
        Column(
          children: [
            // Container(
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(30)),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Player(
            //       url: widget.ayatsList[index].audio,
            //     ),
            //   ),
            // ),
            ListTile(
              trailing: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Color(0xfff36b5ab),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfff6d9696),
                        offset: Offset(0.0, 0.1),
                        blurRadius: 20,
                        spreadRadius: -1,
                      )
                    ]),
                child: Center(
                  child: Text(
                    widget.ayatsList[index].number.toString(),
                    textAlign: TextAlign.right,
                    style: smallText(color: Colors.white),
                  ),
                ),
              ),
              title: Text(widget.ayatsList[index].text,
                  textAlign: TextAlign.right, style: ayats()),
            ),
            SizedBox(height: 5,),
            ListTile(
              contentPadding: EdgeInsets.zero,

              title: Text(widget.urduTranslation[index].text,
                  textAlign: TextAlign.right, style: ayats()),
            ),
            SizedBox(height: 5,),
            ListTile(

              contentPadding: EdgeInsets.zero,
              title: Text(widget.englishTranslation[index].text,
                  textAlign: TextAlign.left, style: ayats()),

            ),
            SizedBox(height: 3,),
            Divider(color: Theme.of(context).primaryColorDark,),
            SizedBox(height: 3,),
          ],
        ),
      ),
    );
  }

  Widget mainContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            Color(0xfff36b5ab),
            Color(0xfff7dc695),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          boxShadow: [
            BoxShadow(
              color: Color(0xfff6d9696),
              offset: Offset(0.0, 0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ]),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                child: Image.asset(
              'assets/images/layers.png',
              fit: BoxFit.fill,
            )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipPath(
                    // clipper: StarClipper(8),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Theme.of(context).primaryColorDark,
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          widget.ayahNum,
                          style: smallText(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.surahEnglishName,
                    style: headingWhite(),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.englishMeaning,
                    style: normalText(color: Colors.grey[200]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${widget.type} - ${widget.verses} Verses",
                    style: normalText(color: Colors.grey[200]),
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
