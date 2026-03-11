# Troubleshooting: Unknown Run Configuration Type

The error **"Unknown run configuration type FlutterRunConfigurationType"** usually occurs because the project is missing the Flutter-specific configuration files (like the `.idea` folder and platform-specific directories `android/`, `ios/`, etc.) required by Android Studio.

Since the project files (`lib/`, `pubspec.yaml`) were created manually without running the initial project generator, Android Studio doesn't recognize this folder as a Flutter project yet.

## Fix Steps

To fix this, you need to generate the missing platform and configuration files. Run the following command in your terminal inside the project directory (`c:\Users\User\Desktop\my app`):

```bash
flutter create .
```

This command will:
1.  Detect the existing `lib/` and `pubspec.yaml`.
2.  Generate the missing `android/`, `ios/`, `web/`, `linux/`, `macos/`, and `windows/` directories.
3.  Generate the `.idea` configuration files for Android Studio.
4.  Run `flutter pub get` to install dependencies.

### Alternative (if `flutter` command is not in path)
If you cannot run `flutter create .` from the terminal:
1.  Open Android Studio.
2.  Select **File > New > New Flutter Project**.
3.  Create a new project in a **different** folder.
4.  Copy the `lib/` folder and `pubspec.yaml` file from this project into your new project, replacing the default ones.
