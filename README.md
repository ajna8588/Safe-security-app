# Safe Security — Android App

A privacy-first Flutter cybersecurity awareness app.

## Included
- Home dashboard
- Local password-strength checker
- Basic phishing URL heuristic checker
- Scam-awareness alerts
- Security checkup score
- Account safety guides
- Hacked-account recovery checklist
- Dark Material 3 UI

## Important security note
This is an awareness/demo app. The URL checker uses simple local heuristics and cannot guarantee that a URL is safe. For a production app, use a reputable threat-intelligence service with a carefully designed privacy policy and never send user passwords to your server.

## Run on Android

1. Install Flutter SDK and Android Studio.
2. Create the platform folders:
   flutter create .
3. Replace the generated `lib/main.dart` with the included `lib/main.dart`.
4. Run:
   flutter pub get
   flutter run
5. Build an APK:
   flutter build apk --release

The generated APK will normally be at:
build/app/outputs/flutter-apk/app-release.apk

## Recommended next upgrades
- Add official threat-intelligence API integration for URL reputation.
- Add secure local settings using Android Keystore-backed storage if settings need persistence.
- Add verified official recovery links for supported services.
- Add Malayalam + English localization.
- Add privacy policy and consent screens before publishing.
