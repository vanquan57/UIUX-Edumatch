import 'package:flutter/material.dart';

/// Low-Fidelity Colors for Wireframe/Prototype Design
/// Sử dụng các tone xám và màu đơn giản để tập trung vào layout và user flow
class AppColorsLowFi {
  // ===== GRAYSCALE PALETTE =====
  
  // Background Colors
  static const Color bgPrimary = Color(0xFFFFFFFF);      // White - main background
  static const Color bgSecondary = Color(0xFFF8F9FA);    // Light gray - secondary areas
  static const Color bgTertiary = Color(0xFFE9ECEF);     // Medium light gray - cards, sections
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212529);    // Dark gray - main text
  static const Color textSecondary = Color(0xFF6C757D);  // Medium gray - secondary text
  static const Color textPlaceholder = Color(0xFFADB5BD); // Light gray - placeholders
  static const Color textDisabled = Color(0xFFDEE2E6);   // Very light gray - disabled
  
  // Border & Divider Colors
  static const Color borderPrimary = Color(0xFFDEE2E6);  // Light gray - main borders
  static const Color borderSecondary = Color(0xFFE9ECEF); // Very light gray - subtle borders
  static const Color borderActive = Color(0xFF6C757D);   // Medium gray - active/focus borders
  
  // Interactive Elements
  static const Color buttonPrimary = Color(0xFF495057);  // Dark gray - primary buttons
  static const Color buttonSecondary = Color(0xFFE9ECEF); // Light gray - secondary buttons
  static const Color buttonDisabled = Color(0xFFF8F9FA); // Very light gray - disabled buttons
  
  // States & Feedback
  static const Color stateHover = Color(0xFFE9ECEF);     // Light gray - hover state
  static const Color statePressed = Color(0xFFDEE2E6);  // Medium light gray - pressed state
  static const Color stateSelected = Color(0xFF6C757D); // Medium gray - selected state
  
  // Accent Colors (minimal use for important elements)
  static const Color accentPrimary = Color(0xFF007BFF);  // Blue - links, important actions
  static const Color accentSuccess = Color(0xFF28A745);  // Green - success states
  static const Color accentWarning = Color(0xFFFFC107);  // Yellow - warnings
  static const Color accentError = Color(0xFFDC3545);    // Red - errors
  
  // ===== WIREFRAME SPECIFIC =====
  
  // Placeholder Elements
  static const Color placeholderImage = Color(0xFFE9ECEF);
  static const Color placeholderIcon = Color(0xFFADB5BD);
  static const Color placeholderContent = Color(0xFFF8F9FA);
  
  // Layout Helpers (for development/debugging)
  static const Color layoutGrid = Color(0xFFE9ECEF);
  static const Color layoutBounds = Color(0xFFDEE2E6);
  
  // ===== LEGACY COMPATIBILITY =====
  // Map old colors to new low-fi equivalents for easy migration
  
  // Primary Green Colors → Gray equivalents
  static const Color primaryGreen = buttonPrimary;
  static const Color primaryGreenLight = buttonSecondary;
  static const Color primaryGreenDark = textPrimary;
  
  // Secondary colors → Gray equivalents
  static const Color accentGreen = stateSelected;
  static const Color lightGreen = bgTertiary;
  
  // Neutral colors (keep similar mapping)
  static const Color bgDark = textPrimary;
  static const Color bgLight = bgSecondary;
  static const Color textDark = textPrimary;
  static const Color textLight = bgPrimary;
  static const Color textGray = textSecondary;
  static const Color textLightGray = textPlaceholder;
  
  // Basic colors
  static const Color white = bgPrimary;
  static const Color black = textPrimary;
  
  // Utility colors → Use accent colors
  static const Color errorRed = accentError;
  static const Color warningOrange = accentWarning;
  static const Color successGreen = accentSuccess;
  static const Color disabledGray = buttonDisabled;
  
  // Borders and dividers
  static const Color borderColor = borderPrimary;
  static const Color dividerColor = borderSecondary;
  
  // Shadows → Minimal/transparent for low-fi
  static const Color shadowColor = Color(0x08000000); // Very subtle shadow
  
  // ===== HELPER METHODS =====
  
  /// Get text color based on background brightness
  static Color getTextColorForBackground(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 
        ? textPrimary 
        : bgPrimary;
  }
  
  /// Get border color with opacity
  static Color getBorderWithOpacity(double opacity) {
    return borderPrimary.withOpacity(opacity);
  }
  
  /// Get placeholder color for different element types
  static Color getPlaceholderColor(String type) {
    switch (type) {
      case 'image':
        return placeholderImage;
      case 'icon':
        return placeholderIcon;
      case 'content':
        return placeholderContent;
      default:
        return placeholderContent;
    }
  }
}

/// Extension để dễ dàng chuyển đổi giữa full-color và low-fi
extension ColorLowFiExtension on Color {
  /// Convert any color to its low-fi grayscale equivalent
  Color toLowFi() {
    final luminance = computeLuminance();
    if (luminance > 0.9) return AppColorsLowFi.bgPrimary;
    if (luminance > 0.7) return AppColorsLowFi.bgSecondary;
    if (luminance > 0.5) return AppColorsLowFi.bgTertiary;
    if (luminance > 0.3) return AppColorsLowFi.textSecondary;
    return AppColorsLowFi.textPrimary;
  }
}