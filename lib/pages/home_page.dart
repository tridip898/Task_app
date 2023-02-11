import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/model/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isMusicOn = true;
  void soundToggle() {
    setState(() {
      isMusicOn == false
          ? _controller.setVolume(0.0)
          : _controller.setVolume(1.0);
      isMusicOn = !isMusicOn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        'https://hajjmanagment.online/get/video/others/1675227513917-92228587.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  //keep API data in this list after fetching
  List<APIModel> apiList = [];

  Future<List<APIModel>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://hajjmanagment.online/api/external/atab/m360ict/get/video/app/test'));
    var jsonData = jsonDecode(response.body.toString());
    for (var apiData in jsonData['data']) {
      final apiModel = APIModel(
          apiData['caption'], apiData['video_url'], apiData['created_at']);
      apiList.add(apiModel);
    }
    return apiList;
  }

  List extraData = [
    ["10:00 p.m.", "10", "122"],
    ["11:25 a.m.", "10", "122"],
    ["03:00 p.m.", "12", "122"],
    ["10:30 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["02:00 a.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
    ["05:00 p.m.", "10", "122"],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          child: Column(
            children: [
              //app bar
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50, shape: BoxShape.circle),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.camera_alt,
                    size: 3.5.h,
                  ),
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      color: Colors.black),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50, shape: BoxShape.circle),
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "lib/icon/notifi.png",
                    height: 3.5.h,
                  ),
                )
              ]),
              // Expanded(child: ListView.builder(
              //     scrollDirection: Axis.vertical,
              //     itemCount: 10,
              //     itemBuilder: (_, index) {
              //       return Container(
              //         height: 40.h,
              //         width: 100.w,
              //         margin: EdgeInsets.symmetric(vertical: 1.h),
              //         decoration: BoxDecoration(
              //             color: Colors.blue.shade50,
              //             borderRadius: BorderRadius.circular(40)),
              //         child: Column(
              //           crossAxisAlignment:
              //           CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               margin: EdgeInsets.only(
              //                   left: 4.w, top: 2.h),
              //               child: Text(
              //                 "Demo one",
              //                 style: TextStyle(
              //                     fontSize: 16.sp,
              //                     fontFamily: "Poppins",
              //                     color: Colors.black),
              //               ),
              //             ),
              //             Container(
              //               margin: EdgeInsets.only(
              //                   left: 4.w, top: 0.5.h),
              //               child: Text(
              //                 extraData[index][0],
              //                 style: TextStyle(
              //                     fontSize: 14.sp,
              //                     fontFamily: "Poppins",
              //                     color: Colors.grey.shade600),
              //               ),
              //             ),
              //             Expanded(
              //                 child: FutureBuilder(
              //                     future:
              //                     _initializeVideoPlayerFuture,
              //                     builder: (context, snapshot) {
              //                       if (snapshot.connectionState ==
              //                           ConnectionState.done) {
              //                         return Container(
              //                           margin: EdgeInsets.all(15),
              //                           child: Stack(children: [
              //                             Positioned(
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                 BorderRadius
              //                                     .circular(40),
              //                                 child: VideoPlayer(
              //                                     _controller),
              //                               ),
              //                             ),
              //                             Positioned(
              //                               top: 1.h,
              //                               right: 4.w,
              //                               child: GestureDetector(
              //                                   onTap: () {
              //                                     soundToggle();
              //                                   },
              //                                   child: Icon(
              //                                     isMusicOn == true
              //                                         ? Icons
              //                                         .volume_up
              //                                         : Icons
              //                                         .volume_off,
              //                                     size: 4.h,
              //                                     color:
              //                                     Colors.white,
              //                                   )),
              //                             ),
              //                             Positioned.fill(
              //                               child: GestureDetector(
              //                                 onTap: () {
              //                                   setState(() {
              //                                     if (_controller
              //                                         .value
              //                                         .isPlaying) {
              //                                       _controller
              //                                           .pause();
              //                                     } else {
              //                                       _controller
              //                                           .play();
              //                                     }
              //                                   });
              //                                 },
              //                                 child: Align(
              //                                   alignment: Alignment
              //                                       .center,
              //                                   child: _controller
              //                                       .value
              //                                       .isPlaying
              //                                       ? Icon(
              //                                     Icons.pause,
              //                                     size: 5.h,
              //                                     color: Colors
              //                                         .white,
              //                                   )
              //                                       : Container(
              //                                     decoration: BoxDecoration(
              //                                         color: Colors
              //                                             .white,
              //                                         shape: BoxShape
              //                                             .circle),
              //                                     child: Icon(
              //                                       Icons
              //                                           .play_arrow,
              //                                       size:
              //                                       4.5.h,
              //                                       color: Colors
              //                                           .grey,
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                             Positioned(
              //                               bottom: 0,
              //                               left: 0,
              //                               right: 0,
              //                               height: 5.5.h,
              //                               child: Container(
              //                                 padding: EdgeInsets
              //                                     .symmetric(
              //                                     horizontal:
              //                                     5.w),
              //                                 decoration: BoxDecoration(
              //                                     color: Colors
              //                                         .white
              //                                         .withOpacity(
              //                                         0.3),
              //                                     borderRadius: BorderRadius.only(
              //                                         bottomLeft: Radius
              //                                             .circular(
              //                                             40),
              //                                         bottomRight:
              //                                         Radius.circular(
              //                                             40))),
              //                                 child: Row(
              //                                   children: [
              //                                     Icon(
              //                                       Icons.chat,
              //                                       color: Colors
              //                                           .white
              //                                           .withOpacity(
              //                                           0.8),
              //                                       size: 3.5.h,
              //                                     ),
              //                                     SizedBox(
              //                                       width: 1.w,
              //                                     ),
              //                                     Text(
              //                                       extraData[index]
              //                                       [1],
              //                                       style: TextStyle(
              //                                           fontSize:
              //                                           14.sp,
              //                                           fontWeight:
              //                                           FontWeight
              //                                               .w500,
              //                                           color: Colors
              //                                               .white
              //                                               .withOpacity(
              //                                               0.8)),
              //                                     ),
              //                                     SizedBox(
              //                                       width: 3.w,
              //                                     ),
              //                                     Icon(
              //                                       Icons.favorite,
              //                                       color: Colors
              //                                           .white
              //                                           .withOpacity(
              //                                           0.8),
              //                                       size: 3.5.h,
              //                                     ),
              //                                     SizedBox(
              //                                       width: 1.w,
              //                                     ),
              //                                     Text(
              //                                       extraData[index]
              //                                       [2],
              //                                       style: TextStyle(
              //                                           fontSize:
              //                                           14.sp,
              //                                           fontWeight:
              //                                           FontWeight
              //                                               .w500,
              //                                           color: Colors
              //                                               .white
              //                                               .withOpacity(
              //                                               0.8)),
              //                                     ),
              //                                     Expanded(
              //                                         child:
              //                                         Container()),
              //                                     Icon(
              //                                       Icons
              //                                           .send_rounded,
              //                                       color: Colors
              //                                           .white
              //                                           .withOpacity(
              //                                           0.8),
              //                                       size: 3.5.h,
              //                                     ),
              //                                     SizedBox(
              //                                       width: 1.w,
              //                                     ),
              //                                     Icon(
              //                                       Icons
              //                                           .bookmark_rounded,
              //                                       color: Colors
              //                                           .white
              //                                           .withOpacity(
              //                                           0.8),
              //                                       size: 3.5.h,
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             )
              //                           ]),
              //                         );
              //                       } else {
              //                         return Center(
              //                           child:
              //                           CircularProgressIndicator(),
              //                         );
              //                       }
              //                     }))
              //           ],
              //         ),
              //       );
              //     })),
              Expanded(
                  child: FutureBuilder(
                      future: fetchData(),
                      builder: (_, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 18,
                              itemBuilder: (_, index) {
                                return Container(
                                  height: 40.h,
                                  width: 100.w,
                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 4.w, top: 2.h),
                                        child: Text(
                                          apiList[index].caption,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: "Poppins",
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 4.w, top: 0.5.h),
                                        child: Text(
                                          extraData[index][0],
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "Poppins",
                                              color: Colors.grey.shade600),
                                        ),
                                      ),
                                      Expanded(
                                          child: FutureBuilder(
                                              future:
                                                  _initializeVideoPlayerFuture,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return Container(
                                                    margin: EdgeInsets.all(15),
                                                    child: Stack(children: [
                                                      Positioned(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: VideoPlayer(
                                                              _controller),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 1.h,
                                                        right: 4.w,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              soundToggle();
                                                            },
                                                            child: Icon(
                                                              isMusicOn == true
                                                                  ? Icons
                                                                      .volume_up
                                                                  : Icons
                                                                      .volume_off,
                                                              size: 4.h,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                      Positioned.fill(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (_controller
                                                                  .value
                                                                  .isPlaying) {
                                                                _controller
                                                                    .pause();
                                                              } else {
                                                                _controller
                                                                    .play();
                                                              }
                                                            });
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: _controller
                                                                    .value
                                                                    .isPlaying
                                                                ? Icon(
                                                                    Icons.pause,
                                                                    size: 6.h,
                                                                    color: Colors
                                                                        .white,
                                                                  )
                                                                : Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    padding: EdgeInsets.all(3),
                                                                    child: Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      size:
                                                                          4.5.h,
                                                                      color: Colors
                                                                          .grey.shade600,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        height: 5.5.h,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.w),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.3),
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          40),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          40))),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.chat,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                size: 3.5.h,
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              Text(
                                                                extraData[index]
                                                                    [1],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8)),
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              Icon(
                                                                Icons.favorite,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                size: 3.5.h,
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              Text(
                                                                extraData[index]
                                                                    [2],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8)),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container()),
                                                              Icon(
                                                                Icons
                                                                    .send_rounded,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                size: 3.5.h,
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .bookmark_rounded,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                                size: 3.5.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                                  );
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              }))
                                    ],
                                  ),
                                );
                              });
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
