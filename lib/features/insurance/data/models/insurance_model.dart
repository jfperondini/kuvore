import 'package:flutter/material.dart';

class InsuranceModel {
  const InsuranceModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.tag,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final String tag;

  static const items = [
    InsuranceModel(title: 'Automóvel', subtitle: 'Proteção para o seu carro', icon: Icons.directions_car_filled_outlined, route: '/automovel', tag: 'WEBVIEW'),
    InsuranceModel(title: 'Residência', subtitle: 'Sua casa mais protegida', icon: Icons.home_work_outlined, route: '/residencia', tag: 'COTAÇÃO'),
    InsuranceModel(title: 'Vida', subtitle: 'Cuidado com quem importa', icon: Icons.favorite_border_rounded, route: '/vida', tag: 'COTAÇÃO'),
    InsuranceModel(title: 'Acidentes Pessoais', subtitle: 'Proteção para imprevistos', icon: Icons.health_and_safety_outlined, route: '/acidentes', tag: 'COTAÇÃO'),
  ];
}
