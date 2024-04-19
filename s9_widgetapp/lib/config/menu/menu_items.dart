import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle, 
    required this.link, 
    required this.icon
  });
}

const appMenuItem = <MenuItem> [
   MenuItem(
    title: "Botones", 
    subTitle: "Varios", 
    link: "/buttons", 
    icon: Icons.smart_button
  ),
  MenuItem(
    title: "Tarjetas", 
    subTitle: "estiled", 
    link: "/cards", 
    icon: Icons.credit_card
  ),
  MenuItem(
    title: "Progress", 
    subTitle: "Generales", 
    link: "/progress", 
    icon: Icons.refresh_outlined
  ),
  MenuItem(
    title: "SnacKbars", 
    subTitle: "Indicadores", 
    link: "/snack", 
    icon: Icons.info_outline
  ),
  MenuItem(
    title: "Animated", 
    subTitle: "Container", 
    link: "/animated", 
    icon: Icons.animation
  ),

];