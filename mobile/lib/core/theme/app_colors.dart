import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Minimaliste Bleu & Blanc
  static const Color primary = Color(0xFF1E40AF); // Bleu professionnel
  static const Color primaryLight = Color(0xFFF0F4FF); // Bleu très clair
  
  // Neutral colors
  static const Color background = Color(0xFFFAFBFC); // Blanc cassé
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE5E7EB); // Gris léger
  static const Color divider = Color(0xFFF3F4F6); // Gris très léger
  
  // Text colors
  static const Color textPrimary = Color(0xFF111827); // Noir profond
  static const Color textSecondary = Color(0xFF6B7280); // Gris moyen
  static const Color textHint = Color(0xFF9CA3AF); // Gris clair
  
  // Status colors - Minimalistes
  static const Color success = Color(0xFF059669); // Vert professionnel
  static const Color warning = Color(0xFFD97706); // Orange professionnel
  static const Color error = Color(0xFFDC2626); // Rouge professionnel
  static const Color info = Color(0xFF0284C7); // Bleu info
  
  // Property status colors
  static const Color available = Color(0xFF4CAF50);
  static const Color rented = Color(0xFF2196F3);
  static const Color maintenance = Color(0xFFFF9800);
  static const Color unavailable = Color(0xFF9E9E9E);
  
  // Payment method colors
  static const Color orangeMoney = Color(0xFFFF6600);
  static const Color airtelMoney = Color(0xFFED1C24);
  static const Color mpesa = Color(0xFF00A65E);
  static const Color bankCard = Color(0xFF1976D2);
}
