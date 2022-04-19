import 'dart:ui';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:card_game/model/card.dart';
import 'package:card_game/model/deck.dart';
import 'package:card_game/model/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Gamepage extends StatefulWidget {
  final List<String> gameModes;

  @override
  _GamepageState createState() => _GamepageState();

  const Gamepage({Key? key,
    required this.gameModes,
  }) : super(key: key);
}

class _GamepageState extends State<Gamepage> {
  List<Container> cards = [];
  bool status = false;
  double maxW = 0;
  double maxH = 80.0.h;
  int len = 0;
  List<Map<String,AppCard>> gameMode = [];

  void loadCards() {
    cards = [];
    gameMode = [];


    // Load from Map.dart the cards
    for (var element in widget.gameModes) {
      Deck deck = listDeck.where((deck) => deck.name == element).first;
      for (var cards in deck.cards) {
        Map<String,AppCard> cartas = {};
        cartas[deck.name] = cards;
        gameMode.add(cartas);
      }
    }

    // Shuffle the cards
    gameMode.shuffle();

    // Create widget for the cards
    for (var item in gameMode) {
      cards.add(
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.0),
                color: listDeck.where((deck) => deck.name == item.keys.first).first.color,
                boxShadow:  [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(4,4)
                  ),
                ]
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: maxH*0.05),
                  height: maxH*0.08,
                  width: maxW*0.70,
                  child: Text(
                    item.keys.first,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Madani",
                      fontSize: 27.0.sp * (maxH/80.0.h),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: maxH*0.02),
                  height: maxH*0.66,
                  width: maxW*0.70,
                  child:  Text(
                    item.values.first.descri,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Madani",
                      fontSize: 15.0.sp *(maxH/80.0.h),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    // Insert Last Card (End Game)
    cards.insert(
        0,
        endGameCard(),
    );
  }

  void getSize(){
    double size = 80.0.h;
    double descrease = 0.2.h;

    for (int i = 0; i < 200; i++){
      if((size-descrease*i)/1.60 <= 98.0.w)
      {
        maxW = (size-descrease*i)/1.60;
        maxH = size-descrease*i;
        break;
      }
    }
  }

  @override
  void initState() {
    // Get the max Height and Weight for the Card in Screen
    getSize();
    // Load Cards/Shuffle
    loadCards();
    // Get the Deck Size
    len = cards.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Double Tap Enable Focus
      onDoubleTap: (){
        setState((){
          status = !status;
        });
      },
      child: Scaffold(
        backgroundColor: status
            ? Colors.grey.withOpacity(0.25)
            : Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer
            SizedBox(height: 4.0.h,),
            // Card
            SizedBox(
                height: maxH,
                width: maxW,
                child: AppinioSwiper(
                  // Even if the last card is swiped, this state reload the
                  // card again
                  onEnd: (){
                    setState(() {
                      cards.add(
                        endGameCard()
                      );
                    });
                  },
                  // Called when a card is swiped
                  onSwipe: (index){
                    setState((){
                      len = cards.length;
                    });
                  },
                  // Cards widget, previously loaded
                  cards: cards,
                )
            ),
            // Buttons
            Padding(
                padding: EdgeInsets.fromLTRB(10.0.w, 4.0.h, 10.0.w, 0),
                child: status
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TODO - Back Button
                          OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  )
                              ),
                              child: SizedBox(
                                height: 7.0.h,
                                width: 17.0.sp + 16.0.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios_sharp,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(width: 2.0.w,),
                                    Expanded(
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                            fontFamily: "Madani",
                                            fontSize: 17.0.sp,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          // TODO - How to Play Button
                          GestureDetector(
                            onTap: () => showHowtoPlay(),
                            child: Text(
                              "How to Play?",
                              style: TextStyle(
                                  fontFamily: "Madani",
                                  fontSize: 17.0.sp,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ],
                )
            ),
            // Spacer
            SizedBox(height: 4.0.h,),
          ],
        ),
      ),
    );
  }

  showHowtoPlay() {
    showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        double size = 40.0.h;
        double maxW = this.maxW;
        double maxH = this.maxH;
        double descrease = 0.2.h;
        for (int i = 0; i < 200; i++){
          if((size-descrease*i)/1.42 <= 70.0.w)
          {
            maxW = (size-descrease*i)/1.42;
            maxH = size-descrease*i;
            break;
          }
        }
        return StatefulBuilder(
          builder: (context, setState) => Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.black.withOpacity(0.4),
              child: SizedBox(
                width: 100.0.h,
                height: 100.0.h,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10.0.w,
                        top: 16.0.h,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: 80.0.w,
                          height: 50.0.h,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.0.h ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              width: 80.0.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("How to Play ?",
                                    style: TextStyle(
                                      fontFamily: "Madani",
                                      fontSize: 15.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 1.0.h,),
                                  Text("Description",
                                    style: TextStyle(
                                      fontFamily: "Madani",
                                      fontSize: 13.0.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 68.0.h,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SizedBox(
                            width: 5.5.h,
                            height: 5.5.h,
                            child: Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: Colors.grey,
                              size: 5.5.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        );
      },
    );
  }

  Container endGameCard(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27.0),
          color: const Color(0xffF38121),
          boxShadow:  [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(4,4)
            ),
          ]
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: maxH*0.05),
            height: maxH*0.08,
            width: maxW*0.70,
            child: Text(
              "End Game!",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "Madani",
                fontSize: 27.0.sp * (maxH/80.0.h),
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: maxH*0.02),
            height: maxH*0.5,
            width: maxW*0.70,
            child:  Text(
              "No cards left!",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "Madani",
                fontSize: 15.0.sp *(maxH/80.0.h),
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: maxH*0.03,
                left: maxW*0.1,
                right: maxW*0.1
            ),
            child: OutlinedButton(
                onPressed: () {setState(() {
                  loadCards();
                });},
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.white,
                        width: 2.0,
                      ),
                    )
                ),
                child: SizedBox(
                  height: 7.0.h,
                  width: 17.0.sp + 18.0.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 2.0.w,),
                      Expanded(
                        child: Text(
                          "Again",
                          style: TextStyle(
                              fontFamily: "Madani",
                              fontSize: 17.0.sp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

