import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class ControlsOverlay extends StatefulWidget {
   ControlsOverlay(
      {Key key, this.controller, this.looping, this.loopingList})
      : super(key: key);

   VlcPlayerController controller;
  
  List<VlcPlayerController> controllers = [];
  final looping;
  final loopingList;
// final VlcPlayerController controller;

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  static const double _playButtonIconSize = 70;
  static const double _replayButtonIconSize = 90;
  static const double _seekButtonIconSize = 38;

  static const Duration _seekStepForward = Duration(seconds: 10);
  static const Duration _seekStepBackward = Duration(seconds: -10);

  static const Color _iconColor = Colors.white;
  bool selection;
  bool forward;
  bool backward;
  @override
  void initState() {
    // TODO: implement initState
    selection = false;
    forward = false;
    backward = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 50),
      reverseDuration: Duration(milliseconds: 200),
      child: Builder(
        builder: (ctx) {
          loopingSingleVideo();
          switch (widget.controller.value.playingState) {
            case PlayingState.initialized:
            //case PlayingState.stopped:
            case PlayingState.paused:
              return SizedBox.expand(
                child: Container(
                  color: Colors.black45,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () => _seekRelative(_seekStepBackward),
                        color: _iconColor,
                        iconSize: _seekButtonIconSize,
                        icon: Icon(Icons.replay_10),
                      ),
                      IconButton(
                        onPressed: _play,
                        color: _iconColor,
                        iconSize: _playButtonIconSize,
                        icon: Icon(Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: () => _seekRelative(_seekStepForward),
                        color: _iconColor,
                        iconSize: _seekButtonIconSize,
                        icon: Icon(Icons.forward_10),
                      ),
                    ],
                  ),
                ),
              );

            case PlayingState.buffering:
            case PlayingState.playing:
              return SizedBox.expand(
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            backward = true;
                            _seekRelative(_seekStepBackward);
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                if (mounted) {
                                  setState(
                                    () {
                                      backward = false;
                                    },
                                  );
                                }
                              },
                            );
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 200,
                          width: 170,
                          child: IconButton(
                            onPressed: () {},
                            color: backward == true
                                ? _iconColor
                                : Colors.transparent,
                            iconSize: _seekButtonIconSize,
                            icon: Icon(Icons.fast_rewind),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            forward = true;
                            _seekRelative(_seekStepForward);
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                if (mounted) {
                                  setState(
                                    () {
                                      forward = false;
                                    },
                                  );
                                }
                              },
                            );
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 200,
                          width: 170,
                          child: IconButton(
                            onPressed: () {},
                            color: forward == true
                                ? _iconColor
                                : Colors.transparent,
                            iconSize: _seekButtonIconSize,
                            icon: Icon(Icons.fast_forward),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );

            //case PlayingState.ended:
            case PlayingState.error:
            case PlayingState.stopped:
              return Center(
                child: FittedBox(
                  child: IconButton(
                    onPressed: _replay,
                    color: _iconColor,
                    iconSize: _replayButtonIconSize,
                    icon: Icon(Icons.replay),
                  ),
                ),
              );

            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<void> _play() {
    return widget.controller.play();
  }

  Future<void> _replay() async {
    await widget.controller.stop();
    await widget.controller.play();
  }

  Future<void> _pause() async {
    if (widget.controller.value.isPlaying) {
      await widget.controller.pause();
    }
  }

  // ignore: missing_return
  Future loopingSingleVideo() {
    widget.controller.addListener(() {
      if (widget.controller.value.playingState == PlayingState.ended &&
          widget.looping == true) {
        widget.controller.stop().then((_) => widget.controller.play());
      }
    });
  }

  Future<void> _seekRelative(Duration seekStep) async {
    if (widget.controller.value.duration != null) {
      await widget.controller
          .seekTo(widget.controller.value.position + seekStep);
      await widget.controller.play();
    }
  }
}
