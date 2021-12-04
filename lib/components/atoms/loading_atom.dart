import 'package:flutter/material.dart';

class LoadingWidget {
  static showDefaultDialog({
    required BuildContext context,
    String message = 'Loading...',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Row(
              children: <Widget>[
                const Center(
                  child: CircularProgressIndicator(),
                ),
                Container(
                  width: 15.0,
                ),
                Text(message),
              ],
            ),
          ],
        );
      },
    );
  }
}
