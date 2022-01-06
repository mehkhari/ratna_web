import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practice_web/helpers/cartwidget.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // VideoPlayerController? _controller;
  List<CartItem> cart = [];
  void refresh() {
    setState(() {});
  }
  List<String> sequenceOperation=[];

  int index = 0;
  double _position = 0;
  double _buffer = 0;
  bool _lock = true;
  Map<String, VideoPlayerController> _controllers = {};
  Map<int, VoidCallback> _listeners = {};
  Set<String> _urls = {
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#6',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#7',
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_urls.length > 0) {
      _initController(0).then((_) {
        _playController(0);
      });
    }

    if (_urls.length > 1) {
      _initController(1).whenComplete(() => _lock = false);
    }
    log("Initial State--------->");
    /*_controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });*/
  }
  callagain(){
    setState(() {

    });
  }
  VoidCallback _listenerSpawner(index) {
    log("Listener Spawner--------->");
    return () {
      int dur = _controller(index).value.duration.inMilliseconds;
      int pos = _controller(index).value.position.inMilliseconds;
      int buf = _controller(index).value.buffered.last.end.inMilliseconds;

      setState(() {
        if (dur <= pos) {
          _position = 0;
          return;
        }
        _position = pos / dur;
        _buffer = buf / dur;
      });
      if (dur - pos < 1) {
        if (index < _urls.length - 1) {
          _nextVideo();
        }
      }
    };
  }

  VideoPlayerController _controller(int index) {
    log("_controller method--------->");
    return _controllers[_urls.elementAt(index)]!;
  }

  Future<void> _initController(int index) async {
    log("init Controller method--------->");
    var controller = VideoPlayerController.network(_urls.elementAt(index));
    _controllers[_urls.elementAt(index)] = controller;
    await controller.initialize();
  }

  void _removeController(int index) {
    log("Remove Controller method--------->");
    _controller(index).dispose();
    _controllers.remove(_urls.elementAt(index));
    _listeners.remove(index);
  }

  void _stopController(int index) {
    log("Stop Controller--------->");
    _controller(index).removeListener(_listeners[index]!);
    _controller(index).pause();
    _controller(index).seekTo(Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    log("Play Controller--------->");
    if (!_listeners.keys.contains(index)) {
      _listeners[index] = _listenerSpawner(index);
    }
    _controller(index).addListener(_listeners[index]!);
    await _controller(index).play();
    setState(() {});
    setState(() {
    });
  }

  void _nextVideo() async {
    log("Next Video--------->");
    if (_lock || index == _urls.length - 1) {
      return;
    }
    _lock = true;

    _stopController(index);

    if (index - 1 >= 0) {
      _removeController(index - 1);
    }

    _playController(++index);

    if (index == _urls.length - 1) {
      _lock = false;
    } else {
      _initController(index + 1).whenComplete(() => _lock = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Build context--------->");
    return Scaffold(
       /* floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),*/
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                color: Color(0xff1A5276),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name of the Course",style: TextStyle(color: Colors.white,fontSize: 21),),
                const Text("view all courses",style: TextStyle(color: Colors.blue,fontSize: 14),),
                const SizedBox(height: 30,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter Sequence Title',
                    hintStyle: TextStyle(color: Colors.white,fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                    fillColor: Colors.grey.withOpacity(0.2),
                    filled: true,
                    border:const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26,
                        width: 1
                      )
                    )
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      key: UniqueKey(),
                      itemCount: cart.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return CartWidget(
                            cart: cart, index: index, callback: refresh);
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(120, 40),
                          side:  BorderSide(
                              color: Colors.white,
                              width: 1
                          )
                        ),
                        onPressed: (){
                          cart.add(CartItem(
                              productType: "Step",
                              itemName: "Step 1",
                              flavor: "1 Time"));
                          setState(() {});
                        },
                        child: Text("Add",style: TextStyle(color: Colors.white),)
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(120, 40)
                      ),
                        onPressed: (){
                        },
                        child: Text("Save")
                    ),
                  ],
                )
              ],
            ),
          )
          ),
          Expanded(
              flex: 3,
              child: Container(
                height: 800,
                color: Color(0xff283747),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Color(0xff283747),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 410,
                      child: Stack(
                        children: [
                          VideoPlayer(_controller(index)),
                          Positioned(
                            bottom: 10,
                            right: 20,
                            child: Row(
                              children: [
                                TextButton(onPressed: (){
                                  if (_urls.length > 0) {
                                    _initController(0).then((_) {
                                      _playController(0);
                                    });
                                  }
                                }, child: Text("Play",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                InkWell(
                                  onTap: ()=> _controller(index).play(),
                                  child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.play_arrow)),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: ()=> _controller(index).pause(),
                                  child:const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.pause)
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text("All Sequences (12)",style: TextStyle(fontSize: 21,color: Colors.white),),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color(0xff5499C7).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 25,
                            ),
                            title: Text("Sequence Title ${index+1}",style: TextStyle(color: Colors.white,fontSize: 18),),
                            subtitle: Text("sequence Flow",style: TextStyle(color: Colors.white,fontSize: 14),),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              )
          )
        ],
      )
    );
  }
}

class CartItem {
  String productType;
  String itemName;
  String flavor;
  CartItem({required this.productType, required this.itemName, required this.flavor});
}