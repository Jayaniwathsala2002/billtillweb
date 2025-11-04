// lib/language_manager.dart
enum AppLanguage {
  english,
  sinhala,
  tamil;

  // Convert enum to string for saving
  String toStorageString() {
    switch (this) {
      case AppLanguage.english:
        return 'english';
      case AppLanguage.sinhala:
        return 'sinhala';
      case AppLanguage.tamil:
        return 'tamil';
    }
  }

  // Convert display name (from navbar) to enum
  static AppLanguage fromDisplayName(String name) {
    switch (name) {
      case 'Sinhala':
        return AppLanguage.sinhala;
      case 'Tamil':
        return AppLanguage.tamil;
      default:
        return AppLanguage.english;
    }
  }

  // Convert storage string back to enum
  static AppLanguage fromStorageString(String? value) {
    switch (value) {
      case 'sinhala':
        return AppLanguage.sinhala;
      case 'tamil':
        return AppLanguage.tamil;
      default:
        return AppLanguage.english;
    }
  }
}
