import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_colors_lowfi.dart';

/// Configuration for switching between full-color and low-fidelity themes
class AppThemeConfig {
  // ===== THEME MODE CONTROL =====
  
  /// Set to true to enable Low-Fidelity mode
  /// Set to false to use full-color design
  static const bool isLowFidelityMode = true;
  
  // ===== COLOR GETTERS =====
  
  /// Get colors based on current theme mode
  static AppColorScheme get colors {
    return isLowFidelityMode ? _lowFiColors : _fullColors;
  }
  
  /// Full-color scheme
  static const AppColorScheme _fullColors = AppColorScheme(
    // Primary Green Colors
    primaryGreen: AppColors.primaryGreen,
    primaryGreenLight: AppColors.primaryGreenLight,
    primaryGreenDark: AppColors.primaryGreenDark,
    
    // Secondary colors
    accentGreen: AppColors.accentGreen,
    lightGreen: AppColors.lightGreen,
    
    // Neutral colors
    bgDark: AppColors.bgDark,
    bgLight: AppColors.bgLight,
    textDark: AppColors.textDark,
    textLight: AppColors.textLight,
    textGray: AppColors.textGray,
    textSecondary: AppColors.textGray,
    textLightGray: AppColors.textLightGray,
    
    // Basic colors
    white: AppColors.white,
    black: AppColors.black,
    
    // Utility colors
    errorRed: AppColors.errorRed,
    warningOrange: AppColors.warningOrange,
    successGreen: AppColors.successGreen,
    disabledGray: AppColors.disabledGray,
    
    // Borders and dividers
    borderColor: AppColors.borderColor,
    dividerColor: AppColors.dividerColor,
    
    // Shadows
    shadowColor: AppColors.shadowColor,
  );
  
  /// Low-fidelity color scheme
  static const AppColorScheme _lowFiColors = AppColorScheme(
    // Primary Green Colors → Gray equivalents
    primaryGreen: AppColorsLowFi.primaryGreen,
    primaryGreenLight: AppColorsLowFi.primaryGreenLight,
    primaryGreenDark: AppColorsLowFi.primaryGreenDark,
    
    // Secondary colors → Gray equivalents
    accentGreen: AppColorsLowFi.accentGreen,
    lightGreen: AppColorsLowFi.lightGreen,
    
    // Neutral colors
    bgDark: AppColorsLowFi.bgDark,
    bgLight: AppColorsLowFi.bgLight,
    textDark: AppColorsLowFi.textDark,
    textLight: AppColorsLowFi.textLight,
    textGray: AppColorsLowFi.textGray,
    textSecondary: AppColorsLowFi.textSecondary,
    textLightGray: AppColorsLowFi.textLightGray,
    
    // Basic colors
    white: AppColorsLowFi.white,
    black: AppColorsLowFi.black,
    
    // Utility colors
    errorRed: AppColorsLowFi.errorRed,
    warningOrange: AppColorsLowFi.warningOrange,
    successGreen: AppColorsLowFi.successGreen,
    disabledGray: AppColorsLowFi.disabledGray,
    
    // Borders and dividers
    borderColor: AppColorsLowFi.borderColor,
    dividerColor: AppColorsLowFi.dividerColor,
    
    // Shadows
    shadowColor: AppColorsLowFi.shadowColor,
  );
  
  // ===== THEME DATA =====
  
  /// Get ThemeData based on current mode
  static ThemeData get themeData {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: colors.white,
      primaryColor: colors.primaryGreen,
      colorScheme: ColorScheme.light(
        primary: colors.primaryGreen,
        secondary: colors.accentGreen,
        surface: colors.white,
        background: colors.bgLight,
        error: colors.errorRed,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.white,
        foregroundColor: colors.textDark,
        elevation: isLowFidelityMode ? 0 : 2,
        shadowColor: colors.shadowColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primaryGreen,
          foregroundColor: colors.textLight,
          elevation: isLowFidelityMode ? 0 : 2,
          shadowColor: colors.shadowColor,
        ),
      ),
    );
  }
}

/// Color scheme class to hold all app colors
class AppColorScheme {
  const AppColorScheme({
    required this.primaryGreen,
    required this.primaryGreenLight,
    required this.primaryGreenDark,
    required this.accentGreen,
    required this.lightGreen,
    required this.bgDark,
    required this.bgLight,
    required this.textDark,
    required this.textLight,
    required this.textGray,
    required this.textSecondary,
    required this.textLightGray,
    required this.white,
    required this.black,
    required this.errorRed,
    required this.warningOrange,
    required this.successGreen,
    required this.disabledGray,
    required this.borderColor,
    required this.dividerColor,
    required this.shadowColor,
  });
  
  // Primary Green Colors
  final Color primaryGreen;
  final Color primaryGreenLight;
  final Color primaryGreenDark;
  
  // Secondary colors
  final Color accentGreen;
  final Color lightGreen;
  
  // Neutral colors
  final Color bgDark;
  final Color bgLight;
  final Color textDark;
  final Color textLight;
  final Color textGray;
  final Color textSecondary; // Alias for textGray
  final Color textLightGray;
  
  // Basic colors
  final Color white;
  final Color black;
  
  // Utility colors
  final Color errorRed;
  final Color warningOrange;
  final Color successGreen;
  final Color disabledGray;
  
  // Borders and dividers
  final Color borderColor;
  final Color dividerColor;
  
  // Shadows
  final Color shadowColor;
}