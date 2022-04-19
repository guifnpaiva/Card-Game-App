import 'package:card_game/model/map.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:sizer/sizer.dart';
import 'game.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<int> gameMode = [];
  List<String> gameModeTitle = [];

  Future<void> fullScreen() async {
    return await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => fullScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // "Choose the..." text
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Align(
                alignment: const Alignment(-0.65, 0),
                child: RichText(
                  text: TextSpan(
                      text: "Choose the\nGame Mode",
                      style: TextStyle(
                          fontFamily: "Madani",
                          fontSize: 25.0.sp,
                          height: 1.1,
                          color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: "\nDrag and tap to select",
                          style: TextStyle(
                            fontSize: 13.0.sp,
                            color: Colors.grey,
                          ),
                        )
                      ]
                  ),
                )
            ),
          ),
          // Card Container
          Container(
            margin: EdgeInsets.only(top: 3.0.h),
            height: 65.0.h,
            child: Swiper(
                itemCount: listDeck.length,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.grey.withOpacity(0.4),
                        activeColor: Colors.black,
                        size: 1.5.w,
                        activeSize: 1.5.w
                    )
                ),
                onTap: (index) {
                  setState(() {
                    if (gameMode.isNotEmpty) {
                      if (gameMode.contains(index)) {
                        gameMode.remove(index);
                      }
                      else {
                        gameMode.add(index);
                      }
                    }
                    else {
                      gameMode.add(index);
                    }
                  });
                },
                onIndexChanged: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                loop: false,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0.h),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: (100.0.w-((60.0.h-5.0.h)/1.42))/2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.0),
                          gradient: listDeck[index].gradient,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ((60.0.h - 5.0.h) / 1.42) * 0.7,
                              height: 30.0.h,
                              child: SvgPicture.asset(
                                listDeck[index].logo,
                                color: listDeck[index].titleColor,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 4.0.h,),
                            Text(
                              listDeck[index].name,
                              style: TextStyle(
                                fontFamily: "Madani",
                                fontSize: 22.0.sp,
                                color: listDeck[index].titleColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
            ),
          ),
          // Mini Cards and Play Button
          Padding(
            padding: EdgeInsets.only(
                top: 2.0.h, right: 10.0.w, left: 10.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Mini Cards
                miniCards(),
                // Button Play
                OutlinedButton(
                    onPressed: () =>
                    {
                      gameModeTitle = [],
                      if(gameMode.isNotEmpty){
                        for(var index in gameMode){
                          gameModeTitle.add(listDeck[index].name)
                        }
                      }
                      else
                        {
                          gameModeTitle.add(listDeck[index].name)
                        },
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Gamepage(gameModes: gameModeTitle)
                          )
                      ),
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide(
                            style: BorderStyle.solid,
                            color: listDeck[index].gradient.colors
                                .last,
                            width: 2.0,
                          ),
                        )
                    ),
                    child: SizedBox(
                      height: 7.0.h,
                      width: 17.0.sp + 12.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Play",
                            style: TextStyle(
                              fontFamily: "Madani",
                              fontSize: 17.0.sp,
                              color: listDeck[index].gradient.colors
                                  .last,
                            ),
                          ),
                          SizedBox(width: 2.0.w,),
                          Expanded(
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: listDeck[index].gradient.colors
                                  .last,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container miniCards(){
    // Mini Cards show when selected
    // If anyone is selected return empty container to prevent resize
    return gameMode.isNotEmpty
      ? Container(
        width: 50.0.w,
        height: 8.0.h,
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Row(
          children: gameMode.map((gameMode) =>
              Container(
                margin: EdgeInsets.only(left: 3.0.w),
                height: 7.0.h,
                width: 7.0.h / 1.42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: listDeck[gameMode].gradient,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ((7.0.h) / 1.42) * 0.2,
                      vertical: 1.0.h
                  ),
                  child: SvgPicture.asset(
                    listDeck[gameMode].logo,
                    color: listDeck[gameMode].titleColor,
                    fit: BoxFit.contain,
                  ),
                ),
              )).toList(),
        ),
      )
      : Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.h),
        height: 8.0.h,
        width: 50.0.w,
      );
  }
}

