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
  MenuItem(
    title: "UI Controls", 
    subTitle: "controles flutter", 
    link: "/uicontrols", 
    icon: Icons.control_point_duplicate
  ),
  MenuItem(
    title: "Tutorial", 
    subTitle: "onboarding demo", 
    link: "/tutorial", 
    icon: Icons.pages
  ),
  MenuItem(
    title: "Infinite screen", 
    subTitle: "esta es la buena con pull", 
    link: "/infinite", 
    icon: Icons.medical_information
  ),

];