import 'dart:async';

import 'package:flutter/material.dart';
import 'package:streams_exemple/shared/buttons.dart';

class StreamsPage extends StatefulWidget {
  StreamsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StreamsPageState createState() => _StreamsPageState();
}

class _StreamsPageState extends State<StreamsPage> {
  var _count = 0;

  _StreamsPageState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      var baseUrl = 'https://picsum.photos/id/$_count/300/300';
      if (_count >= 20) {
        _controller.close();
      } else {
        _controller.sink.add(baseUrl);
        _count++;
      }
    });
  }

  var textStyle = TextStyle(fontSize: 35);

  final _controller = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<Object>(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Aguardando Stream.',
                        style: textStyle,
                      ),
                      Spacer(),
                      CircularProgressIndicator()
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  'Stream Finalizada.',
                  style: textStyle,
                );
              } else {
                return Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Imagens transmitidas pela stream',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Image.network(
                        snapshot.data,
                        errorBuilder: (context, error, stackTrace) =>
                            Text('Falha no carregamento da imagem'),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
      bottomNavigationBar: Buttons(),
    );
  }
}
