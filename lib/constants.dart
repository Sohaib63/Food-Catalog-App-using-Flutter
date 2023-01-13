import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madproject/widgets/show_alert_dialog.dart';
import 'package:madproject/widgets/show_exception_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class Constants {
/*---------------------------------------------------------------------------------------------*/
/*---------------------------------- App Custom Colors ----------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
  static final Color kCustomsColor = Color(0xFFFF5B5B);
  static final color2 = Colors.pink[800];

  static themeIcon(theme, context) {
    return IconButton(
      icon: Icon(
        (theme.theme)
            ? Icons.brightness_7_outlined
            : Icons.brightness_4_outlined,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        theme.switchTheme();
      },
    );
  }

/*---------------------------------------------------------------------------------------------*/
/*---------------------------------- Launch Url Function ----------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
  static Future<void> launchUniversalLink(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(url, forceSafariVC: true);
      }
    }
  }

  static String rate;

/*---------------------------------------------------------------------------------------------*/
/*---------------------------------- Confirm Copy Link ----------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
  static Future<void> confirmCopyLink(BuildContext context,
      {String link,
      @required String title,
      @required String content,
      @required String defaultActionText,
      String cancelActionText}) async {
    final dialogRequestSignOut = await showAlertDialogue(
      context,
      title: title,
      content: content,
      defaultactiontext: defaultActionText,
      cancelactiontext: cancelActionText,
    );
    if (dialogRequestSignOut == true && link != null) {
      Constants.launchUniversalLink(link);
    } else {}
  }

  //-------------------------------------------------------------------/
  //--------------------- Show sign in error --------------------------/
  //-------------------------------------------------------------------/
  static void showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.message == "Sign in aborted by user") {
      return;
    }
    showExceptionAlertDaialog(context,
        title: "Sign In Failed", exception: exception);
  }

  //-------------------------------------------------------------------/
  //----------------- Samir Media Constants --------------------------/
  //-------------------------------------------------------------------/
  static const String facebookLink = "https://github.com/habib-uet";
  static const String websiteLink = "https://github.com/habib-uet";
  static const String twitterLink = "https://github.com/habib-uet";
  static const String instagramLink = "https://github.com/habib-uet";
  static const String githubLink = "https://github.com/habib-uet";
  static const String linkedInLink = "https://github.com/habib-uet";

  static const String facebookUrl = 'https://github.com/habib-uet';
}

double heightOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double widthOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double assignHeight({
  @required BuildContext context,
  @required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (heightOfScreen(context) - (subs) + (additions)) * fraction;
}

double assignWidth({
  @required BuildContext context,
  @required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (widthOfScreen(context) - (subs) + (additions)) * fraction;
}
