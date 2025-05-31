// File: lib/core/utils/constants/assets_image.dart

// A centralized place to store asset‐image paths as constant strings.
//
// Usage:
//   Image.asset(AssetsImage.amcosTechLogo);
//
// Be sure to declare your image assets in pubspec.yaml under the `flutter:` section:
//
// flutter:
//   assets:
//     - assets/images/amcosTechLogo.png
//     - assets/images/backgroundPattern.png
//     - assets/images/icons/menuIcon.png
//     # …and so on

class AssetsImage {
  // -------------------------------------------------------------------------
  // Add one `static const` for each image in your `assets/images/` folder:
  // -------------------------------------------------------------------------

  static const String amcosTechLogo = 'assets/images/amcosTechLogo.png';

  // Add additional image paths here:
  // static const String anotherImage = 'assets/images/anotherImage.png';
}
