import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    routeToFutures() {
      Navigator.of(context).pushReplacementNamed('/futures');
    }

    routeToStream() {
      Navigator.of(context).pushReplacementNamed('/');
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonTheme(
            minWidth: 200.0,
            child: RaisedButton(
              onPressed: routeToFutures,
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text("Future"),
            ),
          ),
          ButtonTheme(
            minWidth: 200.0,
            child: RaisedButton(
              onPressed: routeToStream,
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text("Streams"),
            ),
          ),
        ],
      ),
    );
  }
}
