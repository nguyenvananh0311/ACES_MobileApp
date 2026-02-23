### Clean and Upgrade
flutter clean && flutter pub get
### iOS Pod Install
(
  cd ios
  rm -rf Pods Podfile.lock
  pod install --repo-update
)