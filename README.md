# white_noise

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

was add C:\flutter_projects\white_noise\android\app\src\main\AndroidManifest.xml => <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
also add C:\flutter_projects\white_noise\android\app\build.gradle => multiDexEnabled true  && dependencies {
    implementation 'com.android.support:multidex:2.0.1 ' &&  android:usesCleartextTraffic="true" in activity
}// add here

