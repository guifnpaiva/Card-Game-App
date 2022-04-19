import 'package:flutter/material.dart';
import 'card.dart';

class Deck {
  late String name;
  late Color color;
  late Color titleColor;
  late String logo;
  late LinearGradient gradient;
  late List<AppCard> cards;

  Deck({
    required this.name,
    required this.cards,
    required this.color,
    required this.titleColor,
    required this.gradient,
    required this.logo,
  });
}