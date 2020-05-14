import 'package:flutter/widgets.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final int symbolPerSecond;
  const AnimatedText(
      {Key key,
      this.symbolPerSecond = 25,
      this.text =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'})
      : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  ScrollController _scrollController;
  double _deviceWidth;
  int _duration;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0);
    Future.delayed(Duration(milliseconds: 16), () {
      _deviceWidth = MediaQuery.of(context).size.width;
      _duration = (widget.text.length / widget.symbolPerSecond).round();
      _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Text(
        widget.text,
        overflow: TextOverflow.visible,
        maxLines: 1,
      ),
    );
  }

  Future<void> _animate() async {
    await _scrollController.animateTo(_scrollController.position.maxScrollExtent + _deviceWidth,
        duration: Duration(seconds: _duration), curve: Curves.linear);
    _scrollController.jumpTo(-1*_deviceWidth);
    await _animate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController = null;
    super.dispose();
  }
}
