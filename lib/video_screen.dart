import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'video_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_wall_controller/player_control.dart';
import 'package:video_wall_controller/shimmer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:wakelock/wakelock.dart';

class VideosList extends StatefulWidget {
  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  VlcPlayerController _controller;
  final _key = GlobalKey<VlcPlayerWithControlsState>();
  List<VlcPlayerController> controllers = [];
  List<VideoData> listVideos;
  int selectedVideoIndex;
  bool loopinglist;

  String fileType = 'All';
  var fileTypeList = ['All', 'Image', 'Video', 'Audio','MultipleFile'];
  FilePickerResult result;
  PlatformFile file;
  void pickFiles(String filetype) async {
    switch (filetype) {
      case 'Image':
        result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result == null) return;
        file = result.files.first;
        setState(() {});
        break;
      case 'Video':
        result = await FilePicker.platform.pickFiles(type: FileType.video);
        if (result == null) return;
        file = result.files.first;
        setState(() {});
        break;
      case 'Audio':
        result = await FilePicker.platform.pickFiles(type: FileType.audio);
        if (result == null) return;
        file = result.files.first;
        setState(() {});
        break;
      case 'All':
        result = await FilePicker.platform.pickFiles();
        if (result == null) return;
        file = result.files.first;
        setState(() {});
        break;
      case 'MultipleFile':
        result = await FilePicker.platform.pickFiles(allowMultiple: true);
        if (result == null) return;
        break;
    }
  }

  var pickedFile;
  ImagePicker picker = ImagePicker();

  final imagePicker = ImagePicker();
  File imageFile;
  List Channel = [
    'Gallery',
    'Youtube',
    'Dailymotion',
  ];
  List source = [
    'Gallery videos',
    'Dailymotion videos',
    'Youtube videos',
  ];
  List channelThumbnail = [
    'https://play-lh.googleusercontent.com/Sy_9xv0fpbnc6bJgYM_DGj7-BhleftZgjbeFmvcN5eMGnoizMl2igd5IfJEq82xKZw8',
    'https://i0.wp.com/www.broadbandtvnews.com/wp-content/uploads/2020/03/Dailymotion.jpg?fit=900%2C675&ssl=1',
    'https://variety.com/wp-content/uploads/2020/06/youtube-logo.png?w=999',
  ];
  Future<File> _loadVideoToFs() async {

    pickedFile = await picker.getVideo(source: ImageSource.gallery);
    var jkk = pickedFile.path;
    var temp = File(jkk);
    temp.readAsBytesSync();
    return temp;
  }

  void fillVideos() {
    listVideos = <VideoData>[];
    listVideos.add(VideoData(
      id: 1,
      name: 'Network Video 1',
      path: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
      image: 'https://content.satimagingcorp.com/media2/filer_public_thumbnails/filer_public/b8/3b/b83b4782-bd4f-404f-badf-0bc160cdd959/cms_page_media1530sentinel-2.jpeg__400.0x305.0_q85_subsampling-2.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id:2,
      name: 'Network Video 2',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      image: 'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id:4,
      name: 'Network Video 3',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      image:
          'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 5,
      name: 'Network Video 4',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      image: 'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 6,
      name: 'Network Video 5',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      image: 'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 7,
      name: 'Network Video 6',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      image:
          'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerMeltdowns.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 8,
      name: 'Network Video 7',
      path: 'https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
      image:
          'https://storage.googleapis.com/gtv-videos-bucket/sample/images/SubaruOutbackOnStreetAndDirt.jpg',
      type: VideoType.network,
    ));
      

    listVideos.add(VideoData(
      id: 9,
      name: 'Network Video 8',
      path:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
      image:
          'https://www.cultofmac.com/wp-content/uploads/2010/07/trapster-race.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 10,
      name: 'Network video 9',
      path: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
      image: 'https://carsyeah.com/wp-content/uploads/2016/03/Matt-Farah.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 11,
      name: 'Network video 10',
      path:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      image:
          'https://dok4pfotcdst1.cloudfront.net/crystalgolfresort.com-4150340826/cms/cache/v2/5fb42f1da5514.jpg/1920x1080/fit;c:194,0,3305,1749/80/33c21b3d894c0262dbb4b0b65da46a21.jpg',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 12,
      name: 'Network video 11',
      path:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      image:
          'https://s2.studylib.net/store/data/014923080_1-4df61b38c75caa14050e2e95c286e433.png',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 13,
      name: 'Network video 12',
      path: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
      image: 'https://images-platform.99static.com//6RHLPt606H6QZ-wR_lJbINhRu1k=/0x0:2000x2000/fit-in/500x500/99designs-contests-attachments/99/99892/attachment_99892806',
      type: VideoType.network,
    ));
    listVideos.add(VideoData(
      id: 14,
      name: 'Network video 13',
      path:
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSamJGMNeoy0C7OUeKnexyaXLORsAwu5qRoZw&usqp=CAU',
      type: VideoType.network,
    ));
  }

  StreamSubscription connection;
  bool isoffline;
  @override
  void initState() {
    setState(() {
      Wakelock.enable();
    });
    isoffline = false;
    loopinglist=false;

    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });


    super.initState();
    fillVideos();
    selectedVideoIndex = 0;
    //
    var initVideo = listVideos[selectedVideoIndex];
    for (int i = 0; i <= listVideos.length; i++) {
      if (initVideo.type == VideoType.network) {
        _controller = VlcPlayerController.network(
          initVideo.path,
          hwAcc: HwAcc.full,
          options: VlcPlayerOptions(
            advanced: VlcAdvancedOptions([
              VlcAdvancedOptions.networkCaching(2000),
            ]),
            subtitle: VlcSubtitleOptions([
              VlcSubtitleOptions.boldStyle(true),
              VlcSubtitleOptions.fontSize(30),
              VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
              VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
              // works only on externally added subtitles
              VlcSubtitleOptions.color(VlcSubtitleColor.navy),
            ]),
            http: VlcHttpOptions([
              VlcHttpOptions.httpReconnect(true),
            ]),
            rtp: VlcRtpOptions([
              VlcRtpOptions.rtpOverRtsp(true),
            ]),
          ),
        );
      } else if (initVideo.type == VideoType.file) {
        var file = File(initVideo.path);
        _controller = VlcPlayerController.file(
          file,
        );
      } else if (initVideo.type == VideoType.asset) {
        _controller = VlcPlayerController.asset(
          initVideo.path,
          options: VlcPlayerOptions(),
        );
      } else {
        VideoType.recorded;
      }
      controllers.add(_controller);
      print("<><>><><>FFF<><>FFF><<>DD<><>DDD><><><>${controllers.length}>");
      }
    _controller.addOnInitListener(() async {
      await _controller.startRendererScanning();
    });
    _controller.addOnRendererEventListener((type, id, name) {});
    
  }
     getDuration() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_controller.value.isEnded == true && _controller.value.isPlaying==false &&loopinglist==true ) {
        selectedVideoIndex++;
        setState(()  {
          var count=0;
          selectedVideoIndex;
          count=selectedVideoIndex; 
          _controller.setMediaFromNetwork(
            listVideos[count].path,
            autoPlay: true,
            hwAcc: HwAcc.full
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 12), () {
      getDuration();
    });
    Future<bool> showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the App?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:Text('No'),
            ),
            ElevatedButton(
              onPressed: ()async{
              if (_controller != null) {
               await _controller.stop();
                 SystemNavigator.pop();
              }
              return true;
            },
            child:Text('Yes'),
            ),
          ],
        ),
      )??false;
    }
    
    return WillPopScope( 
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          
          preferredSize: const Size.fromHeight(40.0),
          
          child: AppBar(
            centerTitle: true,
            title: Container(
              child: const Text(
                'Video Wall Controller',
                style: TextStyle(color: Colors.white),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(
                      255,
                      9,
                      13,
                      234,
                    ),
                    Color.fromARGB(255, 7, 223, 14),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
        drawer: navDrawer(),
        body: Wrap(
          direction: Axis.horizontal,
          children: [
            SizedBox(
              height: 340,
              child: VlcPlayerWithControls(
                key: _key,
                controller: _controller,
                onStopRecording: (recordPath) {
                  setState(() {
                    listVideos.add(VideoData(
                      name: 'Recorded Video',
                      path: recordPath,
                      image:'https://www.techjockey.com/blog/wp-content/uploads/2019/09/Best-Call-Recording-Apps_feature.png',
                      type: VideoType.recorded,
                    ));
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'The recorded video file has been added to the end of list.'),
                    ),
                  );
                },
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isoffline==true?  Text("Play All"):Text(""),
              isoffline==true?  
              SizedBox(
                width: 50,
                height: 40,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    value: loopinglist,
                    onChanged: ( value1) {
                      setState(() {
                        loopinglist = !loopinglist;
                      });
                    },
                  ),
                ),
              ):Container(),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: isoffline==true
            ? Column(
              children: [
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listVideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        var video = listVideos[index];
                        return ListTile(
                          dense: true,
                          selected: selectedVideoIndex == index,
                          selectedTileColor: Colors.black54,
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 100,
                              minHeight: 100,
                              maxWidth: 100,
                              minWidth: 100
                            ),
                            child: Image.network(
                              video.image,
                              fit: BoxFit.fill,
                            )
                          ),
                          title: Text(
                            video.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: selectedVideoIndex == index
                              ? Colors.white
                              : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            video.path,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: selectedVideoIndex == index
                              ? Colors.white
                              : Colors.black,
                              ),
                            ),
                            onTap: () async {
                              await _controller.stopRecording();
                              switch (video.type) {
                                case VideoType.network:
                                  await _controller.setMediaFromNetwork(
                                    video.path,
                                    hwAcc: HwAcc.full,
                                  );
                                break;
                                case VideoType.file:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Copying file to temporary storage...'),
                                    ),
                                  );
                                  var tempVideo = await _loadVideoToFs();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Now trying to play...'),
                                    ),
                                  );
                                  if (await tempVideo.exists()) {
                                    await _controller
                                        .setMediaFromFile(tempVideo);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('File load error.'),
                                      ),
                                    );
                                  }
                                break;
                                case VideoType.asset:
                                  await _controller.setMediaFromAsset(video.path);
                                break;
                                case VideoType.recorded:
                                  var recordedFile = File(video.path);
                                  await _controller.setMediaFromFile(recordedFile);
                                break;
                              }
                              setState(() {
                                selectedVideoIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    )
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ):videoListShimmer()
            ),
          ],
        ),
      ),
    );
  }

  Widget navDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset("assets/epazz.PNG",
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Different Channels\n",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.black87
                        )
                      ),
                      TextSpan(
                        text: "Source of videos",
                        style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.black54
                        )
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.blueGrey[900]),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: GestureDetector(
                  onTap: () async {
                    var tempVideo1;
                    Channel[index] == "Gallery"
                    ? tempVideo1 = await _loadVideoToFs()
                    : null;
                    if (await tempVideo1.exists()) {
                      await _controller.setMediaFromFile(tempVideo1);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                100.0,
                              ),
                              child: Image.asset("assets/gallery.png",
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 Channel[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  source[index],
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      )
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
