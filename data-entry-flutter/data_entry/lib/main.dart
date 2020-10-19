import 'package:data_entry/feeder.dart';
import 'package:data_entry/fetcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DashBoard(),
  ));
}

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  AnimationController _controller;

  Animation _opacity(b, e) => Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(
        new CurvedAnimation(
          curve: Interval(
            b,
            e,
            curve: Curves.ease,
          ),
          parent: _controller,
        ),
      );

  Animation _translate(b, e) => Tween(
        begin: -50.0,
        end: 0.0,
      ).animate(
        new CurvedAnimation(
          curve: Interval(
            b,
            e,
            curve: Curves.ease,
          ),
          parent: _controller,
        ),
      );

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Entry"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 80.0,
                child: Text(
                  "Cause Data Values alot...",
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                ),
              ),
              Expanded(
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.vertical,
                  children: [
                    Opacity(
                      opacity: _opacity(0.0, 0.7).value,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          _translate(0.0, 0.7).value,
                        ),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green[700],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Feeder(),
                              ),
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.blue[700],
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              alignment: Alignment.center,
                              child: Text(
                                "Feed Data",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _opacity(0.4, 1.0).value,
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          _translate(0.4, 1.0).value,
                        ),
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.green[700],
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Fetcher(),
                              ),
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.blue[700],
                            child: Container(
                              height: 100.0,
                              width: 150.0,
                              alignment: Alignment.center,
                              child: Text(
                                "Fetch Data",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
