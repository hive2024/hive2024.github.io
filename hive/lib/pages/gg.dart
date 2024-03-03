import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myhive/common/views.dart';
import 'package:google_sign_in_web/web_only.dart' as web;

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      '879523859407-atvo96rci9vpb89k4gkkbs17rpr8enrv.apps.googleusercontent.com',
  scopes: scopes,
);

class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {
        _currentUser = account;
      });
    });

    // _googleSignIn.signInSilently();
  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      // The user is Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          H16,
          const Text('You are not currently signed in.'),
          H16,
          web.renderButton(),
          // buildSignInButton(
          //   onPressed: _handleSignIn,
          // ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}

// Widget renderButton({web.GSIButtonConfiguration? configuration}) {
//     final web.GSIButtonConfiguration config =
//         configuration ?? web.GSIButtonConfiguration();
//     return FutureBuilder<void>(
//       key: Key(config.hashCode.toString()),
//       future: initialized,
//       builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//         if (snapshot.hasData) {
//           return FlexHtmlElementView2(
//               viewType: 'gsi_login_button',
//               onElementCreated: (Object element) {
//                 _gisClient.renderButton(element, config);
//               });
//         }
//         return const Text('Getting ready');
//       },
//     );
//   }