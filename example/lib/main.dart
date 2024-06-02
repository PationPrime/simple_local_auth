import 'package:flutter/material.dart';
import 'package:simple_local_auth/simple_local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LocalAuthView(
        footerTitle: "Log out",
        localizedBiometricsDenyReason: "Failed to recognize",
        onResult: (inputState) {},
        onPinChanged: (value) {},
        pageType: PageType.createPin,
        enterPinTitle: "Unlock with your PIN",
        createPinTitle: "Сreate your PIN code",
        repeatPinTitle: "Repeat your PIN code",
        biometricsUsageDescription: 'Used to provide local auth feature',
        biometricsCancelTitle: 'Cancel',
      ),
    );
  }
}
