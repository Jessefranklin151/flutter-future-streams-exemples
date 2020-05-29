import 'dart:async';

import 'package:flutter/material.dart';
import 'package:streams_exemple/pages/streams/streams_bloc.dart';
import 'package:streams_exemple/shared/buttons.dart';

class StreamsPage extends StatefulWidget {
  StreamsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StreamsPageState createState() => _StreamsPageState();
}

class _StreamsPageState extends State<StreamsPage> {
  
  final _bloc = StreamsBloc();

  var textStyle = TextStyle(fontSize: 35);

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<Object>(
            stream: _bloc.stream,
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
