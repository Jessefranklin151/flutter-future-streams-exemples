import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:streams_exemple/core/models/lorem_picsum_data.dart';
import 'package:streams_exemple/shared/buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;

class FuturesPage extends StatefulWidget {
  FuturesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FuturesPageState createState() => _FuturesPageState();
}

class _FuturesPageState extends State<FuturesPage> {
  var textStyle = TextStyle(fontSize: 15);

  var future = http.get('https://picsum.photos/v2/list?page=1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var imgListJson =
                  jsonDecode((snapshot.data as http.Response).body)
                      as List<dynamic>;
              var imgList =
                  imgListJson.map((e) => LoremPicsumImage.fromJson(e));
              return Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'Imagens carregadas quando o Future foi completado.',
                        style: textStyle,
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(),
                      items: imgList
                          .map(
                            (item) => Container(
                              child: Center(
                                child: Image.network(
                                  changeSize(item.downloadUrl),
                                  fit: BoxFit.cover,
                                  width: 1000,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Aguardando Future ser completado.',
                      style: textStyle,
                    ),
                    Spacer(),
                    CircularProgressIndicator()
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Buttons(),
    );
  }

  String changeSize(String url) {
    var http = url.split('//');
    var arr = http[1].split("/");
    var ret = '';

    for (var i = 0; i < arr.length; i++) {
      if (i == arr.length - 1 || i == arr.length - 2) {
        ret += '300';
      } else {
        ret += arr[i];
      }
      ret += '/';
    }

    return http[0] + '//' + ret;
  }
}
