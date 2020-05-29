import 'dart:async';

class StreamsBloc {

  var _count = 0;

  StreamsBloc() {
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

  final _controller = StreamController<String>();

  Stream<String> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

}