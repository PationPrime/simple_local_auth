
## Features

This package provides local auth feature with customizable UI view.

### Important to know

This package depends on [local_auth](https://pub.dev/packages/local_auth) package.

## Usage

## iOS Integration

Note that this plugin works with both Touch ID and Face ID. However, to use the latter,
you need to also add:

```xml
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face id?</string>
```



## Android Integration

\* The plugin will build and run on SDK 16+, but `isDeviceSupported()` will
always return false before SDK 23 (Android 6.0).

### Activity Changes

Note that `local_auth` requires the use of a `FragmentActivity` instead of an
`Activity`. To update your application:

* If you are using `FlutterActivity` directly, change it to
`FlutterFragmentActivity` in your `AndroidManifest.xml`.
* If you are using a custom activity, update your `MainActivity.java`:

    ```java
    import io.flutter.embedding.android.FlutterFragmentActivity;

    public class MainActivity extends FlutterFragmentActivity {
        // ...
    }
    ```

    or MainActivity.kt:

    ```kotlin
    import io.flutter.embedding.android.FlutterFragmentActivity

    class MainActivity: FlutterFragmentActivity() {
        // ...
    }
    ```

    to inherit from `FlutterFragmentActivity`.

### Permissions

Update your project's `AndroidManifest.xml` file to include the
`USE_BIOMETRIC` permissions:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.example.app">
  <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<manifest>
```

### Compatibility

On Android, you can check only for existence of fingerprint hardware prior
to API 29 (Android Q). Therefore, if you would like to support other biometrics
types (such as face scanning) and you want to support SDKs lower than Q,
_do not_ call `getAvailableBiometrics`. Simply call `authenticate` with `biometricOnly: true`.
This will return an error if there was no hardware available.

#### Android theme

Your `LaunchTheme`'s parent must be a valid `Theme.AppCompat` theme to prevent
crashes on Android 8 and below. For example, use `Theme.AppCompat.DayNight` to
enable light/dark modes for the biometric dialog. To do that go to
`android/app/src/main/res/values/styles.xml` and look for the style with name
`LaunchTheme`. Then change the parent for that style as follows:

```xml
...
<resources>
  <style name="LaunchTheme" parent="Theme.AppCompat.DayNight">
    ...
  </style>
  ...
</resources>
...
```

If you don't have a `styles.xml` file for your Android project you can set up
the Android theme directly in `android/app/src/main/AndroidManifest.xml`:

```xml
...
	<application
		...
		<activity
			...
			android:theme="@style/Theme.AppCompat.DayNight"
			...
		>
		</activity>
	</application>
...
```