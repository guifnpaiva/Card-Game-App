import 'package:flutter/material.dart';
import 'card.dart';
import 'deck.dart';

List<Deck> listDeck = [
  Deck(
      name: 'Deck #1',
      color: const Color(0xffC24045),
      titleColor: const Color(0xff690202),
      logo: "assets/cardsIcon/asset1.svg",
      gradient: const LinearGradient(
        begin: Alignment(0.0, -1.0),
        end: Alignment(0.0, 1.0),
        colors: [Color(0xffc75355), Color(0xffc24045)],
        stops: [0.0, 1.0],
      ),
      cards: [
        AppCard(descri: "Card 1"),
        AppCard(descri: "Card 2"),
        AppCard(descri: "Card 3"),
        AppCard(descri: "Card 4"),
        AppCard(descri: "Card 5"),
      ],
  ),
  Deck(
    name: 'Deck #2',
    color:  const Color(0xffC6D06D),
    titleColor: const Color(0xff4A8F43),
    logo: "assets/cardsIcon/asset3.svg",
    gradient: const LinearGradient(
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0),
      colors: [Color(0xffC6D06D), Color(0xffC6D06D)],
      stops: [0.0, 1.0],
    ),
    cards: [
      AppCard(descri: "Card 1"),
      AppCard(descri: "Card 2"),
      AppCard(descri: "Card 3"),
      AppCard(descri: "Card 4"),
      AppCard(descri: "Card 5"),

    ],
  ),
  Deck(
    name: 'Deck #3',
    color: const Color(0xff453E85),
    titleColor: const Color(0xff96C9ED),
    logo: "assets/cardsIcon/asset2.svg",
    gradient: const LinearGradient(
      begin: Alignment(0.0, -1.0),
      end: Alignment(0.0, 1.0),
      colors: [Color(0xff585092), Color(0xff453E85)],
      stops: [0.0, 1.0],
    ),
    cards: [
      AppCard(descri: "Card 1"),
      AppCard(descri: "Card 2"),
      AppCard(descri: "Card 3"),
      AppCard(descri: "Card 4"),
      AppCard(descri: "Card 5"),

    ],
  )
];