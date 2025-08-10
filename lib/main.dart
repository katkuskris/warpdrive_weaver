import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis/drive/v3.dart' as drive;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drive Sign-In Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "54279345644-nth0aqr9ameo2mscnfpmfutoctvoq84e.apps.googleusercontent.com", // Web OAuth Client ID
    scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.file', // App-specific Drive access
    ],
  );

  String _status = "Not signed in";

  Future<void> _signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return; // User canceled

      final authClient = await _googleSignIn.authenticatedClient();
      if (authClient == null) return;

      final driveApi = drive.DriveApi(authClient);

      final files = await driveApi.files.list(pageSize: 10);
      setState(() {
        _status = "Signed in as ${account.displayName}, found ${files.files?.length ?? 0} files";
      });
    } catch (e) {
      setState(() {
        _status = "Sign-in failed: $e";
      });
    }
  }

  Widget _googleSignInButton() {
    return ElevatedButton.icon(
      icon: Image.network(
        "https://developers.google.com/identity/images/g-logo.png",
        height: 18,
      ),
      label: const Text("Sign in with Google"),
      onPressed: _signIn,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _googleSignInButton(),
            const SizedBox(height: 20),
            Text(_status),
          ],
        ),
      ),
    );
  }
}
