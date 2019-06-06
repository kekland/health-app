import 'package:flutter/material.dart';
import 'package:health_app/design/future_dialog.dart';
import 'package:intl/intl.dart';

var formatter = DateFormat("dd.MM.yyyy");
String dateTimeToString(DateTime dateTime) {
  if (dateTime == null) return "null";
  return formatter.format(dateTime);
}

void showModernDialog(
    {BuildContext context,
    String title,
    String text,
    Widget body,
    List<Widget> actions}) {
  showDialog(
    context: context,
    builder: (_) {
      /*return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(title),
        content: Text(text),
        contentTextStyle: ModernTextTheme.secondary,
        actions: actions,
      );*/

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: FutureDialog(
          data: DialogData(
              title: title, subtitle: text, customBody: body, actions: actions),
        ),
      );
    },
  );
}

void showErrorSnackbar(
    {@required BuildContext context,
    @required String errorMessage,
    Object exception,
    bool showDialog = true}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3),
      action: (showDialog)
          ? SnackBarAction(
              label: "Подробнее",
              onPressed: () {
                showModernDialog(
                  text: exception.toString(),
                  title: 'Ошибка',
                  context: context,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(context).pop(),
                      textColor: Colors.blue,
                    ),
                  ],
                );
              },
            )
          : null,
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );
}

void showErrorSnackbarKeyed(
    {@required GlobalKey<ScaffoldState> key,
    @required String errorMessage,
    @required BuildContext context,
    Object exception,
    bool showDialog = true}) {
  key.currentState.showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3),
      action: (showDialog)
          ? SnackBarAction(
              label: "Подробнее",
              onPressed: () {
                showModernDialog(
                  text: exception.toString(),
                  title: 'Ошибка',
                  context: context,
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Закрыть'),
                      onPressed: () => Navigator.of(context).pop(),
                      textColor: Colors.blue,
                    ),
                  ],
                );
              },
            )
          : null,
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );
}
