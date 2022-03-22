import 'package:camera/camera.dart';
import 'package:chats/screens/camera_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  XFile? imageFile;
  XFile? videoFile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isRecording = false;
  String videopath = "";

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }

  void logError(String code, String? message) {
    if (message != null) {
      print('Error: $code\nError Message: $message');
    } else {
      print('Error: $code');
    }
  }

  Future<void>? cameraValue;

  @override
  void initState() {
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController!);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.flash_off, size: 30)),
                        GestureDetector(
                          onLongPress: () async {
                            final _videofile =
                                await _cameraController!.startVideoRecording();

                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () {
                            setState(() {
                              isRecording = false;
                            });
                          },
                          onTap: () {
                            if (!isRecording) {
                              takePhoto(context);
                            }
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 70,
                                ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.flip_camera_ios, size: 30))
                      ]),
                  SizedBox(height: 4),
                  Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<XFile?> takePhoto(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (_cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await _cameraController!.takePicture();
      print(file.path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => CameraViewPage(path: file.path)));
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    // _cameraController!.takePicture(path);
  }

  Future<void> startVideoRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (_cameraController!.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await _cameraController!.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (_cameraController == null ||
        !_cameraController!.value.isRecordingVideo) {
      return null;
    }

    try {
      // final XFile file = await _cameraController!.takePicture();

      return _cameraController!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
