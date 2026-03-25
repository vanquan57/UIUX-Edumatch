/// Layout types for flexible UI rendering
enum LayoutType {
  normal, // Standard layout with header, body, footer
  fullscreen, // Full screen without header/footer
  custom, // Custom layout configuration
}

class AppConstants {
  // define role admin, tutor, parent, student
  static const String roleAdmin = 'admin';
  static const String roleTutor = 'tutor';
  static const String roleParent = 'parent';
  static const String roleStudent = 'student';
}
