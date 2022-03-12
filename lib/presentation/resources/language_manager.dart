enum LanguageType { ENGLISH, ARABIC }

const arabic = "ar";
const english = "en";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return english;
      case LanguageType.ARABIC:
        return arabic;
    }
  }
}

class LanguageManager {}
